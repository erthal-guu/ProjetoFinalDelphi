unit FuncionarioCadastroController;

interface

uses
  uFuncionarioDTO, FuncionarioCadastroService, FireDAC.Comp.Client, Vcl.Dialogs, Data.DB;

type
  TFuncionarioController = class
  private
    Service: TFuncionarioService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarFuncionario(FuncionarioDTO: TFuncionarioDTO): Boolean;
    procedure EditarFuncionario(FuncionarioDTO: TFuncionarioDTO);
    function ListarFuncionarios: TDataSet;
    function CriarObjeto(aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFuncionarioDTO;
    procedure DeletarFuncionario(const aId: Integer);
    procedure RestaurarFuncionario(const aId: Integer);
    function PesquisarFuncionarios(const aFiltro: String): TDataSet;
  end;

implementation

constructor TFuncionarioController.Create;
begin
  inherited Create;
  FService := TFuncionarioService.Create;
end;

destructor TFuncionarioController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TFuncionarioController.CriarObjeto(
  aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFuncionarioDTO;
begin
  Result := TFuncionarioDTO.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setRG(aRG);
  Result.setNascimento(aNascimento);
  Result.setTelefone(aTelefone);
  Result.setCEP(aCEP);
  Result.setRua(aRua);
  Result.setNumero(aNumero);
  Result.setBairro(aBairro);
  Result.setCidade(aCidade);
  Result.setEstado(aEstado);
  Result.setAtivo(aAtivo);
end;

procedure TFuncionarioController.DeletarFuncionario(const aId: Integer);
begin
  Service.DeletarFuncionario(aId);
end;

procedure TFuncionarioController.EditarFuncionario(FuncionarioDTO: TFuncionarioDTO);
begin
  Service.EditarFuncionario(FuncionarioDTO);
end;

function TFuncionarioController.ListarFuncionarios: TDataSet;
begin
  Result := Service.ListarFuncionarios;
end;

function TFuncionarioController.PesquisarFuncionarios(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarFuncionarios(aFiltro);
end;

procedure TFuncionarioController.RestaurarFuncionario(const aId: Integer);
begin
  Service.RestaurarFuncionario(aId);
end;

function TFuncionarioController.SalvarFuncionario(FuncionarioDTO: TFuncionarioDTO): Boolean;
begin
  Result := Service.SalvarFuncionario(FuncionarioDTO);
end;

end.
