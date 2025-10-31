unit FornecedorCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uFornecedor, Data.DB,System.Classes;

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
    procedure VincularPecaFornecedor(const aFornecedorId, aPecaId: Integer);
    function ListarPecasVinculadas(const aFornecedorId: Integer): TDataSet;
    Function CarregarFornecedores : TStringlist;
    procedure DesvincularPecaFornecedor(const aFornecedorId,aPecaId : Integer);
    Function InserirPedido(aIdPeca: Integer; aValorTotal: Currency):Boolean;
    function CarregarPecas: TStringList;
    function ObterPrecoCompraPeca(aIdPeca: Integer): Currency;

  end;

implementation

function TFornecedorRepository.CarregarFornecedores: TStringlist;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM Fornecedores ORDER BY nome');
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

procedure TFornecedorRepository.VincularPecaFornecedor(const aFornecedorId, aPecaId: Integer);
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
      raise Exception.Create('Erro ao vincular pe�a ao fornecedor: ' + E.Message);
  end;
end;

function TFornecedorRepository.ListarPecasVinculadas(const aFornecedorId: Integer): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT p.id, p.nome, p.descricao, p.codigo_interno, pf.fornecedor_id');
    FQuery.SQL.Add('FROM pecas p');
    FQuery.SQL.Add('INNER JOIN peca_fornecedor pf ON p.id = pf.peca_id');
    FQuery.SQL.Add('WHERE pf.fornecedor_id = :id');
    FQuery.SQL.Add('ORDER BY p.nome');
    FQuery.ParamByName('id').AsInteger := aFornecedorId;
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar pe�as vinculadas: ' + E.Message);
  end;
end;


procedure TFornecedorRepository.InserirFornecedor(aFornecedor: TFornecedor);
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

function TFornecedorRepository.ExisteCNPJ(aFornecedor: TFornecedor): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM fornecedores WHERE cnpj = :cnpj');
  FQuery.ParamByName('cnpj').AsString := aFornecedor.getCNPJ;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TFornecedorRepository.EditarFornecedor(aFornecedor: TFornecedor): Boolean;
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
      raise Exception.Create('Erro ao listar Fornecedores para restaura��o: ' + E.Message);
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

procedure TFornecedorRepository.DesvincularPecaFornecedor(const aFornecedorId, aPecaId: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('DELETE FROM peca_fornecedor');
    FQuery.SQL.Add('WHERE fornecedor_id = :fornecedor_id AND peca_id = :peca_id');
    FQuery.ParamByName('fornecedor_id').AsInteger := aFornecedorId;
    FQuery.ParamByName('peca_id').AsInteger := aPecaId;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao desvincular pe�a do fornecedor: ' + E.Message);
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


function TFornecedorRepository.InserirPedido(aIdPeca: Integer; aValorTotal: Currency): Boolean;
begin
  Result := False;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO pedidos (id_peca, valor_total, data_pedido)');
  FQuery.SQL.Add('VALUES (:id_peca, :valor_total, :data_pedido)');
  FQuery.ParamByName('id_peca').AsInteger := aIdPeca;
  FQuery.ParamByName('valor_total').AsCurrency := aValorTotal;
  FQuery.ParamByName('data_pedido').AsDateTime := Now;
  try
    FQuery.ExecSQL;
    Result := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir pedido: ' + E.Message);
  end;
end;




function TFornecedorRepository.CarregarPecas: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM pecas WHERE ativo = TRUE ORDER BY nome');
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
    FQuery.SQL.Add('SELECT preco_compra FROM pecas WHERE id = :id_peca AND ativo = TRUE');
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

