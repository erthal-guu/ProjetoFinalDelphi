unit PedidoFornecedorService;

interface

uses
  PedidoFornecedorRepository, PendenciaService, uPendencia, uDMConexao, System.SysUtils, FireDAC.Comp.Client,
  Data.DB, System.Classes, Logs, uSession, System.Generics.Collections;

type
  TPedidoFornecedorService = class
  private
    Repository: TPedidoFornecedorRepository;
    PendenciaServ: TPendenciaService;
  public
    constructor Create;

    // Operações de Pedido
    function SalvarPedido(aIdFornecedor: Integer; aPecasIDs: TList<Integer>;
      aQuantidades: TList<Integer>; aObservacao: String): Boolean;
    function ListarPedidos: TDataSet;
    procedure DeletarPedido(const aId: Integer);
    function PesquisarPedidos(const aFiltro: String): TDataSet;
    function ListarPecasDoPedido(aIdPedido: Integer): TDataSet;

    // Funções de carga para combobox
    function CarregarFornecedores: TStringList;
    function CarregarPecas: TStringList;
    function ObterPrecoCompraPeca(aIdPeca: Integer): Currency;

    // Função de cálculo
    function CalcularValorTotal(aPecasIDs: TList<Integer>; aQuantidades: TList<Integer>): Currency;

    // Validação
    function ValidarPedido(aIdFornecedor: Integer; aPecasIDs: TList<Integer>): Boolean;
  end;

implementation

constructor TPedidoFornecedorService.Create;
begin
  Repository := TPedidoFornecedorRepository.Create(DataModule1.FDQuery);
  PendenciaServ := TPendenciaService.Create;
end;

function TPedidoFornecedorService.SalvarPedido(aIdFornecedor: Integer;
  aPecasIDs: TList<Integer>; aQuantidades: TList<Integer>; aObservacao: String): Boolean;
var
  IDUsuarioLogado: Integer;
  ValorTotal: Currency;
  DataPedido: TDateTime;
  i: Integer;
  NovaPendencia: TPendencia;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarPedido(aIdFornecedor, aPecasIDs) then
  begin
    DataPedido := Now;
    ValorTotal := CalcularValorTotal(aPecasIDs, aQuantidades);

    // Inserir o pedido principal
    Repository.InserirPedido(aIdFornecedor, DataPedido, 'Pendente', aObservacao, ValorTotal);

    // Obter o ID do pedido recém inserido
    Repository.ListarPedidas.Last;
    var IdPedido := Repository.ListarPedidas.FieldByName('id_pedido').AsInteger;

    // Inserir as peças do pedido
    for i := 0 to aPecasIDs.Count - 1 do
    begin
      Repository.InserirPecaPedido(IdPedido, aPecasIDs[i], aQuantidades[i],
        ObterPrecoCompraPeca(aPecasIDs[i]));
    end;

    SalvarLog(Format('CADASTRO - ID: %d cadastrou pedido ao fornecedor ID: %d',
      [IDUsuarioLogado, aIdFornecedor]));

    NovaPendencia := PendenciaServ.CriarObjeto(0, 1, 'Aguardando entrega do pedido ao fornecedor ID: ' + IntToStr(aIdFornecedor),
      ValorTotal, DataPedido + 7, Now, 'PENDENTE', aObservacao, True);
    PendenciaServ.SalvarPendencia(NovaPendencia);
    NovaPendencia.Free;

    Result := True;
  end;
end;

function TPedidoFornecedorService.ListarPedidos: TDataSet;
begin
  Result := Repository.ListarPedidos;
end;

procedure TPedidoFornecedorService.DeletarPedido(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarPedido(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou pedido ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TPedidoFornecedorService.PesquisarPedidos(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarPedidos(aFiltro);
end;

function TPedidoFornecedorService.ListarPecasDoPedido(aIdPedido: Integer): TDataSet;
begin
  Result := Repository.ListarPecasDoPedido(aIdPedido);
end;

function TPedidoFornecedorService.CarregarFornecedores: TStringList;
begin
  Result := Repository.CarregarFornecedores;
end;

function TPedidoFornecedorService.CarregarPecas: TStringList;
begin
  Result := Repository.CarregarPecas;
end;

function TPedidoFornecedorService.ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
begin
  Result := Repository.ObterPrecoCompraPeca(aIdPeca);
end;

function TPedidoFornecedorService.CalcularValorTotal(aPecasIDs: TList<Integer>;
  aQuantidades: TList<Integer>): Currency;
var
  i: Integer;
  PrecoUnitario: Currency;
begin
  Result := 0;

  if (aPecasIDs = nil) or (aQuantidades = nil) or
     (aPecasIDs.Count <> aQuantidades.Count) then
    Exit;

  for i := 0 to aPecasIDs.Count - 1 do
  begin
    PrecoUnitario := ObterPrecoCompraPeca(aPecasIDs[i]);
    Result := Result + (PrecoUnitario * aQuantidades[i]);
  end;
end;

function TPedidoFornecedorService.ValidarPedido(aIdFornecedor: Integer;
  aPecasIDs: TList<Integer>): Boolean;
begin
  Result :=
    (aIdFornecedor > 0) and
    (aPecasIDs <> nil) and
    (aPecasIDs.Count > 0);
end;

end.