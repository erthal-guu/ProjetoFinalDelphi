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
function ListarUsuarios : TFDQuery;
end;
implementation


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

function TCadastroRepository.ListarUsuarios: TFDQuery;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT nome, cpf, grupo, status FROM usuarios ORDER BY nome');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar usuários: ' + E.Message);
  end;
end;
function TCadastroRepository.EditarUsuario(aUsuario: TUsuarioDTO): Boolean;
begin
Result := False;
try
Self.FQuery.Close;
Self.FQuery.SQL.Clear;
Self.FQuery.SQL.Add('UPDATE usuarios ' +  'SET nome = :nome, senha = :senha ' +'WHERE cpf = :cpf');
Self.FQuery.ParamByName('nome').AsString  := aUsuario.getNome;
Self.FQuery.ParamByName('senha').AsString := aUsuario.getSenha;
Self.FQuery.ParamByName('cpf').AsString   := aUsuario.getCPF;
Self.FQuery.ParamByName('grupo').AsString  := aUsuario.getGrupo;
Self.FQuery.ParamByName('status').AsString  := aUsuario.getStatus;

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

end.
