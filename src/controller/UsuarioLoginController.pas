  unit UsuarioLoginController;

  interface
  uses  uUsuarioDTO,UsuarioLoginRepository,uDMConexao,uFormMain.view,
  Vcl.Dialogs;


  type TUsuarioController = class
    public
      Function ValidarLogin(UsuarioDTO : TUsuarioDTO): Boolean;
      function CriarObjeto( aCPF, aSenha: String) : TUsuarioDTO;
       function ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
      procedure LoginSucedido;
    end;

  implementation

  { TUsuarioController }

  function TUsuarioController.CriarObjeto(aCPF, aSenha: String): TUsuarioDTO;
  var UsuarioDTO : TUsuarioDTO;
  begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(aSenha);
    Result := UsuarioDTO;
  end;

  procedure TUsuarioController.LoginSucedido;
  begin
  FormMain.show;
  end;

  Function TUsuarioController.ValidarLogin(UsuarioDTO: TUsuarioDTO):Boolean;
  var Repository :TLoginRepository;
  begin
    Repository := TLoginRepository.Create(DataModule1.FDQuery);
    if Repository.SelectUsuario(UsuarioDTO) <> nil then begin
      Result := true;
    end else begin
      Result := false;
    end;
  end;

function TUsuarioController.ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
begin
  Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;
  end.


