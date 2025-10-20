unit PeçasCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uPeças, Data.DB, System.Classes;

type
  TPecaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirPeca(aPeca: TPeca);
    function ExisteCodigoInterno(aPeca: TPeca): Boolean;
    function EditarPeca(aPeca: TPeca): Boolean;
    function ListarPecas: TDataSet;
    function ListarPecasRestaurar: TDataSet;
    procedure DeletarPeca(const aID: Integer);
    procedure RestaurarPeca(const aID: Integer);
    function PesquisarPecas(const aFiltro: String): TDataSet;
    function CarregarCategorias: TStringList;
  end;

implementation

constructor TPecaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TPecaRepository.InserirPeca(aPeca: TPeca);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO pecas (nome, descricao, codigo_interno, id_categoria, unidade, modelo, ativo, preco_compra)');
  FQuery.SQL.Add('VALUES (:nome, :descricao, :codigo_interno, :id_categoria, :unidade, :modelo, :ativo, :preco_compra)');
  FQuery.ParamByName('nome').AsString           := aPeca.getNome;
  FQuery.ParamByName('descricao').AsString      := aPeca.getDescricao;
  FQuery.ParamByName('codigo_interno').AsString := aPeca.getCodigoInterno;
  FQuery.ParamByName('id_categoria').AsInteger     := aPeca.getCategoria;
  FQuery.ParamByName('unidade').AsString       := aPeca.getUnidade;
  FQuery.ParamByName('modelo').AsString        := aPeca.getModelo;
  FQuery.ParamByName('ativo').AsBoolean         := aPeca.getAtivo;
  FQuery.ParamByName('preco_compra').AsCurrency := aPeca.getPreço;
  FQuery.ExecSQL;
end;

function TPecaRepository.ExisteCodigoInterno(aPeca: TPeca): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM pecas WHERE codigo_interno = :codigo_interno');
  FQuery.ParamByName('codigo_interno').AsString := aPeca.getCodigoInterno;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TPecaRepository.EditarPeca(aPeca: TPeca): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pecas SET');
    FQuery.SQL.Add('nome = :nome, descricao = :descricao, codigo_interno = :codigo_interno,');
    FQuery.SQL.Add('id_categoria = :categoria, unidade = :unidade, modelo = :modelo, ativo = :ativo, preco_compra = :preco_compra');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString           := aPeca.getNome;
    FQuery.ParamByName('descricao').AsString      := aPeca.getDescricao;
    FQuery.ParamByName('codigo_interno').AsString := aPeca.getCodigoInterno;
    FQuery.ParamByName('categoria').AsInteger   := aPeca.getCategoria;
    FQuery.ParamByName('unidade').AsString       := aPeca.getUnidade;
    FQuery.ParamByName('modelo').AsString        := aPeca.getModelo;
    FQuery.ParamByName('ativo').AsBoolean         := aPeca.getAtivo;
    FQuery.ParamByName('preco_compra').AsCurrency := aPeca.getPreço;
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
    FQuery.SQL.Add('SELECT ');
    FQuery.SQL.Add('  p.id, ');
    FQuery.SQL.Add('  p.nome, ');
    FQuery.SQL.Add('  p.descricao AS "Descrição", ');
    FQuery.SQL.Add('  p.codigo_interno AS "Código interno", ');
    FQuery.SQL.Add('  c.nome AS "Categoria", ');
    FQuery.SQL.Add('  p.preco_compra AS "Preço", ');
    FQuery.SQL.Add('  p.unidade AS "Unidade", ');
    FQuery.SQL.Add('  p.modelo AS "Modelo", ');
    FQuery.SQL.Add('  p.ativo ');
    FQuery.SQL.Add('FROM pecas p ');
    FQuery.SQL.Add('INNER JOIN categorias c ON p.id_categoria = c.id ');
    FQuery.SQL.Add('WHERE p.ativo = TRUE ');
    FQuery.SQL.Add('ORDER BY p.id');
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
    FQuery.SQL.Add('SELECT id, nome, descricao, codigo_interno, id_categoria, unidade, modelo, ativo, preco_compra');
    FQuery.SQL.Add('FROM pecas WHERE ativo = FALSE');
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
  FQuery.SQL.Add('UPDATE pecas SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TPecaRepository.RestaurarPeca(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE pecas SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TPecaRepository.PesquisarPecas(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome, descricao, codigo_interno, id_categoria, unidade, modelo, ativo, preco_compra');
    FQuery.SQL.Add('FROM pecas');
    FQuery.SQL.Add('WHERE (nome ILIKE :filtro OR codigo_interno ILIKE :filtro OR modelo ILIKE :filtro)');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Peça por filtro: ' + E.Message);
  end;
end;

function TPecaRepository.CarregarCategorias: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM categorias ORDER BY nome');
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
      raise Exception.Create('Erro ao listar Categorias: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

end.

