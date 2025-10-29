unit ReceitaRepository;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Data.DB, System.Classes,
  System.Generics.Collections, uReceita;

type
  TReceitaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirReceita(Receita: TReceita);
    procedure EditarReceita(Receita: TReceita);
    procedure ReceberReceita(aID: Integer; aValorRecebido: Currency;
      aDataRecebimento: TDateTime; aFormaPagamento: String);
    procedure DeletarReceita(aID: Integer);
    procedure RestaurarReceita(aID: Integer);
    function ObterDetalhesReceita(aID: Integer): TReceita;
    function ObterHistoricoReceita(aID: Integer): TDataSet;
    function PesquisarReceitas(const aFiltro: String): TDataSet;
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
    function CarregarOrdensServico: TStringList;
  end;

implementation

constructor TReceitaRepository.Create(Query: TFDQuery);
begin
  FQuery := Query;
end;

procedure TReceitaRepository.InserirReceita(Receita: TReceita);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO receitas (valor_recebido, data_recebimento, valor_total, ' +
                 'forma_pagamento, status, observacao, ativo) ' +
                 'VALUES (:valor_recebido, :data_recebimento, :valor_total, ' +
                 ':forma_pagamento, :status, :observacao, :ativo)');
  FQuery.ParamByName('valor_recebido').AsCurrency := Receita.getValorRecebido;
  FQuery.ParamByName('data_recebimento').AsDateTime := Receita.getDataRecebimento;
  FQuery.ParamByName('valor_total').AsCurrency := Receita.getValorTotal;
  FQuery.ParamByName('forma_pagamento').AsString := Receita.getFormaPagamento;
  FQuery.ParamByName('status').AsString := Receita.getStatus;
  FQuery.ParamByName('observacao').AsString := Receita.getObservacao;
  FQuery.ParamByName('ativo').AsBoolean := Receita.getAtivo;
  FQuery.ExecSQL;
end;

procedure TReceitaRepository.EditarReceita(Receita: TReceita);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE receitas SET valor_recebido = :valor_recebido, ' +
                 'data_recebimento = :data_recebimento, valor_total = :valor_total, ' +
                 'forma_pagamento = :forma_pagamento, status = :status, ' +
                 'observacao = :observacao ' +
                 'WHERE id = :id');
  FQuery.ParamByName('valor_recebido').AsCurrency := Receita.getValorRecebido;
  FQuery.ParamByName('data_recebimento').AsDateTime := Receita.getDataRecebimento;
  FQuery.ParamByName('valor_total').AsCurrency := Receita.getValorTotal;
  FQuery.ParamByName('forma_pagamento').AsString := Receita.getFormaPagamento;
  FQuery.ParamByName('status').AsString := Receita.getStatus;
  FQuery.ParamByName('observacao').AsString := Receita.getObservacao;
  FQuery.ParamByName('id').AsInteger := Receita.getIdReceita;
  FQuery.ExecSQL;
end;

procedure TReceitaRepository.ReceberReceita(aID: Integer; aValorRecebido: Currency;
  aDataRecebimento: TDateTime; aFormaPagamento: String);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE receitas SET valor_recebido = :valor_recebido, ' +
                 'data_recebimento = :data_recebimento, ' +
                 'forma_pagamento = :forma_pagamento, status = ''Recebido'' ' +
                 'WHERE id = :id');
  FQuery.ParamByName('valor_recebido').AsCurrency := aValorRecebido;
  FQuery.ParamByName('data_recebimento').AsDateTime := aDataRecebimento;
  FQuery.ParamByName('forma_pagamento').AsString := aFormaPagamento;
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TReceitaRepository.DeletarReceita(aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE receitas SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TReceitaRepository.RestaurarReceita(aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE receitas SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TReceitaRepository.ObterDetalhesReceita(aID: Integer): TReceita;
var
  Receita: TReceita;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM receitas WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    Receita := TReceita.Create;
    Receita.setIdReceita(FQuery.FieldByName('id').AsInteger);
    Receita.setValorRecebido(FQuery.FieldByName('valor_recebido').AsCurrency);
    Receita.setDataRecebimento(FQuery.FieldByName('data_recebimento').AsDateTime);
    Receita.setValorTotal(FQuery.FieldByName('valor_total').AsCurrency);
    Receita.setFormaPagamento(FQuery.FieldByName('forma_pagamento').AsString);
    Receita.setStatus(FQuery.FieldByName('status').AsString);
    Receita.setObservacao(FQuery.FieldByName('observacao').AsString);
    Receita.setAtivo(FQuery.FieldByName('ativo').AsBoolean);
    Result := Receita;
  end
  else
    Result := nil;
end;

function TReceitaRepository.ObterHistoricoReceita(aID: Integer): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM receitas WHERE id = :id ORDER BY data_recebimento DESC');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.Open;
  Result := FQuery;
end;

function TReceitaRepository.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM receitas ' +
                 'WHERE (CAST(id AS TEXT) ILIKE :filtro ' +
                 'OR status ILIKE :filtro ' +
                 'OR forma_pagamento ILIKE :filtro ' +
                 'OR observacao ILIKE :filtro) ' +
                 'AND ativo = TRUE ' +
                 'ORDER BY id');
  FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
  FQuery.Open;
  Result := FQuery;
end;

function TReceitaRepository.ListarReceitas: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT r.id,');
    FQuery.SQL.Add('os.id AS "Ordem de Serviço",');
    FQuery.SQL.Add('c.nome AS "Cliente",');
    FQuery.SQL.Add('r.valor_total AS "Valor Total",');
    FQuery.SQL.Add('r.valor_recebido AS "Valor Recebido",');
    FQuery.SQL.Add('r.status AS "Status",');
    FQuery.SQL.Add('r.data_emissao AS "Data de Emissão",');
    FQuery.SQL.Add('r.data_vencimento AS "Data de Vencimento",');
    FQuery.SQL.Add('r.data_recebimento AS "Data de Recebimento",');
    FQuery.SQL.Add('r.forma_pagamento AS "Forma de Pagamento",');
    FQuery.SQL.Add('r.observacao AS "Observação",');
    FQuery.SQL.Add('r.ativo');
    FQuery.SQL.Add('FROM receitas r');
    FQuery.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    FQuery.SQL.Add('INNER JOIN clientes c ON r.id_cliente = c.id');
    FQuery.SQL.Add('WHERE r.ativo = TRUE');
    FQuery.SQL.Add('ORDER BY r.id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Receitas: ' + E.Message);
  end;
end;




function TReceitaRepository.ListarReceitasRestaurar: TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM receitas WHERE ativo = FALSE ORDER BY id');
  FQuery.Open;
  Result := FQuery;
end;

function TReceitaRepository.CarregarOrdensServico: TStringList;
var
  Lista: TStringList;
begin
  Lista := TStringList.Create;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, CONCAT(''OS :'', id, '' - Cliente: '', ' +
                   '(SELECT nome FROM clientes WHERE id = ordens_servico.id_cliente)) AS descricao ' +
                   'FROM ordens_servico WHERE ativo = TRUE ORDER BY id');
    FQuery.Open;

    while not FQuery.Eof do
    begin
      Lista.AddObject(
        FQuery.FieldByName('descricao').AsString,
        TObject(FQuery.FieldByName('id').AsInteger)
      );
      FQuery.Next;
    end;

    Result := Lista;
  except
    Lista.Free;
    raise;
  end;
end;

end.
