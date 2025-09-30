unit LoginUsuarioService;

interface

uses
  uUsuarioDTO,UsuarioLoginRepository,uDMConexao,Vcl.Dialogs,uUsuarioModel,BCrypt;

type TUsuarioLoginService = class
public
  function ValidarLogin(UsuarioDTO : TUsuarioDTO): Boolean;
  function CriarObjeto( aCPF, aSenha: String) : TUsuarioDTO;
  function ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
end;

implementation

{ TUsuarioLoginController }

function TUsuarioLoginService.CriarObjeto(aCPF, aSenha: String): TUsuarioDTO;
var UsuarioDTO : TUsuarioDTO;
begin
  UsuarioDTO := TUsuarioDTO.Create;
  UsuarioDTO.setCPF(aCPF);
  UsuarioDTO.setSenha(aSenha);
  Result := UsuarioDTO;
end;


function TUsuarioLoginService.ValidarLogin(UsuarioDTO: TUsuarioDTO): Boolean;
var
  Repository: TLoginRepository;
  Repo: TUsuario;
  PasswordRehashNeeded: Boolean;
begin
  Result := False;

  if UsuarioDTO.getSenha <> '' then
  begin
    Repository := TLoginRepository.Create(DataModule1.FDQuery);
    try
      Repo := Repository.SelectUsuario(UsuarioDTO);

      if Repo <> nil then
      begin
        Result := TBCrypt.CheckPassword(UsuarioDTO.getSenha(),repo.getSenha(),PasswordRehashNeeded);
      end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioLoginService.ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
begin
Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;

end.
