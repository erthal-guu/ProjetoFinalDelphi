unit PendenciaRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uPendencia, Data.DB, Generics.Collections, System.Classes, uCliente;

type
  TPendenciaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure PagarPendencia(aPendencia: TPendencia);
    function EditarPendencia(aPendencia: TPendencia): Boolean;
    procedure DeletarPendencia(const aID: Integer);
    procedure ConcluirPendencia(aPendencia: TPendencia);
    function ListarPendencias: TDataSet;
    function ListarPendenciasRestaurar: TDataSet;
    function ListarHistoricoPendencias: TDataSet;
    function PesquisarPendencias(const aFiltro: String): TDataSet;
    function CarregarClientes: TDataSet;
    function ExistePendencia(aPendencia: TPendencia): Boolean;
    procedure RestaurarPendencia(const aID: Integer);
  end;

implementation

constructor TPendenciaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TPendenciaRepository.PagarPendencia(aPendencia: TPendencia);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('INSERT INTO pendencias (id_cliente, descricao, valor_total,');
    FQuery.SQL.Add('    data_vencimento, data_criacao, status, observacao, ativo)');
    FQuery.SQL.Add('VALUES (:id_cliente, :descricao, :valor_total,');
    FQuery.SQL.Add('        :data_vencimento, :data_criacao, :status, :observacao, :ativo)');
    FQuery.ParamByName('id_cliente').AsInteger := aPendencia.getIdCliente;
    FQuery.ParamByName('descricao').AsString := aPendencia.getDescricao;
    FQuery.ParamByName('valor_total').AsCurrency := aPendencia.getValorTotal;
    FQuery.ParamByName('data_vencimento').AsDateTime := aPendencia.getDataVencimento;
    FQuery.ParamByName('data_criacao').AsDateTime := aPendencia.getDataCriacao;
    FQuery.ParamByName('status').AsString := aPendencia.getStatus;
    FQuery.ParamByName('observacao').AsString := aPendencia.getObservacao;
    FQuery.ParamByName('ativo').AsBoolean := aPendencia.getAtivo;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir pendência: ' + E.Message);
  end;
end;

function TPendenciaRepository.EditarPendencia(aPendencia: TPendencia): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pendencias');
    FQuery.SQL.Add('SET id_cliente = :id_cliente, descricao = :descricao,');
    FQuery.SQL.Add('    valor_total = :valor_total, data_vencimento = :data_vencimento,');
    FQuery.SQL.Add('    status = :status, observacao = :observacao');
    FQuery.SQL.Add('WHERE id = :id AND ativo = TRUE');
    FQuery.ParamByName('id_cliente').AsInteger := aPendencia.getIdCliente;
    FQuery.ParamByName('descricao').AsString := aPendencia.getDescricao;
    FQuery.ParamByName('valor_total').AsCurrency := aPendencia.getValorTotal;
    FQuery.ParamByName('data_vencimento').AsDateTime := aPendencia.getDataVencimento;
    FQuery.ParamByName('status').AsString := aPendencia.getStatus;
    FQuery.ParamByName('observacao').AsString := aPendencia.getObservacao;
    FQuery.ParamByName('id').AsInteger := aPendencia.getId;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar pendência: ' + E.Message);
  end;
end;

procedure TPendenciaRepository.DeletarPendencia(const aID: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pendencias SET ativo = FALSE WHERE id = :id');
    FQuery.ParamByName('id').AsInteger := aID;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao deletar pendência: ' + E.Message);
  end;
end;

procedure TPendenciaRepository.ConcluirPendencia(aPendencia: TPendencia);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pendencias');
    FQuery.SQL.Add('SET status = :status, observacao = :observacao');
    FQuery.SQL.Add('WHERE id = :id AND ativo = TRUE');
    FQuery.ParamByName('status').AsString := aPendencia.getStatus;
    FQuery.ParamByName('observacao').AsString := aPendencia.getObservacao;
    FQuery.ParamByName('id').AsInteger := aPendencia.getId;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao concluir pendência: ' + E.Message);
  end;
end;

function TPendenciaRepository.ListarPendencias: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT ');
    FQuery.SQL.Add('  p.id,');
    FQuery.SQL.Add('  p.id_pedido,');
    FQuery.SQL.Add('  p.id_cliente,');
    FQuery.SQL.Add('  f.nome AS cliente_nome,');
    FQuery.SQL.Add('  p.descricao,');
    FQuery.SQL.Add('  p.valor_total,');
    FQuery.SQL.Add('  p.data_vencimento,');
    FQuery.SQL.Add('  p.data_criacao,');
    FQuery.SQL.Add('  p.status');
    FQuery.SQL.Add('FROM pendencias p');
    FQuery.SQL.Add('LEFT JOIN fornecedores f ON p.id_cliente = f.id');
    FQuery.SQL.Add('WHERE p.ativo = TRUE AND p.status <> ''CONCLUIDA''');
    FQuery.SQL.Add('ORDER BY p.data_vencimento ASC');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar pendências: ' + E.Message);
  end;
end;

function TPendenciaRepository.ListarPendenciasRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT p.id, f.nome AS cliente_nome, p.descricao,');
    FQuery.SQL.Add('       p.valor_total, p.data_vencimento, p.data_criacao,');
    FQuery.SQL.Add('       p.status, p.observacao, p.ativo');
    FQuery.SQL.Add('FROM pendencias p');
    FQuery.SQL.Add('LEFT JOIN fornecedores f ON p.id_cliente = f.id');
    FQuery.SQL.Add('WHERE p.ativo = FALSE');
    FQuery.SQL.Add('ORDER BY p.id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar pendências para restauração: ' + E.Message);
  end;
end;

function TPendenciaRepository.ListarHistoricoPendencias: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT p.id, f.nome AS cliente_nome, p.descricao,');
    FQuery.SQL.Add('       p.valor_total, p.data_vencimento, p.data_criacao,');
    FQuery.SQL.Add('       p.status, p.observacao, p.ativo');
    FQuery.SQL.Add('FROM pendencias p');
    FQuery.SQL.Add('LEFT JOIN fornecedores f ON p.id_cliente = f.id');
    FQuery.SQL.Add('ORDER BY p.id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar histórico de pendências: ' + E.Message);
  end;
end;

function TPendenciaRepository.PesquisarPendencias(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT p.id, f.nome AS cliente_nome, p.descricao,');
    FQuery.SQL.Add('       p.valor_total, p.data_vencimento, p.data_criacao,');
    FQuery.SQL.Add('       p.status, p.observacao, p.ativo');
    FQuery.SQL.Add('FROM pendencias p');
    FQuery.SQL.Add('LEFT JOIN fornecedores f ON p.id_cliente = f.id');
    FQuery.SQL.Add('WHERE (p.descricao ILIKE :filtro OR');
    FQuery.SQL.Add('       f.nome ILIKE :filtro OR');
    FQuery.SQL.Add('       p.status ILIKE :filtro OR');
    FQuery.SQL.Add('       p.observacao ILIKE :filtro)');
    FQuery.SQL.Add('  AND p.ativo = TRUE');
    FQuery.SQL.Add('ORDER BY p.data_vencimento ASC');
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao pesquisar pendências: ' + E.Message);
  end;
end;

function TPendenciaRepository.CarregarClientes: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, nome FROM clientes WHERE ativo = TRUE ORDER BY nome');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar clientes: ' + E.Message);
  end;
end;

function TPendenciaRepository.ExistePendencia(aPendencia: TPendencia): Boolean;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COUNT(*) FROM pendencias');
    FQuery.SQL.Add('WHERE id_cliente = :id_cliente AND descricao = :descricao');
    FQuery.SQL.Add('  AND ativo = TRUE');

    if aPendencia.getId > 0 then
      FQuery.SQL.Add('  AND id <> :id');

    FQuery.ParamByName('id_cliente').AsInteger := aPendencia.getIdCliente;
    FQuery.ParamByName('descricao').AsString := aPendencia.getDescricao;

    if aPendencia.getId > 0 then
      FQuery.ParamByName('id').AsInteger := aPendencia.getId;

    FQuery.Open;
    Result := FQuery.Fields[0].AsInteger > 0;
    FQuery.Close;
  except
    on E: Exception do
      raise Exception.Create('Erro ao verificar existência de pendência: ' + E.Message);
  end;
end;

procedure TPendenciaRepository.RestaurarPendencia(const aID: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE pendencias SET ativo = TRUE WHERE id = :id');
    FQuery.ParamByName('id').AsInteger := aID;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao restaurar pendência: ' + E.Message);
  end;
end;

end.
