unit UsuarioLoginController;
interface
uses
  uUsuario,
  UsuarioLoginRepository,
  uDMConexao,
  LoginUsuarioService,
  Vcl.Dialogs;

type
  TUsuarioController = class
  private
    Service: TUsuarioLoginService;
  public
    function ValidarLogin(Usuario: TUsuario): Boolean;
    function CriarObjeto(aCPF, aSenha: String): TUsuario;
    function ValidarUsuario(UsuarioValido: TUsuario): Boolean;
    function GetIDNome(Usuario: TUsuario): TUsuario;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioController }

constructor TUsuarioController.Create;
begin
  inherited Create;
  Service := TUsuarioLoginService.Create;
end;

destructor TUsuarioController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TUsuarioController.CriarObjeto(aCPF, aSenha: String): TUsuario;
begin
  Result := Service.CriarObjeto(aCPF, aSenha);
end;

function TUsuarioController.GetIDNome(Usuario: TUsuario): TUsuario;
begin
  Result := Service.GetIDeNome(Usuario);
end;

function TUsuarioController.ValidarLogin(Usuario: TUsuario): Boolean;
begin
  Result := Service.ValidarLogin(Usuario);
end;

function TUsuarioController.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
  Result := Service.ValidarUsuario(UsuarioValido);
end;

end.
