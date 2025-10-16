unit LoginUsuarioService;

interface

uses
  uUsuario,UsuarioLoginRepository,uDMConexao,Vcl.Dialogs,BCrypt;

type TUsuarioLoginService = class
public
  function ValidarLogin(Usuario : TUsuario): Boolean;
  function CriarObjeto( aCPF, aSenha: String) : TUsuario;
  function ValidarUsuario(UsuarioValido: TUsuario): Boolean;
end;

implementation

{ TUsuarioLoginController }

function TUsuarioLoginService.CriarObjeto(aCPF, aSenha: String): TUsuario;
var Usuario : TUsuario;
begin
  Usuario := TUsuario.Create;
  Usuario.setCPF(aCPF);
  Usuario.setSenha(aSenha);
  Result := Usuario;
end;


function TUsuarioLoginService.ValidarLogin(Usuario: TUsuario): Boolean;
var
  Repository: TLoginRepository;
  Repo: TUsuario;
  PasswordRehashNeeded: Boolean;
begin
  Result := False;

  if Usuario.getSenha <> '' then
  begin
    Repository := TLoginRepository.Create(DataModule1.FDQuery);
    try
      Repo := Repository.SelectUsuario(Usuario);

    if (Repo <> nil) and (Repo.getSenha <> '') then
    begin
      Result := TBCrypt.CheckPassword(Usuario.getSenha(), Repo.getSenha(), PasswordRehashNeeded);
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioLoginService.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;

end.
