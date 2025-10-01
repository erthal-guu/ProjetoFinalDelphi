unit CadastroUsuarioService;

interface

uses
  uUsuarioDTO, UsuarioCadastroRepository, uDMConexao, System.SysUtils,uMainController, FireDAC.Comp.Client,Data.DB,BCrypt,Vcl.Dialogs;
 type
  TUsuarioService = class
  private
    Repository: TCadastroRepository;
  public
    constructor create;
    function SalvarUsuario(UsuarioDTO : TUsuarioDTO): Boolean;
    function SalvarUsuarioCRUD(UsuarioDTO : TUsuarioDTO):Boolean;
    function CriarObjeto(aNome, aCPF, aSenha: String) : TUsuarioDTO;
    function CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String; aAtivo:Boolean) : TUsuarioDTO;
    procedure EditarUsuario (UsuarioDTO : TUsuarioDTO);
    function ValidarUsuario(UsuarioValido: TUsuarioDTO) : Boolean;
    function ListarUsuarios : TDataSet;
    function ListarUsuariosRestaurar : TDataSet;
    procedure DeletarUsuarios(const aId :Integer);
    procedure RestaurarUsuarios(const aId :Integer);
    function PesquisarUsuarios(const aFiltro: String):TDataSet;
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

constructor TUsuarioService.create;
begin
  Repository := TCadastroRepository.Create(DataModule1.FDQuery);
end;

function TUsuarioService.CriarObjeto(aNome, aCPF, aSenha: String): TUsuarioDTO;
var UsuarioDTO : TUsuarioDTO;
begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setNome(aNome);
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(aSenha);
    Result := UsuarioDTO;
end;

function TUsuarioService.CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String; aAtivo:Boolean): TUsuarioDTO;
var UsuarioDTO : TUsuarioDTO;
begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setNome(aNome);
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(TBCrypt.HashPassword(aSenha));
    UsuarioDTO.setGrupo(aGrupo);
    UsuarioDTO.setAtivo(aAtivo);
    Result := UsuarioDTO;
end;

procedure TUsuarioService.DeletarUsuarios(const aId :Integer);
begin
Repository.DeletarUsuarios(aID);
end;

procedure TUsuarioService.EditarUsuario(UsuarioDTO: TUsuarioDTO);
begin
 if UsuarioDTO.getSenha <> '' then
    UsuarioDTO.setSenha(TBCrypt.HashPassword(UsuarioDTO.getSenha));
    Repository.EditarUsuario(UsuarioDTO);
end;


function TUsuarioService.SalvarUsuario(UsuarioDTO: TUsuarioDTO):Boolean;
var
  Repository : TCadastroRepository;
begin
 if UsuarioDTO.getSenha <> '' then
    UsuarioDTO.setSenha(TBCrypt.HashPassword(UsuarioDTO.getSenha));

if ValidarUsuario(UsuarioDTO) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    Result := False;
    try
    if not Repository.ExisteCPF(UsuarioDTO) then begin
      Repository.inserirUsuario(UsuarioDTO);
      MainController.showHome;
      Result := True;
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioService.SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO):Boolean;
var
  Repository : TCadastroRepository;
begin

if UsuarioDTO.getSenha <> '' then
  UsuarioDTO.setSenha(TBCrypt.HashPassword(UsuarioDTO.getSenha));

if ValidarUsuario(UsuarioDTO) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    try
    if not Repository.ExisteCPF(UsuarioDTO) then begin
      Repository.inserirUsuario(UsuarioDTO);
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioService.ValidarUsuario(UsuarioValido: TUsuarioDTO): Boolean;
begin
 Result := ((UsuarioValido.getNome)<>'')and((UsuarioValido.getCPF)<>'')
            and((UsuarioValido.getSenha)<>'')
end;
procedure TUsuarioService.RestaurarUsuarios(const aId :Integer);
begin
  Repository.RestaurarUsuarios(aId);
end;

end.
