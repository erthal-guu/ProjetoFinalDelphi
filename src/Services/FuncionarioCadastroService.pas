unit FuncionarioCadastroService;

interface

uses
  uFuncionarioDTO, FuncionarioCadastroRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, Vcl.Dialogs;

type
  TFuncionarioService = class
  private
    Repository: TFuncionarioRepository;
  public
    constructor Create;
    function SalvarFuncionario(FuncionarioDTO: TFuncionarioDTO): Boolean;
    function CriarObjeto(aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,
      aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFuncionarioDTO;
    procedure EditarFuncionario(FuncionarioDTO: TFuncionarioDTO);
    function ValidarFuncionario(FuncionarioValido: TFuncionarioDTO): Boolean;
    function ListarFuncionarios: TDataSet;
    function ListarFuncionariosRestaurar: TDataSet;
    procedure DeletarFuncionario(const aId: Integer);
    procedure RestaurarFuncionario(const aId: Integer);
    function PesquisarFuncionarios(const aFiltro: String): TDataSet;
  end;

implementation

{ TFuncionarioService }

constructor TFuncionarioService.Create;
begin
  Repository := TFuncionarioRepository.Create(DataModule1.FDQuery);
end;

function TFuncionarioService.CriarObjeto(
  aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFuncionarioDTO;
var
  FuncionarioDTO: TFuncionarioDTO;
begin
  FuncionarioDTO := TFuncionarioDTO.Create;
  try
    FuncionarioDTO.setNome(aNome);
    FuncionarioDTO.setCPF(aCPF);
    FuncionarioDTO.setRG(aRG);
    FuncionarioDTO.setNascimento(aNascimento);
    FuncionarioDTO.setTelefone(aTelefone);
    FuncionarioDTO.setCEP(aCEP);
    FuncionarioDTO.setRua(aRua);
    FuncionarioDTO.setNumero(aNumero);
    FuncionarioDTO.setBairro(aBairro);
    FuncionarioDTO.setCidade(aCidade);
    FuncionarioDTO.setEstado(aEstado);
    FuncionarioDTO.setAtivo(aAtivo);
    Result := FuncionarioDTO;
  except
    FuncionarioDTO.Free;
    raise;
  end;
end;

procedure TFuncionarioService.DeletarFuncionario(const aId: Integer);
begin
  Repository.DeletarFuncionario(aId);
end;

procedure TFuncionarioService.EditarFuncionario(FuncionarioDTO: TFuncionarioDTO);
begin
  Repository.EditarFuncionario(FuncionarioDTO);
end;

function TFuncionarioService.ListarFuncionarios: TDataSet;
begin
  Result := Repository.ListarFuncionarios;
end;

function TFuncionarioService.ListarFuncionariosRestaurar: TDataSet;
begin
  Result := Repository.ListarFuncionariosRestaurar;
end;

function TFuncionarioService.PesquisarFuncionarios(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarFuncionarios(aFiltro);
end;

procedure TFuncionarioService.RestaurarFuncionario(const aId: Integer);
begin
  Repository.RestaurarFuncionario(aId);
end;

function TFuncionarioService.SalvarFuncionario(FuncionarioDTO: TFuncionarioDTO): Boolean;
begin
  Result := False;
  if ValidarFuncionario(FuncionarioDTO) then
  begin
    if not Self.Repository.ExisteCPF(FuncionarioDTO) then
    begin
      Self.Repository.InserirFuncionario(FuncionarioDTO);
      Result := True;
    end;
  end;
end;

function TFuncionarioService.ValidarFuncionario(FuncionarioValido: TFuncionarioDTO): Boolean;
begin
  Result :=
    (FuncionarioValido.getNome <> '') and
    (FuncionarioValido.getCPF <> '') and
    (FuncionarioValido.getRG <> '') and
    (FuncionarioValido.getNascimento <> '') and
    (FuncionarioValido.getTelefone <> '') and
    (FuncionarioValido.getCEP <> '') and
    (FuncionarioValido.getRua <> '') and
    (FuncionarioValido.getNumero <> '') and
    (FuncionarioValido.getBairro <> '') and
    (FuncionarioValido.getCidade <> '') and
    (FuncionarioValido.getEstado <> '');
end;

end.
