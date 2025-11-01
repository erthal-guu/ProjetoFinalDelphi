unit ClienteCadastroRepository;

interface
uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uCliente, Data.DB;

 type
  TClienteRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query : TFDQuery);
    procedure inserirCliente(aCliente: TCliente);
    function ExisteCPF(aCliente : TCliente): Boolean;
    function EditarClientes(aCliente : TCliente): Boolean;
    function ListarClientes : TDataSet;
    function ListarClientesRestaurar : TDataSet;
    procedure DeletarClientes(const aID: Integer);
    procedure RestaurarClientes(const aID: Integer);
    function PesquisarClientes(const aFiltro : String): TDataSet;
  end;
implementation
{ TClienteRepository }

constructor TClienteRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TClienteRepository.DeletarClientes(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE clientes SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TClienteRepository.EditarClientes(aCliente: TCliente): Boolean;
begin
   Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE Clientes');
    FQuery.SQL.Add('SET nome = :nome, cpf = :cpf ,email = :email,telefone = :telefone, nascimento = :nascimento, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
  FQuery.ParamByName('nome').AsString    := aCliente.getNome;
  FQuery.ParamByName('cpf').AsString     := aCliente.getCPF;
  FQuery.ParamByName('email').AsString   := aCliente.getEmail;
  FQuery.ParamByName('telefone').AsString:= aCliente.getTelefone;
  FQuery.ParamByName('nascimento').AsString := aCliente.getNascimento;
  FQuery.ParamByName('ativo').AsBoolean := aCliente.getAtivo;
  FQuery.ParamByName('id').AsInteger := aCliente.getIdCliente;


    FQuery.ParamByName('ativo').AsBoolean := aCliente.getAtivo;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar Cliente: ' + E.Message);
  end;
end;

function TClienteRepository.ExisteCPF(aCliente: TCliente): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM clientes WHERE cpf = :cpf');
  FQuery.ParamByName('cpf').AsString := aCliente.getCPF;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

procedure TClienteRepository.inserirCliente(aCliente: TCliente);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO clientes (nome, cpf, email, telefone, nascimento, ativo)');
  FQuery.SQL.Add('VALUES (:nome, :cpf, :email, :telefone, :nascimento, :ativo)');
  FQuery.ParamByName('nome').AsString    := aCliente.getNome;
  FQuery.ParamByName('cpf').AsString     := aCliente.getCPF;
  FQuery.ParamByName('email').AsString   := aCliente.getEmail;
  FQuery.ParamByName('telefone').AsString:= aCliente.getTelefone;
  FQuery.ParamByName('nascimento').AsString := aCliente.getNascimento;
  FQuery.ParamByName('ativo').AsBoolean := aCliente.getAtivo;
  FQuery.ExecSQL;
end;

function TClienteRepository.ListarClientes: TDataSet;
begin
    try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome,cpf,email,telefone,nascimento,ativo FROM Clientes WHERE ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Clientes: ' + E.Message);
  end;
end;

function TClienteRepository.ListarClientesRestaurar: TDataSet;
begin
    try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome,cpf,email,telefone,nascimento,ativo FROM Clientes WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Clientes para restauração: ' + E.Message);
  end;
end;

function TClienteRepository.PesquisarClientes(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, email,telefone,nascimento,ativo');
    FQuery.SQL.Add('FROM clientes');
    FQuery.SQL.Add('WHERE(nome ILIKE :nome) OR (cpf LIKE :cpf) OR (telefone ILIKE :telefone)');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString   := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cpf').AsString   := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('telefone').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Cliente por nome: ' + E.Message);
  end;
end;

procedure TClienteRepository.RestaurarClientes(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE Clientes SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

end.
