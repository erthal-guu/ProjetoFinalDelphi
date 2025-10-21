unit UsuarioCadastroService;

interface

uses
  uUsuario, UsuarioCadastroRepository, uDMConexao, System.SysUtils,uMainController, FireDAC.Comp.Client,Data.DB,BCrypt,Vcl.Dialogs,System.Classes,logTxt;
 type
  TUsuarioService = class
  private
    Repository: TCadastroRepository;
  public
    constructor create;
    function SalvarUsuario(Usuario : TUsuario): Boolean;
    function SalvarUsuarioCRUD(Usuario : TUsuario):Boolean;
    function CriarObjeto(aNome, aCPF, aSenha: String) : TUsuario;
    function CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String; aAtivo:Boolean) : TUsuario;
    procedure EditarUsuario (Usuario : TUsuario);
    function ValidarUsuario(UsuarioValido: TUsuario) : Boolean;
    function ListarUsuarios : TDataSet;
    function ListarUsuariosRestaurar : TDataSet;
    procedure DeletarUsuarios(const aId :Integer);
    procedure RestaurarUsuarios(const aId :Integer);
    function PesquisarUsuarios(const aFiltro: String):TDataSet;
    procedure EditarUsuarioComSenha (Usuario : TUsuario);
    function CarregarGrupos : TStringList;
  end;

implementation

{ TUsuarioService }

function TUsuarioService.ListarUsuarios:TDataSet;
begin
  Result := Repository.ListarUsuarios;
end;

function TUsuarioService.ListarUsuariosRestaurar: TDataSet;
begin
  result := Repository.ListarUsuariosRestaurar;
end;


function TUsuarioService.PesquisarUsuarios(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarUsuarios(aFiltro);
end;

function TUsuarioService.CarregarGrupos: TStringList;
begin
Result := Repository.CarregarGrupos;
end;

constructor TUsuarioService.create;
begin
  Repository := TCadastroRepository.Create(DataModule1.FDQuery);
end;

function TUsuarioService.CriarObjeto(aNome, aCPF, aSenha: String): TUsuario;
var Usuario : TUsuario;
begin
    Usuario := TUsuario.Create;
    Usuario.setNome(aNome);
    Usuario.setCPF(aCPF);
    Usuario.setSenha(aSenha);
    Result := Usuario;
end;

function TUsuarioService.CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String; aAtivo:Boolean): TUsuario;
var Usuario : TUsuario;
begin
    Usuario := TUsuario.Create;
    Usuario.setNome(aNome);
    Usuario.setCPF(aCPF);
    Usuario.setSenha(TBCrypt.HashPassword(aSenha));
    Usuario.setGrupo(aGrupo);
    Usuario.setAtivo(aAtivo);
    Result := Usuario;
end;

procedure TUsuarioService.DeletarUsuarios(const aId :Integer);
begin
  Repository.DeletarUsuarios(aID);
end;

procedure TUsuarioService.EditarUsuario(Usuario: TUsuario);
begin
 if Usuario.getSenha <> '' then
    Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));
    Repository.EditarUsuario(Usuario);
end;


procedure TUsuarioService.EditarUsuarioComSenha(Usuario: TUsuario);
begin
  Repository.EditarUsuarioComSenha(Usuario);
end;

function TUsuarioService.SalvarUsuario(Usuario: TUsuario):Boolean;
var
  Repository : TCadastroRepository;
begin
 if Usuario.getSenha <> '' then
    Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));

if ValidarUsuario(Usuario) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    Result := False;
    try
    if not Repository.ExisteCPF(Usuario) then begin
      Repository.inserirUsuario(Usuario);
      MainController.showHome;
      Result := True;
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioService.SalvarUsuarioCRUD(Usuario: TUsuario):Boolean;
var
  Repository : TCadastroRepository;
begin

if Usuario.getSenha <> '' then
  Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));

if ValidarUsuario(Usuario) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    try
    if not Repository.ExisteCPF(Usuario) then begin
      Repository.inserirUsuario(Usuario);
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioService.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
 Result := ((UsuarioValido.getNome)<>'')and((UsuarioValido.getCPF)<>'')
            and((UsuarioValido.getSenha)<>'')
end;
procedure TUsuarioService.RestaurarUsuarios(const aId :Integer);
begin
  Repository.RestaurarUsuarios(aId);
end;

end.
