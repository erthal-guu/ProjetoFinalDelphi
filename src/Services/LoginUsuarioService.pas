unit LoginUsuarioService;

interface

uses
  uUsuarioDTO,UsuarioLoginRepository,uDMConexao,Vcl.Dialogs,uUsuarioModel;

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
var Repository :TLoginRepository;
begin
var teste : TUsuario;
  Repository := TLoginRepository.Create(DataModule1.FDQuery);
  teste := Repository.SelectUsuario(UsuarioDTO);
if teste <> nil then begin
  Result := true;
  end else begin
    Result := false;
  end;
end;

function TUsuarioLoginService.ValidarUsuarioDTO(UsuarioValido: TUsuarioDTO): Boolean;
begin
Result := (UsuarioValido.getNome <> '') and
            (UsuarioValido.getCPF <> '') and
            (UsuarioValido.getSenha <> '');
end;

end.
