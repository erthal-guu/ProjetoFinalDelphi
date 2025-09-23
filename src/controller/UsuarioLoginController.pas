  unit UsuarioLoginController;

  interface
  uses  uUsuarioDTO,UsuarioLoginRepository,uDMConexao,LoginUsuarioService,
  Vcl.Dialogs;


  type TUsuarioController = class
    public
      Service : TUsuarioLoginService;
      Function ValidarLogin(UsuarioDTO : TUsuarioDTO): Boolean;
      function CriarObjeto( aCPF, aSenha: String) : TUsuarioDTO;
      function ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
    end;

  implementation

  { TUsuarioController }

function TUsuarioController.CriarObjeto(aCPF, aSenha: String): TUsuarioDTO;
  begin
     Result := Service.CriarObjeto(aCPF,aSenha);
  end;

function TUsuarioController.ValidarLogin(UsuarioDTO: TUsuarioDTO):Boolean;
  begin
  Result := Service.ValidarLogin(UsuarioDTO);
  end;

function TUsuarioController.ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
begin
  Service.ValidarUsuarioDTO(UsuarioValido);
end;
  end.


