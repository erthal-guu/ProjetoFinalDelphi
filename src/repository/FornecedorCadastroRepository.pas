unit FornecedorCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uFornecedor, Data.DB,
  System.Classes, System.Generics.Collections;

type
  TFornecedorRepository = class
  private
    FQuery: TFDQuery;

  public
    constructor Create(Query: TFDQuery);
    procedure InserirFornecedor(aFornecedor: TFornecedor);
    function ExisteCNPJ(aFornecedor: TFornecedor): Boolean;
    function EditarFornecedor(aFornecedor: TFornecedor): Boolean;
    function ListarFornecedores: TDataSet;
    function ListarFornecedoresRestaurar: TDataSet;
    procedure DeletarFornecedor(const aID: Integer);
    procedure RestaurarFornecedor(const aID: Integer);
    function PesquisarFornecedores(const aFiltro: String): TDataSet;
    function PesquisarFornecedoresRestaurar(const aFiltro: String): TDataSet;
    procedure VincularPecaFornecedor(const aFornecedorId, aPecaId: Integer);
    function ListarPecasVinculadas(const aFornecedorId: Integer): TDataSet;
    function CarregarFornecedores: TStringlist;
    procedure DesvincularPecaFornecedor(const aFornecedorId, aPecaId: Integer);
    function InserirPedido(aIdFornecedor: Integer; aFormaPagamento: string;
      aValorTotal: Currency; aObservacao: string): Integer;
    procedure InserirItemPedido(aIdPedido: Integer; aIdPeca: Integer;
      aQuantidade: Integer; aValorUnitario: Currency);
    function CarregarPecas: TStringlist;
    function ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
    function CarregarPecasPorFornecedor(aIdFornecedor: Integer): TStringlist;
    Function PeçajaVinculada(const aIdFornecedor, aPecaId: Integer): Boolean;
  end;

implementation

function TFornecedorRepository.CarregarFornecedores: TStringlist;
var
  Lista: TStringlist;
  Qry: TFDQuery;
begin
  Lista := TStringlist.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add
      ('SELECT id, nome FROM Fornecedores WHERE ativo = TRUE ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do begin
      Lista.AddObject(Qry.FieldByName('nome').AsString,
        TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  except
    on E: Exception do begin
      Lista.Free;
      raise Exception.Create('Erro ao listar Fornecedores: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

constructor TFornecedorRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

  procedure TFornecedorRepository.VincularPecaFornecedor(const aFornecedorId,
    aPecaId: Integer);
  begin
    try
      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('INSERT INTO peca_fornecedor (fornecedor_id, peca_id)');
      FQuery.SQL.Add('VALUES (:fornecedor_id, :peca_id)');
      FQuery.ParamByName('fornecedor_id').AsInteger := aFornecedorId;
      FQuery.ParamByName('peca_id').AsInteger := aPecaId;
      FQuery.ExecSQL;
    except
      on E: Exception do
        raise Exception.Create('Erro ao vincular peça ao fornecedor: ' +
          E.Message);
    end;
  end;

function TFornecedorRepository.ListarPecasVinculadas(const aFornecedorId
  : Integer): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add
      ('SELECT p.id, p.nome, p.descricao, p.codigo_interno, pf.fornecedor_id');
    FQuery.SQL.Add('FROM pecas p');
    FQuery.SQL.Add('INNER JOIN peca_fornecedor pf ON p.id = pf.peca_id');
    FQuery.SQL.Add('WHERE pf.fornecedor_id = :id');
    FQuery.SQL.Add('ORDER BY p.nome');
    FQuery.ParamByName('id').AsInteger := aFornecedorId;
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar peças vinculadas: ' + E.Message);
  end;
end;

procedure TFornecedorRepository.InserirFornecedor(aFornecedor: TFornecedor);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO fornecedores');
  FQuery.SQL.Add
    ('(nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo)');
  FQuery.SQL.Add
    ('VALUES (:nome, :razao_social, :cnpj, :telefone, :cep, :rua, :numero, :bairro, :cidade, :estado, :ativo)');
  FQuery.ParamByName('nome').AsString := aFornecedor.getNome;
  FQuery.ParamByName('razao_social').AsString := aFornecedor.getRazaoSocial;
  FQuery.ParamByName('cnpj').AsString := aFornecedor.getCNPJ;
  FQuery.ParamByName('telefone').AsString := aFornecedor.getTelefone;
  FQuery.ParamByName('cep').AsString := aFornecedor.getCEP;
  FQuery.ParamByName('rua').AsString := aFornecedor.getRua;
  FQuery.ParamByName('numero').AsString := aFornecedor.getNumero;
  FQuery.ParamByName('bairro').AsString := aFornecedor.getBairro;
  FQuery.ParamByName('cidade').AsString := aFornecedor.getCidade;
  FQuery.ParamByName('estado').AsString := aFornecedor.getEstado;
  FQuery.ParamByName('ativo').AsBoolean := aFornecedor.getAtivo;
  FQuery.ExecSQL;
end;

function TFornecedorRepository.ExisteCNPJ(aFornecedor: TFornecedor): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add
    ('SELECT COUNT(*) AS Total FROM fornecedores WHERE cnpj = :cnpj');
  FQuery.ParamByName('cnpj').AsString := aFornecedor.getCNPJ;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TFornecedorRepository.EditarFornecedor(aFornecedor
  : TFornecedor): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE fornecedores SET');
    FQuery.SQL.Add
      ('nome = :nome, razao_social = :razao_social, cnpj = :cnpj, telefone = :telefone,');
    FQuery.SQL.Add
      ('cep = :cep, rua = :rua, numero = :numero, bairro = :bairro, cidade = :cidade, estado = :estado, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('nome').AsString := aFornecedor.getNome;
    FQuery.ParamByName('razao_social').AsString := aFornecedor.getRazaoSocial;
    FQuery.ParamByName('cnpj').AsString := aFornecedor.getCNPJ;
    FQuery.ParamByName('telefone').AsString := aFornecedor.getTelefone;
    FQuery.ParamByName('cep').AsString := aFornecedor.getCEP;
    FQuery.ParamByName('rua').AsString := aFornecedor.getRua;
    FQuery.ParamByName('numero').AsString := aFornecedor.getNumero;
    FQuery.ParamByName('bairro').AsString := aFornecedor.getBairro;
    FQuery.ParamByName('cidade').AsString := aFornecedor.getCidade;
    FQuery.ParamByName('estado').AsString := aFornecedor.getEstado;
    FQuery.ParamByName('ativo').AsBoolean := aFornecedor.getAtivo;
    FQuery.ParamByName('id').AsInteger := aFornecedor.getIdFornecedor;
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
    FQuery.SQL.Add
      ('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
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
    FQuery.SQL.Add
      ('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Fornecedores para restauração: ' +
        E.Message);
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

procedure TFornecedorRepository.DesvincularPecaFornecedor(const aFornecedorId,
  aPecaId: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('DELETE FROM peca_fornecedor');
    FQuery.SQL.Add
      ('WHERE fornecedor_id = :fornecedor_id AND peca_id = :peca_id');
    FQuery.ParamByName('fornecedor_id').AsInteger := aFornecedorId;
    FQuery.ParamByName('peca_id').AsInteger := aPecaId;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao desvincular peça do fornecedor: ' +
        E.Message);
  end;
end;

procedure TFornecedorRepository.RestaurarFornecedor(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE fornecedores SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TFornecedorRepository.PesquisarFornecedores(const aFiltro: String)
  : TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add
      ('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores');
    FQuery.SQL.Add('WHERE (nome ILIKE :nome) OR (razao_social ILIKE :razao_social) OR (cnpj LIKE :cnpj) OR (telefone ILIKE :telefone)');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('razao_social').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cnpj').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('telefone').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Fornecedor por filtro: ' +
        E.Message);
  end;
end;

function TFornecedorRepository.PesquisarFornecedoresRestaurar(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add
      ('SELECT id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo');
    FQuery.SQL.Add('FROM fornecedores');
    FQuery.SQL.Add
      ('WHERE (nome ILIKE :nome) OR (razao_social ILIKE :razao_social) OR (cnpj LIKE :cnpj) OR (telefone ILIKE :telefone)');
    FQuery.SQL.Add('AND ativo = FALSE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('nome').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('razao_social').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('cnpj').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.ParamByName('telefone').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Fornecedor por filtro: ' +
        E.Message);
  end;
end;

function TFornecedorRepository.PeçajaVinculada(const aIdFornecedor,
    aPecaId: Integer): Boolean;
  begin
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM peca_fornecedor ' +
                   'WHERE fornecedor_id = :fornecedor_id AND peca_id = :peca_id');
    FQuery.ParamByName('fornecedor_id').AsInteger := aIdFornecedor;
    FQuery.ParamByName('peca_id').AsInteger := aPecaId;
    FQuery.Open;
    Result := FQuery.FieldByName('Total').AsInteger > 0;
  end;

function TFornecedorRepository.InserirPedido(aIdFornecedor: Integer;
  aFormaPagamento: string; aValorTotal: Currency; aObservacao: string): Integer;
begin
  Result := 0;

  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('INSERT INTO pedidos (id_fornecedor, forma_pagamento, valor_total, data_pedido, status_pedido, observacao)');
    FQuery.SQL.Add('VALUES (:id_fornecedor, :forma_pagamento, :valor_total, :data_pedido, :status_pedido, :observacao)');
    FQuery.SQL.Add('RETURNING id_pedido');
    FQuery.ParamByName('id_fornecedor').AsInteger := aIdFornecedor;
    FQuery.ParamByName('forma_pagamento').AsString := aFormaPagamento;
    FQuery.ParamByName('valor_total').AsCurrency := aValorTotal;
    FQuery.ParamByName('data_pedido').AsDateTime := Now;
    FQuery.ParamByName('status_pedido').AsString := 'ABERTO';
    FQuery.ParamByName('observacao').AsString := aObservacao;

    FQuery.Open;

    if not FQuery.IsEmpty then
    begin
      Result := FQuery.FieldByName('id_pedido').AsInteger;

      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('INSERT INTO pendencias (id_cliente, descricao, valor_total, data_vencimento, data_criacao, status, observacao, ativo, id_pedido, id_fornecedor)');
      FQuery.SQL.Add('VALUES (:id_cliente, :descricao, :valor_total, :data_vencimento, :data_criacao, :status, :observacao, :ativo, :id_pedido, :id_fornecedor)');
      FQuery.ParamByName('id_cliente').AsInteger := aIdFornecedor;
      FQuery.ParamByName('descricao').AsString := 'Pedido #' + IntToStr(Result);
      FQuery.ParamByName('valor_total').AsCurrency := aValorTotal;
      FQuery.ParamByName('data_vencimento').AsDateTime := Now + 30;
      FQuery.ParamByName('data_criacao').AsDateTime := Now;
      FQuery.ParamByName('status').AsString := 'PENDENTE';
      FQuery.ParamByName('observacao').AsString := aObservacao;
      FQuery.ParamByName('ativo').AsBoolean := True;
      FQuery.ParamByName('id_pedido').AsInteger := Result;
      FQuery.ParamByName('id_fornecedor').AsInteger := aIdFornecedor;

      FQuery.ExecSQL;
    end;

  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir pedido: ' + E.Message);
  end;
end;

procedure TFornecedorRepository.InserirItemPedido(aIdPedido: Integer;
  aIdPeca: Integer; aQuantidade: Integer; aValorUnitario: Currency);
var
  ValorTotalItem: Currency;
begin
  ValorTotalItem := aValorUnitario * aQuantidade;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add
    ('INSERT INTO itens_pedido (id_pedido, id_peca, quantidade, valor_unitario, valor_total)');
  FQuery.SQL.Add
    ('VALUES (:id_pedido, :id_peca, :quantidade, :valor_unitario, :valor_total)');

  FQuery.ParamByName('id_pedido').AsInteger := aIdPedido;
  FQuery.ParamByName('id_peca').AsInteger := aIdPeca;
  FQuery.ParamByName('quantidade').AsInteger := aQuantidade;
  FQuery.ParamByName('valor_unitario').AsCurrency := aValorUnitario;
  FQuery.ParamByName('valor_total').AsCurrency := ValorTotalItem;

  try
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir item do pedido: ' + E.Message);
  end;
end;

function TFornecedorRepository.CarregarPecasPorFornecedor
  (aIdFornecedor: Integer): TStringlist;
var
  Lista: TStringlist;
  Qry: TFDQuery;
begin
  Lista := TStringlist.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT p.id, p.nome');
    Qry.SQL.Add('FROM pecas p');
    Qry.SQL.Add('INNER JOIN peca_fornecedor pf ON p.id = pf.peca_id');
    Qry.SQL.Add('WHERE pf.fornecedor_id = :fornecedor_id');
    Qry.SQL.Add('AND p.ativo = TRUE');
    Qry.SQL.Add('ORDER BY p.nome');
    Qry.ParamByName('fornecedor_id').AsInteger := aIdFornecedor;
    Qry.Open;

    while not Qry.Eof do begin
      Lista.AddObject(Qry.FieldByName('nome').AsString,
        TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  except
    on E: Exception do begin
      Lista.Free;
      raise Exception.Create('Erro ao listar peças do fornecedor: ' +
        E.Message);
    end;
  end;
  Qry.Free;
end;

function TFornecedorRepository.CarregarPecas: TStringlist;
var
  Lista: TStringlist;
  Qry: TFDQuery;
begin
  Lista := TStringlist.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM pecas WHERE ativo = TRUE ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do begin
      Lista.AddObject(Qry.FieldByName('nome').AsString,
        TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  except
    on E: Exception do begin
      Lista.Free;
      raise Exception.Create('Erro ao listar peças: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

function TFornecedorRepository.ObterPrecoCompraPeca(aIdPeca: Integer): Currency;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add
      ('SELECT preco_compra FROM pecas WHERE id = :id_peca AND ativo = TRUE');
    FQuery.ParamByName('id_peca').AsInteger := aIdPeca;
    FQuery.Open;

    if not FQuery.Eof then
      Result := FQuery.FieldByName('preco_compra').AsCurrency
    else
      Result := 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao obter preço da peça: ' + E.Message);
  end;
end;

end.
