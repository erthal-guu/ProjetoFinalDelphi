unit UsuarioCadastrorepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uUsuario, Data.DB,Generics.Collections,System.Classes;

type
  TCadastroRepository = class
  private
    FQuery: TFDQuery;
  public
    procedure inserirUsuario(aUsuario : TUsuario);
    constructor Create(Query : TFDQuery);
    function ExisteCPF(aUsuario : TUsuario): Boolean;
    function EditarUsuario(aUsuario : TUsuario): Boolean;
    function ListarUsuarios : TDataSet;
    function ListarUsuariosRestaurar : TDataSet;
    procedure DeletarUsuarios(const aID: Integer);
    procedure RestaurarUsuarios(const aID: Integer);
    function PesquisarUsuarios(const aFiltro : String): TDataSet;
    function EditarUsuarioComSenha(aUsuario : TUsuario):Boolean;
    function CarregarGrupos :TStringList;
  end;

implementation

function TCadastroRepository.PesquisarUsuarios(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, grupo, ativo');
    FQuery.SQL.Add('FROM usuarios');
    FQuery.SQL.Add('WHERE (nome ILIKE UPPER(:nome) OR cpf LIKE :cpf OR grupo ILIKE :grupo)');
    FQuery.SQL.Add('  AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString  := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cpf').AsString   := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('grupo').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar usuário por nome: ' + E.Message);
  end;
end;

function TCadastroRepository.CarregarGrupos: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.add('SELECT id, nome FROM grupo ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  except
    on E: Exception do
    begin
      Lista.Free;
      raise Exception.Create('Erro ao listar grupos: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

constructor TCadastroRepository.Create(Query : TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TCadastroRepository.inserirUsuario(aUsuario : TUsuario);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO usuarios (nome, cpf, senha, grupo, ativo)');
  FQuery.SQL.Add('VALUES (:nome, :cpf, :senha, :grupo, :ativo)');
  FQuery.ParamByName('nome').AsString   := aUsuario.getNome;
  FQuery.ParamByName('cpf').AsString    := aUsuario.getCPF;
  FQuery.ParamByName('senha').AsString  := aUsuario.getSenha;
  FQuery.ParamByName('grupo').AsString  := aUsuario.getGrupo;
  FQuery.ParamByName('ativo').AsBoolean := aUsuario.getAtivo;
  FQuery.ExecSQL;
end;

function TCadastroRepository.ListarUsuarios: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, grupo, ativo FROM usuarios WHERE ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar usuários: ' + E.Message);
  end;
end;

function TCadastroRepository.ListarUsuariosRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, grupo, ativo FROM usuarios WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar usuários para restauração: ' + E.Message);
  end;
end;

procedure TCadastroRepository.DeletarUsuarios(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE usuarios SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TCadastroRepository.EditarUsuario(aUsuario: TUsuario): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE usuarios');
    FQuery.SQL.Add('SET nome = :nome, senha = :senha, cpf = :cpf, grupo = :grupo, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString   := aUsuario.getNome;
    FQuery.ParamByName('senha').AsString  := aUsuario.getSenha;
    FQuery.ParamByName('cpf').AsString    := aUsuario.getCPF;
    FQuery.ParamByName('grupo').AsString  := aUsuario.getGrupo;
    FQuery.ParamByName('ativo').AsBoolean := aUsuario.getAtivo;
    FQuery.ParamByName('id').AsInteger    := aUsuario.getID;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar usuário: ' + E.Message);
  end;
end;
function TCadastroRepository.EditarUsuarioComSenha(aUsuario: TUsuario): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE usuarios');
    FQuery.SQL.Add('SET nome = :nome, cpf = :cpf, grupo = :grupo, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString   := aUsuario.getNome;
    FQuery.ParamByName('cpf').AsString    := aUsuario.getCPF;
    FQuery.ParamByName('grupo').AsString  := aUsuario.getGrupo;
    FQuery.ParamByName('ativo').AsBoolean := aUsuario.getAtivo;
    FQuery.ParamByName('id').AsInteger    := aUsuario.getID;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar usuário: ' + E.Message);
  end;
end;

function TCadastroRepository.ExisteCPF(aUsuario : TUsuario): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM usuarios WHERE cpf = :cpf');
  FQuery.ParamByName('cpf').AsString := aUsuario.getCPF;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

procedure TCadastroRepository.RestaurarUsuarios(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE usuarios SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

end.

