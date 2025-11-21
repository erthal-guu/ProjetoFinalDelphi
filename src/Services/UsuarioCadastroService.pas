unit UsuarioCadastroService;

interface

uses
  uUsuario, UsuarioCadastroRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, BCrypt, Vcl.Dialogs,
  System.Classes, Logs, uSession;

type
  TUsuarioService = class
  private
    Repository: TCadastroRepository;
  public
    constructor Create;
    function SalvarUsuario(Usuario: TUsuario): Boolean;
    function CriarObjeto(aNome, aCPF, aSenha, aGrupo: String; aAtivo: Boolean): TUsuario;
    procedure EditarUsuario(Usuario: TUsuario);
    procedure EditarUsuarioComSenha(Usuario: TUsuario);
    procedure DeletarUsuarios(const aId: Integer);
    procedure RestaurarUsuarios(const aId: Integer);
    function ValidarUsuario(UsuarioValido: TUsuario): Boolean;
    function ListarUsuarios: TDataSet;
    function ListarUsuariosRestaurar: TDataSet;
    function PesquisarUsuarios(const aFiltro: String): TDataSet;
    function CarregarGrupos: TStringList;
  end;

implementation

{ TUsuarioService }

constructor TUsuarioService.Create;
begin
  Repository := TCadastroRepository.Create(DataModule1.FDQuery);
end;

function TUsuarioService.CriarObjeto(aNome, aCPF, aSenha, aGrupo: String;
  aAtivo: Boolean): TUsuario;
var
  Usuario: TUsuario;
begin
  Usuario := TUsuario.Create;
  Usuario.setNome(aNome);
  Usuario.setCPF(aCPF);
  Usuario.setSenha(TBCrypt.HashPassword(aSenha));
  Usuario.setGrupo(aGrupo);
  Usuario.setAtivo(aAtivo);
  Result := Usuario;
end;

function TUsuarioService.ValidarUsuario(UsuarioValido: TUsuario): Boolean;
begin
  Result := (UsuarioValido.getNome <> '') and (UsuarioValido.getCPF <> '') and
    (UsuarioValido.getSenha <> '');
end;

function TUsuarioService.SalvarUsuario(Usuario: TUsuario): Boolean;
var
  Repo: TCadastroRepository;
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if Usuario.getSenha <> '' then
    Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));

  if ValidarUsuario(Usuario) then begin
    Repo := TCadastroRepository.Create(DataModule1.FDQuery);
    try
      if not Repo.ExisteCPF(Usuario) then begin
        Repo.InserirUsuario(Usuario);
        SalvarLog(Format('CADASTRO - ID: %d cadastrou o usuário: %s (CPF: %s)',
          [IDUsuarioLogado, Usuario.getNome, Usuario.getCPF]));
        Result := True;
      end
      else begin
        ShowMessage('CPF já cadastrado.');
        SalvarLog(Format
          ('CADASTRO - ID: %d falhou ao cadastrar (CPF já existente: %s)',
          [IDUsuarioLogado, Usuario.getCPF]));
      end;
    finally
      Repo.Free;
    end;
  end;
end;

procedure TUsuarioService.EditarUsuario(Usuario: TUsuario);
var
  IDUsuarioLogado: Integer;
  begin
    IDUsuarioLogado := uSession.UsuarioLogadoID;
    if Repository.ExisteCPF(Usuario) then begin
      ShowMessage('Esse CPF já está cadastrado a outro Usuário');
      exit;
    end else begin
      if Usuario.getSenha <> '' then
        Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));
      Repository.EditarUsuario(Usuario);
      SalvarLog(Format('EDITAR - ID: %d editou o usuário: %s (CPF: %s)',
        [IDUsuarioLogado, Usuario.getNome, Usuario.getCPF]));
    end;
  end;

procedure TUsuarioService.EditarUsuarioComSenha(Usuario: TUsuario);
var
  IDUsuarioLogado: Integer;
  begin
    IDUsuarioLogado := uSession.UsuarioLogadoID;

    if Repository.ExisteCPF(Usuario) then begin
      ShowMessage('Esse CPF já esta cadastrado a um Usuário');
    end else begin
      Usuario.setSenha(TBCrypt.HashPassword(Usuario.getSenha));
      Repository.EditarUsuarioComSenha(Usuario);
      SalvarLog(Format('EDITAR - ID: %d editou o usuário: %s (CPF: %s)',
        [IDUsuarioLogado, Usuario.getNome, Usuario.getCPF]));
    end;
  end;

procedure TUsuarioService.DeletarUsuarios(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarUsuarios(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou o usuário ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TUsuarioService.RestaurarUsuarios(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarUsuarios(aId);
  SalvarLog(Format('RESTAURAR - ID: %d] restaurou o usuário ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TUsuarioService.ListarUsuarios: TDataSet;
begin
  Result := Repository.ListarUsuarios;
end;

function TUsuarioService.ListarUsuariosRestaurar: TDataSet;
begin
  Result := Repository.ListarUsuariosRestaurar;
end;

function TUsuarioService.PesquisarUsuarios(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarUsuarios(aFiltro);
end;

function TUsuarioService.CarregarGrupos: TStringList;
begin
  Result := Repository.CarregarGrupos;
end;

end.
