unit FornecedorCadastroController;

interface

uses
  uFornecedorDTO, FornecedorCadastroService, FireDAC.Comp.Client, Data.DB;

type
  TFornecedorController = class
  private
    Service: TFornecedorService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarFornecedor(FornecedorDTO: TFornecedorDTO): Boolean;
    procedure EditarFornecedor(FornecedorDTO: TFornecedorDTO);
    function ListarFornecedores: TDataSet;
    function CriarObjeto(
      aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
      aBairro, aCidade, aEstado: String; aAtivo: Boolean
    ): TFornecedorDTO;
    procedure DeletarFornecedor(const aId: Integer);
    procedure RestaurarFornecedor(const aId: Integer);
    function PesquisarFornecedores(const aFiltro: String): TDataSet;
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

function TFornecedorController.CriarObjeto(
  aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado: String; aAtivo: Boolean
): TFornecedorDTO;
begin
  Result := TFornecedorDTO.Create;
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

procedure TFornecedorController.EditarFornecedor(FornecedorDTO: TFornecedorDTO);
begin
  Service.EditarFornecedor(FornecedorDTO);
end;

function TFornecedorController.ListarFornecedores: TDataSet;
begin
  Result := Service.ListarFornecedores;
end;

function TFornecedorController.PesquisarFornecedores(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarFornecedores(aFiltro);
end;

procedure TFornecedorController.RestaurarFornecedor(const aId: Integer);
begin
  Service.RestaurarFornecedor(aId);
end;

function TFornecedorController.SalvarFornecedor(FornecedorDTO: TFornecedorDTO): Boolean;
begin
  Result := Service.SalvarFornecedor(FornecedorDTO);
end;

end.
