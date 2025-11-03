unit FornecedorCadastroController;

interface

uses
  uFornecedor, FornecedorCadastroService, FireDAC.Comp.Client, Data.DB, System.Classes, System.Generics.Collections;

type
  TFornecedorController = class
  private
    Service: TFornecedorService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarFornecedor(Fornecedor: TFornecedor): Boolean;
    procedure EditarFornecedor(Fornecedor: TFornecedor);
    function ListarFornecedores: TDataSet;
    function ListarFornecedoresRestaurar: TDataSet;
    function CriarObjeto(
      aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
      aBairro, aCidade, aEstado: String; aAtivo: Boolean
    ): TFornecedor;
    procedure DeletarFornecedor(const aId: Integer);
    procedure RestaurarFornecedor(const aId: Integer);
    function PesquisarFornecedores(const aFiltro: String): TDataSet;
    Function VincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer):Boolean;
    function ListarPecasPorFornecedor(aFornecedorID: Integer): TDataSet;
    function CarregarFornecedores: TStringList;
    procedure DesvincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer);
    function CarregarPecas: TStringList;
    function ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
    function CalcularValorTotal(aPecasIDs: TList<Integer>; aQuantidades: TList<Integer>): Currency;
    function SalvarPedido(
      aIdFornecedor: Integer;
      aFormaPagamento: string;
      aValorTotal: Currency;
      aObservacao: string;
      aPecasIDs: TList<Integer>;
      aQuantidades: TList<Integer>
    ): Boolean;
    function CarregarPecasPorFornecedor(aIdFornecedor: Integer): TStringList;
  end;

implementation

constructor TFornecedorController.Create;
begin
  inherited Create;
  Service := TFornecedorService.Create;
end;

destructor TFornecedorController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TFornecedorController.CarregarFornecedores: TStringList;
begin
  Result := Service.CarregarFornecedores;
end;

function TFornecedorController.ListarFornecedoresRestaurar: TDataSet;
begin
  Result := Service.ListarFornecedoresRestaurar;
end;

procedure TFornecedorController.DesvincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer);
begin
  Service.DesvincularPecaDoFornecedor(aPecaID, aFornecedorID);
end;

function TFornecedorController.CriarObjeto(
  aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado: String; aAtivo: Boolean
): TFornecedor;
begin
  Result := TFornecedor.Create;
  Result.setNome(aNome);
  Result.setRazaoSocial(aRazaoSocial);
  Result.setCNPJ(aCNPJ);
  Result.setTelefone(aTelefone);
  Result.setCEP(aCEP);
  Result.setRua(aRua);
  Result.setNumero(aNumero);
  Result.setBairro(aBairro);
  Result.setCidade(aCidade);
  Result.setEstado(aEstado);
  Result.setAtivo(aAtivo);
end;

procedure TFornecedorController.DeletarFornecedor(const aId: Integer);
begin
  Service.DeletarFornecedor(aId);
end;

procedure TFornecedorController.EditarFornecedor(Fornecedor: TFornecedor);
begin
  Service.EditarFornecedor(Fornecedor);
end;

function TFornecedorController.ListarFornecedores: TDataSet;
begin
  Result := Service.ListarFornecedores;
end;

function TFornecedorController.ListarPecasPorFornecedor(aFornecedorID: Integer): TDataSet;
begin
  Result := Service.ListarPecasPorFornecedor(aFornecedorID);
end;

function TFornecedorController.PesquisarFornecedores(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarFornecedores(aFiltro);
end;

procedure TFornecedorController.RestaurarFornecedor(const aId: Integer);
begin
  Service.RestaurarFornecedor(aId);
end;

function TFornecedorController.SalvarFornecedor(Fornecedor: TFornecedor): Boolean;
begin
  Result := Service.SalvarFornecedor(Fornecedor);
end;

function TFornecedorController.SalvarPedido(
  aIdFornecedor: Integer;
  aFormaPagamento: string;
  aValorTotal: Currency;
  aObservacao: string;
  aPecasIDs: TList<Integer>;
  aQuantidades: TList<Integer>
): Boolean;
begin
  Result := Service.SalvarPedido(aIdFornecedor, aFormaPagamento, aValorTotal, aObservacao, aPecasIDs, aQuantidades);
end;

Function TFornecedorController.VincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer):Boolean;
begin
  Result := Service.VincularPecaAoFornecedor(aPecaID, aFornecedorID);
end;

function TFornecedorController.CarregarPecas: TStringList;
begin
  Result := Service.CarregarPeças;
end;

function TFornecedorController.CarregarPecasPorFornecedor(aIdFornecedor: Integer): TStringList;
begin
  Result := Service.CarregarPecasPorFornecedor(aIdFornecedor);
end;

function TFornecedorController.ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
begin
  Result := Service.ObterPrecoCompraPeca(aIdPeca);
end;

function TFornecedorController.CalcularValorTotal(aPecasIDs: TList<Integer>;
  aQuantidades: TList<Integer>): Currency;
begin
  Result := Service.CalcularValorTotal(aPecasIDs, aQuantidades);
end;

end.
