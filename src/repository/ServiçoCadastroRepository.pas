unit ServiçoCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uServiço, Data.DB, System.Classes;

type
  TServicoRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirServico(Servico: TServico);
    function EditarServico(Servico: TServico): Boolean;
    function ListarServicos: TDataSet;
    function ListarServicosRestaurar: TDataSet;
    procedure DeletarServico(const aId: Integer);
    procedure RestaurarServico(const aId: Integer);
    function PesquisarServicos(const aFiltro: String): TDataSet;
    function CarregarCategorias: TStringList;
    function CarregarPecas: TStringList;
    function CarregarProfissionais: TStringList;
  end;

implementation

constructor TServicoRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TServicoRepository.InserirServico(Servico: TServico);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO servicos (nome, categoria, preco, observacao , funcionario_id, ativo)');
  FQuery.SQL.Add('VALUES (:nome, :categoria, :preco, :observacao, :funcionario_id, :ativo)');
  FQuery.ParamByName('nome').AsString           := Servico.GetNome;
  FQuery.ParamByName('categoria').AsInteger     := Servico.GetCategoria;
  FQuery.ParamByName('preco').AsCurrency        := Servico.GetPreco;
  FQuery.ParamByName('observacao').AsString     := Servico.GetObservacao;
  FQuery.ParamByName('funcionario_id').AsInteger:= Servico.GetProfissional;
  FQuery.ParamByName('ativo').AsBoolean         := True;
  FQuery.ExecSQL;
end;

function TServicoRepository.EditarServico(Servico: TServico): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE servicos SET');
    FQuery.SQL.Add('nome = :nome, categoria = :categoria, preco = :preco, observacao = :observacao,');
    FQuery.SQL.Add('funcionario_id = :funcionario_id, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString           := Servico.GetNome;
    FQuery.ParamByName('categoria').AsInteger     := Servico.GetCategoria;
    FQuery.ParamByName('preco').AsCurrency        := Servico.GetPreco;
    FQuery.ParamByName('observacao').AsString     := Servico.GetObservacao;
    FQuery.ParamByName('funcionario_id').AsInteger:= Servico.GetProfissional;
    FQuery.ParamByName('ativo').AsBoolean         := True;
    FQuery.ParamByName('id').AsInteger            := Servico.GetId;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar serviço: ' + E.Message);
  end;
end;

function TServicoRepository.ListarServicos: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(
      'SELECT s.id, s.nome, ' +
      'c.nome AS categoria_nome, ' +
      's.preco, s.observacao, ' +
      'p.nome AS peca_nome, ' +
      'f.nome AS funcionario_nome, ' +
      's.ativo ' +
      'FROM servicos s ' +
      'LEFT JOIN categorias c ON c.id = s.categoria ' +
      'LEFT JOIN funcionarios f ON f.id = s.funcionario_id ' +
      'WHERE s.ativo = TRUE ' +
      'ORDER BY s.id'
    );
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar serviços: ' + E.Message);
  end;
end;

function TServicoRepository.ListarServicosRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(
      'SELECT s.id, s.nome, ' +
      'c.nome AS categoria_nome, ' +
      's.preco, s.observacao, ' +
      'p.nome AS peca_nome, ' +
      'f.nome AS funcionario_nome, ' +
      's.ativo ' +
      'FROM servicos s ' +
      'LEFT JOIN categorias c ON c.id = s.categoria ' +
      'LEFT JOIN funcionarios f ON f.id = s.funcionario_id ' +
      'WHERE s.ativo = FALSE ' +
      'ORDER BY s.id'
    );
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar serviços para restauração: ' + E.Message);
  end;
end;


procedure TServicoRepository.DeletarServico(const aId: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE servicos SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

procedure TServicoRepository.RestaurarServico(const aId: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE servicos SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

function TServicoRepository.PesquisarServicos(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(
      'SELECT s.id, s.nome, c.nome AS categoria_nome, s.preco, s.observacao, ' +
      'p.nome AS peca_nome, f.nome AS funcionario_nome, s.ativo ' +
      'FROM servicos s ' +
      'INNER JOIN categorias c ON s.categoria = c.id ' +
      'INNER JOIN funcionarios f ON s.funcionario_id = f.id ' +
      'WHERE (s.nome ILIKE :filtro OR s.observacao ILIKE :filtro) ' +
      'AND s.ativo = TRUE ' +
      'ORDER BY s.id'
    );
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar serviço por filtro: ' + E.Message);
  end;
end;

function TServicoRepository.CarregarCategorias: TStringList;
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

function TServicoRepository.CarregarPecas: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM pecas ORDER BY nome');
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
      raise Exception.Create('Erro ao listar Peças: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

function TServicoRepository.CarregarProfissionais: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM funcionarios ORDER BY nome');
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
      raise Exception.Create('Erro ao listar funcionarios: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

end.
