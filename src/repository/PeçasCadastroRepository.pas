unit PeçasCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uPeçasDTO, Data.DB;

type
  TPecaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirPeca(aPeca: TPecaDTO);
    function ExisteCodigoInterno(aPeca: TPecaDTO): Boolean;
    function EditarPeca(aPeca: TPecaDTO): Boolean;
    function ListarPecas: TDataSet;
    function ListarPecasRestaurar: TDataSet;
    procedure DeletarPeca(const aID: Integer);
    procedure RestaurarPeca(const aID: Integer);
    function PesquisarPecas(const aFiltro: String): TDataSet;
  end;

implementation

constructor TPecaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TPecaRepository.InserirPeca(aPeca: TPecaDTO);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO pecas');
  FQuery.SQL.Add('(nome, descricao, codigo_interno, categoria, unidade, modelo, ativo)');
  FQuery.SQL.Add('VALUES (:nome, :descricao, :codigo_interno, :categoria, :unidade, :modelo, :ativo)');
  FQuery.ParamByName('nome').AsString            := aPeca.getNome;
  FQuery.ParamByName('descricao').AsString       := aPeca.getDescricao;
  FQuery.ParamByName('codigo_interno').AsString  := aPeca.getCodigoInterno;
  FQuery.ParamByName('categoria').AsString       := aPeca.getCategoria;
  FQuery.ParamByName('unidade').AsString         := aPeca.getUnidade;
  FQuery.ParamByName('modelo').AsString          := aPeca.getModelo;
  FQuery.ParamByName('ativo').AsString          := aPeca.getStatus;
  FQuery.ExecSQL;
end;

function TPecaRepository.ExisteCodigoInterno(aPeca: TPecaDTO): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM pecas WHERE codigo_interno = :codigo_interno');
  FQuery.ParamByName('codigo_interno').AsString := aPeca.getCodigoInterno;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TPecaRepository.EditarPeca(aPeca: TPecaDTO): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pecas SET');
    FQuery.SQL.Add('nome = :nome, descricao = :descricao, codigo_interno = :codigo_interno,');
    FQuery.SQL.Add('categoria = :categoria, unidade = :unidade, modelo = :modelo, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString           := aPeca.getNome;
    FQuery.ParamByName('descricao').AsString      := aPeca.getDescricao;
    FQuery.ParamByName('codigo_interno').AsString := aPeca.getCodigoInterno;
    FQuery.ParamByName('categoria').AsString      := aPeca.getCategoria;
    FQuery.ParamByName('unidade').AsString        := aPeca.getUnidade;
    FQuery.ParamByName('modelo').AsString         := aPeca.getModelo;
    FQuery.ParamByName('ativo').AsString         := aPeca.getStatus;
    FQuery.ParamByName('id').AsInteger            := aPeca.getIdPeca;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar peça: ' + E.Message);
  end;
end;

function TPecaRepository.ListarPecas: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, descricao, codigo_interno, categoria, unidade, modelo, ativo');
    FQuery.SQL.Add('FROM pecas WHERE ativo = ''Ativo'' ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Peças: ' + E.Message);
  end;
end;

function TPecaRepository.ListarPecasRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, descricao, codigo_interno, categoria, unidade, modelo, ativo');
    FQuery.SQL.Add('FROM pecas WHERE ativo = ''Inativo''');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Peças para restauração: ' + E.Message);
  end;
end;

procedure TPecaRepository.DeletarPeca(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE pecas SET ativo = ''Inativo'' WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TPecaRepository.RestaurarPeca(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE pecas SET ativo = ''Ativo'' WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TPecaRepository.PesquisarPecas(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, descricao, codigo_interno, categoria, unidade, modelo, ativo');
    FQuery.SQL.Add('FROM pecas');
    FQuery.SQL.Add('WHERE (nome ILIKE :nome) OR (codigo_interno ILIKE :codigo_interno) OR (modelo ILIKE :modelo)');
    FQuery.SQL.Add('AND ativo = ''Ativo''');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString           := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('codigo_interno').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('modelo').AsString         := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Peça por filtro: ' + E.Message);
  end;
end;

end.
