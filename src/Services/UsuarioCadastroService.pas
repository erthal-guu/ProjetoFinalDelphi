unit UsuarioCadastroService;

interface

uses
  uUsuario, UsuarioCadastroRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, BCrypt, Vcl.Dialogs,
  System.Classes, LogTxt;

type
  TUsuarioService = class
  private
    Repository: TCadastroRepository;
  public
    constructor create;
    function SalvarUsuario(Usuario : TUsuario): Boolean;
    function CriarObjeto(aNome, aCPF, aSenha,aGrupo : String; aAtivo:Boolean) : TUsuario;
    procedure EditarUsuario (Usuario : TUsuario);
    procedure EditarUsuarioComSenha (Usuario : TUsuario);
    procedure DeletarUsuarios(const aId :Integer);
    procedure RestaurarUsuarios(const aId :Integer);
    function ValidarUsuario(UsuarioValido: TUsuario) : Boolean;
    function ListarUsuarios : TDataSet;
    function ListarUsuariosRestaurar : TDataSet;
    function PesquisarUsuarios(const aFiltro: String): TDataSet;
    function CarregarGrupos : TStringList;
  end;

implementation

{ TUsuarioService }

constructor TUsuarioService.create;
begin
  Repository := TCadastroRepository.Create(DataModule1.FDQuery);
end;

function TUsuarioService.CriarObjeto(aNome, aCPF, aSenha,aGrupo : String; aAtivo:Boolean): TUsuario;
var
  Usuario : TUsuario;
begin
  Usuario := TUsuario.Create;
  Usuario.setNome(aNome);
  Usuario.setCPF(aCPF);
  Usuario.setSenha(TBCrypt.HashPassword(aSenha));
  Usuario.setGrupo(aGrupo);
  Usuario.setAtivo(aAtivo);
  Result := Usuario;
end;

function TUsuarioService.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
  Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;

function TUsuarioService.SalvarUsuario(Usuario: TUsuario): Boolean;
var
  Repo : TCadastroRepository;
begin
  if Usuario.getSenha <> '' then
    Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));

  Result := False;

if ValidarUsuario(Usuario) then
begin
    Repo := TCadastroRepository.Create(DataModule1.FDQuery);
    try
      if not Repo.ExisteCPF(Usuario) then
      begin
        Repo.inserirUsuario(Usuario);
        SalvarLog('CADASTRO - Usuário: ' + Usuario.getNome + ' CPF: ' + Usuario.getCPF);
        Result := True;
      end else begin
        ShowMessage('CPF ja cadastrado ');
        SalvarLog('CADASTRO - Falha: CPF já existe ' + Usuario.getCPF);
      end;
    finally
      Repo.Free;
    end;
  end;
end;

procedure TUsuarioService.EditarUsuario(Usuario: TUsuario);
begin
  if Usuario.getSenha <> '' then
    Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));

  Repository.EditarUsuario(Usuario);
  SalvarLog('EDITAR - Usuário: ' + Usuario.getNome + ' CPF: ' + Usuario.getCPF);
end;

procedure TUsuarioService.EditarUsuarioComSenha(Usuario: TUsuario);
begin
  Repository.EditarUsuarioComSenha(Usuario);
  SalvarLog('EDITAR COM SENHA - Usuário: ' + Usuario.getNome + ' CPF: ' + Usuario.getCPF);
end;

procedure TUsuarioService.DeletarUsuarios(const aId: Integer);
begin
  Repository.DeletarUsuarios(aID);
  SalvarLog('DELETAR - Usuário ID: ' + IntToStr(aID));
end;

procedure TUsuarioService.RestaurarUsuarios(const aId: Integer);
begin
  Repository.RestaurarUsuarios(aID);
  SalvarLog('RESTAURAR - Usuário ID: ' + IntToStr(aID));
end;

function TUsuarioService.ListarUsuarios: TDataSet;
begin
  Result := Repository.ListarUsuarios;
end;

function TUsuarioService.ListarUsuariosRestaurar: TDataSet;
begin
  Result := Repository.ListarUsuariosRestaurar;
end;

function TUsuarioService.PesquisarUsuarios(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarUsuarios(aFiltro);
end;

function TUsuarioService.CarregarGrupos: TStringList;
begin
  Result := Repository.CarregarGrupos;
end;

end.

