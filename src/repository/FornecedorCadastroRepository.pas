unit FornecedorCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uFornecedorDTO, Data.DB;

type
  TFornecedorRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirFornecedor(aFornecedor: TFornecedorDTO);
    function ExisteCNPJ(aFornecedor: TFornecedorDTO): Boolean;
    function EditarFornecedor(aFornecedor: TFornecedorDTO): Boolean;
    function ListarFornecedores: TDataSet;
    function ListarFornecedoresRestaurar: TDataSet;
    procedure DeletarFornecedor(const aID: Integer);
    procedure RestaurarFornecedor(const aID: Integer);
    function PesquisarFornecedores(const aFiltro: String): TDataSet;
  end;

implementation

constructor TFornecedorRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TFornecedorRepository.InserirFornecedor(aFornecedor: TFornecedorDTO);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO fornecedores');
  FQuery.SQL.Add('(nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo)');
  FQuery.SQL.Add('VALUES (:nome, :razao_social, :cnpj, :telefone, :cep, :rua, :numero, :bairro, :cidade, :estado, :ativo)');
  FQuery.ParamByName('nome').AsString         := aFornecedor.getNome;
  FQuery.ParamByName('razao_social').AsString := aFornecedor.getRazaoSocial;
  FQuery.ParamByName('cnpj').AsString         := aFornecedor.getCNPJ;
  FQuery.ParamByName('telefone').AsString     := aFornecedor.getTelefone;
  FQuery.ParamByName('cep').AsString          := aFornecedor.getCEP;
  FQuery.ParamByName('rua').AsString          := aFornecedor.getRua;
  FQuery.ParamByName('numero').AsString       := aFornecedor.getNumero;
  FQuery.ParamByName('bairro').AsString       := aFornecedor.getBairro;
  FQuery.ParamByName('cidade').AsString       := aFornecedor.getCidade;
  FQuery.ParamByName('estado').AsString       := aFornecedor.getEstado;
  FQuery.ParamByName('ativo').AsBoolean       := aFornecedor.getAtivo;
  FQuery.ExecSQL;
end;

function TFornecedorRepository.ExisteCNPJ(aFornecedor: TFornecedorDTO): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM fornecedores WHERE cnpj = :cnpj');
  FQuery.ParamByName('cnpj').AsString := aFornecedor.getCNPJ;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TFornecedorRepository.EditarFornecedor(aFornecedor: TFornecedorDTO): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE fornecedores SET');
    FQuery.SQL.Add('nome = :nome, razao_social = :razao_social, cnpj = :cnpj, telefone = :telefone,');
    FQuery.SQL.Add('cep = :cep, rua = :rua, numero = :numero, bairro = :bairro, cidade = :cidade, estado = :estado, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString         := aFornecedor.getNome;
    FQuery.ParamByName('razao_social').AsString := aFornecedor.getRazaoSocial;
    FQuery.ParamByName('cnpj').AsString         := aFornecedor.getCNPJ;
    FQuery.ParamByName('telefone').AsString     := aFornecedor.getTelefone;
    FQuery.ParamByName('cep').AsString          := aFornecedor.getCEP;
    FQuery.ParamByName('rua').AsString          := aFornecedor.getRua;
    FQuery.ParamByName('numero').AsString       := aFornecedor.getNumero;
    FQuery.ParamByName('bairro').AsString       := aFornecedor.getBairro;
    FQuery.ParamByName('cidade').AsString       := aFornecedor.getCidade;
    FQuery.ParamByName('estado').AsString       := aFornecedor.getEstado;
    FQuery.ParamByName('ativo').AsBoolean       := aFornecedor.getAtivo;
    FQuery.ParamByName('id').AsInteger          := aFornecedor.getIdFornecedor;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar Fornecedor: ' + E.Message);
  end;
end;

function TFornecedorRepository.ListarFornecedores: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores WHERE ativo = TRUE ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Fornecedores: ' + E.Message);
  end;
end;

function TFornecedorRepository.ListarFornecedoresRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Fornecedores para restauração: ' + E.Message);
  end;
end;

procedure TFornecedorRepository.DeletarFornecedor(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE fornecedores SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TFornecedorRepository.RestaurarFornecedor(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE fornecedores SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TFornecedorRepository.PesquisarFornecedores(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores');
    FQuery.SQL.Add('WHERE (nome ILIKE :nome) OR (razao_social ILIKE :razao_social) OR (cnpj LIKE :cnpj) OR (telefone ILIKE :telefone)');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString         := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('razao_social').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cnpj').AsString         := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('telefone').AsString     := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Fornecedor por filtro: ' + E.Message);
  end;
end;

end.
