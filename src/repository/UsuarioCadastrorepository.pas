unit UsuarioCadastrorepository;

interface
uses uDMConexao, FireDAC.Comp.Client, System.SysUtils, uUsuarioDTO, Data.DB;

type TCadastroRepository = class
private
  FQuery:TFDQuery;
public
procedure inserirUsuario(aUsuario : TUsuarioDTO);
constructor Create(Query : TFDQuery);
function ExisteCPF(aUsuario : TUsuarioDTO): Boolean;
function EditarUsuario(aUsuario : TUsuarioDTO):Boolean;
function ListarUsuarios : TDataSet;
function ListarUsuariosRestaurar : TDataSet;
procedure DeletarUsuarios(const aID:Integer);
procedure RestaurarUsuarios(const aID:Integer);
Function PesquisarUsuarios (const aFiltro : String): TDataSet;
end;
implementation

function TCadastroRepository.PesquisarUsuarios(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, senha, grupo, status');
    FQuery.SQL.Add('FROM usuarios');
    FQuery.SQL.Add('WHERE nome ILIKE UPPER (:nome) OR cpf LIKE (:cpf) OR grupo ILIKE (:grupo) AND status = ''Ativo''');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cpf').AsString  := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('grupo').AsString:= '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;

  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar usuário por nome: ' + E.Message);
  end;
end;

{ TCadastrRepository }

constructor TCadastroRepository.Create(Query : TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;


procedure TCadastroRepository.inserirUsuario(aUsuario : TUsuarioDTO);
begin
  Self.FQuery.close;
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add('INSERT INTO usuarios (nome,CPF,senha,grupo,status) VALUES (:nome,:CPF,:senha,:grupo,:status)');
  Self.FQuery.ParamByName('nome').AsString := aUsuario.getNome ;
  Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF ;
  Self.FQuery.ParamByName('senha').AsString := aUsuario.getSenha;
  Self.FQuery.ParamByName('grupo').AsString := aUsuario.getGrupo;
  Self.FQuery.ParamByName('status').AsString := aUsuario.getStatus;
  Self.FQuery.ExecSQL;
end;

function TCadastroRepository.ListarUsuarios: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, grupo, status FROM usuarios WHERE status = ''Ativo''');
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
    FQuery.SQL.Add('SELECT id, nome, cpf, grupo, status FROM usuarios WHERE status = ''Inativo''');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar usuários: ' + E.Message);
  end;
end;

procedure TCadastroRepository.DeletarUsuarios(const aID:Integer);
begin
  Self.FQuery.Close;
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add('UPDATE usuarios SET status = ''Inativo'' WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TCadastroRepository.EditarUsuario(aUsuario: TUsuarioDTO): Boolean;
begin
Result := False;
try
Self.FQuery.Close;
Self.FQuery.SQL.Clear;
Self.FQuery.SQL.Add('UPDATE usuarios SET nome = :nome, senha = :senha, cpf = :cpf, grupo = :grupo, status= :status WHERE id = :id');
Self.FQuery.ParamByName('nome').AsString  := aUsuario.getNome;
Self.FQuery.ParamByName('senha').AsString := aUsuario.getSenha;
Self.FQuery.ParamByName('cpf').AsString   := aUsuario.getCPF;
Self.FQuery.ParamByName('grupo').AsString  := aUsuario.getGrupo;
Self.FQuery.ParamByName('status').AsString  := aUsuario.getStatus;
Self.FQuery.ParamByName('id').AsInteger  := aUsuario.getID;
Self.FQuery.ExecSQL;
Result := Self.FQuery.RowsAffected > 0;
except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao editar usuário: ' + E.Message);
    end;
  end;
end;

function TCadastroRepository.ExisteCPF(aUsuario : TUsuarioDTO): Boolean;
begin
  Self.FQuery.close;
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM usuarios WHERE cpf = :cpf');
  Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF ;
  Self.FQuery.Open;
  Result := Self.FQuery.FieldByName('Total').AsInteger > 0;
end;
procedure TCadastroRepository.RestaurarUsuarios(const aID: Integer);
begin
  Self.FQuery.close;
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add ('UPDATE usuarios SET status = ''Ativo'' WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

end.
