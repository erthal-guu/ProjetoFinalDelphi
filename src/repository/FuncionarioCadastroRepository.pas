unit FuncionarioCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uFuncionario, Data.DB;

type
  TFuncionarioRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirFuncionario(aFuncionario: TFuncionario);
    function ExisteCPF(aFuncionario: TFuncionario): Boolean;
    function EditarFuncionario(aFuncionario: TFuncionario): Boolean;
    function ListarFuncionarios: TDataSet;
    function ListarFuncionariosRestaurar: TDataSet;
    procedure DeletarFuncionario(const aID: Integer);
    procedure RestaurarFuncionario(const aID: Integer);
    function PesquisarFuncionarios(const aFiltro: String): TDataSet;
  end;

implementation

constructor TFuncionarioRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TFuncionarioRepository.DeletarFuncionario(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE funcionarios SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TFuncionarioRepository.RestaurarFuncionario(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE funcionarios SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TFuncionarioRepository.EditarFuncionario(aFuncionario: TFuncionario): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE funcionarios SET');
    FQuery.SQL.Add('nome = :nome, cpf = :cpf, rg = :rg, nascimento = :nascimento, telefone = :telefone,');
    FQuery.SQL.Add('cep = :cep, rua = :rua, numero = :numero, bairro = :bairro, cidade = :cidade,');
    FQuery.SQL.Add('estado = :estado,tipo = :tipo, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString      := aFuncionario.getNome;
    FQuery.ParamByName('cpf').AsString       := aFuncionario.getCPF;
    FQuery.ParamByName('rg').AsString        := aFuncionario.getRG;
    FQuery.ParamByName('nascimento').AsString :=  aFuncionario.getNascimento;
    FQuery.ParamByName('telefone').AsString  := aFuncionario.getTelefone;
    FQuery.ParamByName('cep').AsString       := aFuncionario.getCEP;
    FQuery.ParamByName('rua').AsString       := aFuncionario.getRua;
    FQuery.ParamByName('numero').AsString    := aFuncionario.getNumero;
    FQuery.ParamByName('bairro').AsString    := aFuncionario.getBairro;
    FQuery.ParamByName('cidade').AsString    := aFuncionario.getCidade;
    FQuery.ParamByName('estado').AsString    := aFuncionario.getEstado;
    FQuery.ParamByName('tipo').AsString    := aFuncionario.getTipo;
    FQuery.ParamByName('ativo').AsBoolean    := aFuncionario.getAtivo;
    FQuery.ParamByName('id').AsInteger       := aFuncionario.getIdFuncionario;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar Funcionário: ' + E.Message);
  end;
end;

procedure TFuncionarioRepository.InserirFuncionario(aFuncionario: TFuncionario);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
 FQuery.SQL.Add('INSERT INTO funcionarios');
FQuery.SQL.Add('(nome, cpf, rg, nascimento, telefone, cep, rua, numero, bairro, cidade, estado, tipo, ativo)');
FQuery.SQL.Add('VALUES (:nome, :cpf, :rg, :nascimento, :telefone, :cep, :rua, :numero, :bairro, :cidade, :estado, :tipo, :ativo)');
  FQuery.ParamByName('nome').AsString      := aFuncionario.getNome;
  FQuery.ParamByName('cpf').AsString       := aFuncionario.getCPF;
  FQuery.ParamByName('rg').AsString        := aFuncionario.getRG;
  FQuery.ParamByName('nascimento').AsString:= aFuncionario.getNascimento;
  FQuery.ParamByName('telefone').AsString  := aFuncionario.getTelefone;
  FQuery.ParamByName('cep').AsString       := aFuncionario.getCEP;
  FQuery.ParamByName('rua').AsString       := aFuncionario.getRua;
  FQuery.ParamByName('numero').AsString    := aFuncionario.getNumero;
  FQuery.ParamByName('bairro').AsString    := aFuncionario.getBairro;
  FQuery.ParamByName('cidade').AsString    := aFuncionario.getCidade;
  FQuery.ParamByName('estado').AsString    := aFuncionario.getEstado;
  FQuery.ParamByName('tipo').AsString    := aFuncionario.getTipo;
  FQuery.ParamByName('ativo').AsBoolean    := aFuncionario.getAtivo;
  FQuery.ExecSQL;
end;

function TFuncionarioRepository.ExisteCPF(aFuncionario: TFuncionario): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM funcionarios WHERE cpf = :cpf AND id <> :id');
  FQuery.ParamByName('cpf').AsString := aFuncionario.getCPF;
  FQuery.ParamByName('id').AsInteger := aFuncionario.getIdFuncionario;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TFuncionarioRepository.ListarFuncionarios: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, rg, nascimento, telefone, cep, rua, numero, bairro, cidade, estado,tipo,ativo');
    FQuery.SQL.Add('FROM funcionarios WHERE ativo = TRUE ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Funcionários: ' + E.Message);
  end;
end;

function TFuncionarioRepository.ListarFuncionariosRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, rg, nascimento, telefone, cep, rua, numero, bairro, cidade, estado,tipo, ativo');
    FQuery.SQL.Add('FROM funcionarios WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Funcionários para restauração: ' + E.Message);
  end;
end;

function TFuncionarioRepository.PesquisarFuncionarios(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, cpf, rg, nascimento, telefone, cep, rua, numero, bairro, cidade, estado,tipo,ativo');
    FQuery.SQL.Add('FROM funcionarios');
    FQuery.SQL.Add('WHERE ((nome ILIKE :nome) OR (cpf LIKE :cpf) OR (telefone ILIKE :telefone) OR (tipo ILIKE :tipo))');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString      := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cpf').AsString       := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('telefone').AsString  := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('tipo').AsString  := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Funcionário por filtro: ' + E.Message);
  end;
end;

end.
