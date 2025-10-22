unit LoginUsuarioService;

interface

uses
  uUsuario,UsuarioLoginRepository,uDMConexao,Vcl.Dialogs,BCrypt,uSession,Logs,System.IOUtils,System.SysUtils;

type TUsuarioLoginService = class
public
  function ValidarLogin(Usuario : TUsuario): Boolean;
  function CriarObjeto( aCPF, aSenha: String) : TUsuario;
  function ValidarUsuario(UsuarioValido: TUsuario): Boolean;
  function GetIDeNome(Usuario:TUsuario) :TUsuario;
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


function TUsuarioLoginService.GetIDeNome(Usuario: TUsuario): TUsuario;
var
  Repository: TLoginRepository;
  UsuarioSelect: TUsuario;
begin
  Result := nil;
  Repository := TLoginRepository.Create(DataModule1.FDQuery);
  try
    UsuarioSelect := Repository.SelectUsuario(Usuario);

    if UsuarioSelect <> nil then
    begin
      Result := UsuarioSelect;
      uSession.UsuarioLogadoID := UsuarioSelect.getID;
    end;
  finally
    Repository.Free;
  end;
end;


function TUsuarioLoginService.ValidarLogin(Usuario: TUsuario): Boolean;
var
  Repository: TLoginRepository;
  UsuarioSelect: TUsuario;
  PasswordRehashNeeded: Boolean;
begin
  Result := False;

  if (Usuario = nil) or (Usuario.getSenha = '') then
  begin
    SalvarLog('LOGIN INVÁLIDO - CPF ou senha vazios');
  end;

  Repository := TLoginRepository.Create(DataModule1.FDQuery);
  try
    UsuarioSelect := Repository.SelectUsuario(Usuario);

    if UsuarioSelect <> nil then
    begin
      Result := TBCrypt.CheckPassword(Usuario.getSenha, UsuarioSelect.getSenha, PasswordRehashNeeded);

      if Result then
      begin
        uSession.UsuarioLogadoID := UsuarioSelect.getID;
        SalvarLog(Format('LOGIN - Sucesso: Usuário ID %d, Nome: %s, (CPF: %s)',
          [UsuarioSelect.getID, UsuarioSelect.getNome, UsuarioSelect.getCPF]));
      end else begin
      SalvarLog(Format('LOGIN INVÁLIDO - Senha ou CPF incorretos: (CPF %s )', [Usuario.getCPF]));
      end;
    end else begin
      SalvarLog(Format('LOGIN INVÁLIDO - Usuário não encontrado: (CPF %s)', [Usuario.getCPF]));
    end;

  finally
    Repository.Free;
  end;
end;



function TUsuarioLoginService.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;

end.
