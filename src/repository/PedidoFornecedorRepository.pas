unit PedidoFornecedorRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, Data.DB, System.Classes;

type
  TPedidoFornecedorRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);

    // Operações de Pedido
    procedure InserirPedido(aIdFornecedor: Integer; aDataPedido: TDateTime;
      aStatus: String; aObservacao: String; aValorTotal: Currency);
    function ListarPedidos: TDataSet;
    procedure DeletarPedido(const aId: Integer);
    function PesquisarPedidos(const aFiltro: String): TDataSet;

    // Operações com peças do pedido
    procedure InserirPecaPedido(aIdPedido, aIdPeca: Integer; aQuantidade: Integer; aPrecoUnitario: Currency);
    function ListarPecasDoPedido(aIdPedido: Integer): TDataSet;

    // Carregamentos para combobox
    function CarregarFornecedores: TStringList;
    function CarregarPecas: TStringList;
    function ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
  end;

implementation

constructor TPedidoFornecedorRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TPedidoFornecedorRepository.InserirPedido(aIdFornecedor: Integer;
  aDataPedido: TDateTime; aStatus: String; aObservacao: String; aValorTotal: Currency);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO pedidos_fornecedor (id_fornecedor, data_pedido, status, observacao, valor_total, ativo)');
  FQuery.SQL.Add('VALUES (:id_fornecedor, :data_pedido, :status, :observacao, :valor_total, :ativo)');
  FQuery.ParamByName('id_fornecedor').AsInteger := aIdFornecedor;
  FQuery.ParamByName('data_pedido').AsDateTime := aDataPedido;
  FQuery.ParamByName('status').AsString := aStatus;
  FQuery.ParamByName('observacao').AsString := aObservacao;
  FQuery.ParamByName('valor_total').AsCurrency := aValorTotal;
  FQuery.ParamByName('ativo').AsBoolean := True;
  FQuery.ExecSQL;
end;

function TPedidoFornecedorRepository.ListarPedidos: TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT p.id_pedido, f.nome as fornecedor, p.data_pedido, p.status, p.observacao, p.valor_total');
  FQuery.SQL.Add('FROM pedidos_fornecedor p');
  FQuery.SQL.Add('INNER JOIN fornecedores f ON p.id_fornecedor = f.id_fornecedor');
  FQuery.SQL.Add('WHERE p.ativo = 1');
  FQuery.SQL.Add('ORDER BY p.data_pedido DESC');
  FQuery.Open;
  Result := FQuery;
end;

procedure TPedidoFornecedorRepository.DeletarPedido(const aId: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE pedidos_fornecedor SET ativo = 0 WHERE id_pedido = :id');
  FQuery.ParamByName('id').AsInteger := aId;
  FQuery.ExecSQL;
end;

function TPedidoFornecedorRepository.PesquisarPedidos(const aFiltro: String): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT p.id_pedido, f.nome as fornecedor, p.data_pedido, p.status, p.observacao, p.valor_total');
  FQuery.SQL.Add('FROM pedidos_fornecedor p');
  FQuery.SQL.Add('INNER JOIN fornecedores f ON p.id_fornecedor = f.id_fornecedor');
  FQuery.SQL.Add('WHERE p.ativo = 1 AND (f.nome LIKE :filtro OR p.status LIKE :filtro OR p.observacao LIKE :filtro)');
  FQuery.ParamByName('filtro').AsString := '%' + aFiltro + '%';
  FQuery.Open;
  Result := FQuery;
end;

procedure TPedidoFornecedorRepository.InserirPecaPedido(aIdPedido, aIdPeca: Integer;
  aQuantidade: Integer; aPrecoUnitario: Currency);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO itens_pedido (id_pedido, id_peca, quantidade, preco_unitario, subtotal)');
  FQuery.SQL.Add('VALUES (:id_pedido, :id_peca, :quantidade, :preco_unitario, :subtotal)');
  FQuery.ParamByName('id_pedido').AsInteger := aIdPedido;
  FQuery.ParamByName('id_peca').AsInteger := aIdPeca;
  FQuery.ParamByName('quantidade').AsInteger := aQuantidade;
  FQuery.ParamByName('preco_unitario').AsCurrency := aPrecoUnitario;
  FQuery.ParamByName('subtotal').AsCurrency := aQuantidade * aPrecoUnitario;
  FQuery.ExecSQL;
end;

function TPedidoFornecedorRepository.ListarPecasDoPedido(aIdPedido: Integer): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT ip.id_peca, p.nome as peca, ip.quantidade, ip.preco_unitario, ip.subtotal');
  FQuery.SQL.Add('FROM itens_pedido ip');
  FQuery.SQL.Add('INNER JOIN pecas p ON ip.id_peca = p.id');
  FQuery.SQL.Add('WHERE ip.id_pedido = :id_pedido');
  FQuery.ParamByName('id_pedido').AsInteger := aIdPedido;
  FQuery.Open;
  Result := FQuery;
end;

function TPedidoFornecedorRepository.CarregarFornecedores: TStringList;
begin
  Result := TStringList.Create;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id_fornecedor, nome FROM fornecedores WHERE ativo = 1 ORDER BY nome');
    FQuery.Open;

    while not FQuery.Eof do
    begin
      Result.AddObject(FQuery.FieldByName('nome').AsString,
        TObject(FQuery.FieldByName('id_fornecedor').AsInteger));
      FQuery.Next;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TPedidoFornecedorRepository.CarregarPecas: TStringList;
begin
  Result := TStringList.Create;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id_peca, nome FROM pecas WHERE ativo = 1 ORDER BY nome');
    FQuery.Open;

    while not FQuery.Eof do
    begin
      Result.AddObject(FQuery.FieldByName('nome').AsString,
        TObject(FQuery.FieldByName('id_peca').AsInteger));
      FQuery.Next;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TPedidoFornecedorRepository.ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT preco_compra FROM pecas WHERE id_peca = :id_peca');
  FQuery.ParamByName('id_peca').AsInteger := aIdPeca;
  FQuery.Open;

  if not FQuery.Eof then
    Result := FQuery.FieldByName('preco_compra').AsCurrency
  else
    Result := 0;
end;

end.