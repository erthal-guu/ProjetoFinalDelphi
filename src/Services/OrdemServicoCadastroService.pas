unit OrdemServicoCadastroService;

interface

uses
  uOrdemServico, OrdemServicoCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes, Logs, uSession,
  System.Generics.Collections;

type
  TOrdemServicoService = class
  private
    Repository: TOrdemServicoRepository;
  public
    constructor Create;
    function SalvarOrdemServico(OS: TOrdemServico; PecasIDs: TList<Integer>): Boolean;
    function CriarObjeto(aIdServico, aIdFuncionario, aIdVeiculo, aIdCliente: Integer;
      aPreco: Currency; aAtivo: Boolean): TOrdemServico;
    procedure EditarOrdemServico(OS: TOrdemServico; PecasIDs: TList<Integer>);
    function ValidarOrdemServico(OSValida: TOrdemServico): Boolean;
    function ListarOrdensServico: TDataSet;
    function ListarOrdensServicoRestaurar: TDataSet;
    procedure DeletarOrdemServico(const aId: Integer);
    procedure RestaurarOrdemServico(const aId: Integer);
    function PesquisarOrdensServico(const aFiltro: String): TDataSet;
    function CarregarServicos: TStringList;
    function CarregarFuncionarios: TStringList;
    function CarregarVeiculos: TStringList;
    function CarregarClientes: TStringList;
    function CarregarPecas: TStringList;
    function CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
    function CalcularPrecoTotal(const aIDServico: Integer; aPecasIDs: TList<Integer>; const aIDVeiculo: Integer): Currency;
    function CriarStringIDsPecas(aPecasIDs: TList<Integer>): string;
    function ObterClienteDoVeiculo(const aIDVeiculo: Integer): Integer;
  end;

implementation

constructor TOrdemServicoService.Create;
begin
  Repository := TOrdemServicoRepository.Create(DataModule1.FDQuery);
end;

function TOrdemServicoService.CriarObjeto(aIdServico, aIdFuncionario, aIdVeiculo,
  aIdCliente: Integer; aPreco: Currency; aAtivo: Boolean): TOrdemServico;
var
  OSDTO: TOrdemServico;
begin
  OSDTO := TOrdemServico.Create;
  try
    OSDTO.setIdServico(aIdServico);
    OSDTO.setIdFuncionario(aIdFuncionario);
    OSDTO.setIdVeiculo(aIdVeiculo);
    OSDTO.setIdCliente(aIdCliente);
    OSDTO.setPreco(aPreco);
    OSDTO.setAtivo(aAtivo);
    Result := OSDTO;
  except
    OSDTO.Free;
    raise;
  end;
end;

function TOrdemServicoService.CriarStringIDsPecas(aPecasIDs: TList<Integer>): string;
var
  i: Integer;
  StringBuilder: TStringBuilder;
begin
  Result := '';

  if (aPecasIDs = nil) or (aPecasIDs.Count = 0) then
    Exit;

  StringBuilder := TStringBuilder.Create;
  try
    for i := 0 to aPecasIDs.Count - 1 do
    begin
      if i > 0 then
        StringBuilder.Append(',');
      StringBuilder.Append(aPecasIDs[i].ToString);
    end;
    Result := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

function TOrdemServicoService.SalvarOrdemServico(OS: TOrdemServico;
  PecasIDs: TList<Integer>): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarOrdemServico(OS) then
  begin
    Repository.InserirOrdemServico(OS, PecasIDs);
    SalvarLog(Format('CADASTRO - ID: %d cadastrou ordem de serviço com cliente ID: %d',
      [IDUsuarioLogado, OS.getIdCliente]));
    Result := True;
  end;
end;

procedure TOrdemServicoService.EditarOrdemServico(OS: TOrdemServico;
  PecasIDs: TList<Integer>);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.EditarOrdemServico(OS, PecasIDs);
  SalvarLog(Format('EDITAR - ID: %d editou ordem de serviço ID: %d',
    [IDUsuarioLogado, OS.getIdOrdemServico]));
end;

procedure TOrdemServicoService.DeletarOrdemServico(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarOrdemServico(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou ordem de serviço ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TOrdemServicoService.RestaurarOrdemServico(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarOrdemServico(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou ordem de serviço ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TOrdemServicoService.ListarOrdensServico: TDataSet;
begin
  Result := Repository.ListarOrdensServico;
end;

function TOrdemServicoService.ListarOrdensServicoRestaurar: TDataSet;
begin
  Result := Repository.ListarOrdensServicoRestaurar;
end;

function TOrdemServicoService.PesquisarOrdensServico(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarOrdensServico(aFiltro);
end;

function TOrdemServicoService.CarregarServicos: TStringList;
begin
  Result := Repository.CarregarServicos;
end;

function TOrdemServicoService.CarregarFuncionarios: TStringList;
begin
  Result := Repository.CarregarFuncionarios;
end;

function TOrdemServicoService.CarregarVeiculos: TStringList;
begin
  Result := Repository.CarregarVeiculos;
end;

function TOrdemServicoService.CarregarClientes: TStringList;
begin
  Result := Repository.CarregarClientes;
end;

function TOrdemServicoService.CarregarPecas: TStringList;
begin
  Result := Repository.CarregarPecas;
end;

function TOrdemServicoService.CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
begin
  Result := Repository.CarregarPecasDaOS(aIDOS);
end;

function TOrdemServicoService.ValidarOrdemServico(OSValida: TOrdemServico): Boolean;
begin
  Result :=
    (OSValida.getIdServico > 0) and
    (OSValida.getIdFuncionario > 0) and
    (OSValida.getIdVeiculo > 0) and
    (OSValida.getIdCliente > 0) and
    (OSValida.getPreco >= 0);
end;
function TOrdemServicoService.CalcularPrecoTotal(const aIDServico: Integer;
  aPecasIDs: TList<Integer>; const aIDVeiculo: Integer): Currency;
var
  PrecoServico, PrecoPecas, PorcentagemAcrescimo: Currency;
  PrecoBase, ValorAcrescimo: Currency;
  IDsPecasString: string;
begin
  try
    PrecoServico := Repository.ObterPrecoServico(aIDServico);
    IDsPecasString := CriarStringIDsPecas(aPecasIDs);
    PrecoPecas := Repository.ObterPrecoPecas(IDsPecasString);

    PrecoBase := PrecoServico + PrecoPecas;
    PorcentagemAcrescimo := Repository.ObterPorcentagemMarcaVeiculo(aIDVeiculo);
    ValorAcrescimo := PrecoBase * (PorcentagemAcrescimo / 100);
    Result := PrecoBase + ValorAcrescimo;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao calcular preço total: ' + E.Message);
    end;
  end;
end;
function TOrdemServicoService.ObterClienteDoVeiculo(const aIDVeiculo: Integer): Integer;
begin
  Result := Repository.ObterClienteDoVeiculo(aIDVeiculo);
end;

end.
