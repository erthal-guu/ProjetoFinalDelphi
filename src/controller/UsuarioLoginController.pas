  unit UsuarioLoginController;

  interface
  uses  uUsuario,UsuarioLoginRepository,uDMConexao,LoginUsuarioService,
  Vcl.Dialogs;


  type TUsuarioController = class
    public
      Service : TUsuarioLoginService;
      Function ValidarLogin(Usuario : TUsuario): Boolean;
      function CriarObjeto( aCPF, aSenha: String) : TUsuario;
      function ValidarUsuario(UsuarioValido: TUsuario): Boolean;
    end;

  implementation

  { TUsuarioController }

function TUsuarioController.CriarObjeto(aCPF, aSenha: String): TUsuario;
  begin
     Result := Service.CriarObjeto(aCPF,aSenha);
  end;

function TUsuarioController.ValidarLogin(Usuario: TUsuario):Boolean;
  begin
    Result := Service.ValidarLogin(Usuario);
  end;

function TUsuarioController.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
  Service.ValidarUsuario(UsuarioValido);
end;
  end.


