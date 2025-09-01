unit UsuarioCadastroController;

interface
uses uUsuarioDTO;

type TUsuarioController = class
  public
    procedure SalvarUsuario(UsuarioController : TUsuarioDTO);
    procedure CriarObjeto(aNome, aCPF, aSenha: String);
    function ValidarUsuario(UsuarioValido : TUsuarioDTO):Boolean;
  end;

implementation

{ TUsuarioController }

procedure TUsuarioController.CriarObjeto;
var UsuarioDTO : TUsuarioDTO;
begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setNome(aNome);
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(aSenha);
end;

procedure TUsuarioController.SalvarUsuario(UsuarioController: TUsuarioDTO);
var UsuarioDTO : TUsuarioDTO;
begin
if ValidarUsuario(UsuarioController) = False then begin
end;
end;

function TUsuarioController.ValidarUsuario(UsuarioValido: TUsuarioDTO):Boolean;
begin
 Result := ((UsuarioValido.getNome)<>'')and((UsuarioValido.getCPF)<>'')
            and((UsuarioValido.getSenha)<>'')

end;

end.
