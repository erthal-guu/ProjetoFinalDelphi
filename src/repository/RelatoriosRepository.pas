unit RelatoriosRepository;

interface

uses
  uDMconexao, FireDAC.Comp.Client, System.SysUtils, uReceita, Data.DB,
  Generics.Collections, System.Classes, VCL.Dialogs;

type
  TRelatorioRepository = class
  private
    QueryEntradas: TFDQuery;
    QueryCanceladas: TFDQuery;

  public
    function GerarRelatorioValorTotalEntradas(aDataIncio, aDataFinal: TDate)
      : TDataSet;
    function GerarRelatorioReceitasCanceladas(aDataIncio, aDataFinal: TDate)
      : TDataSet;

    constructor create(Query: TFDQuery);
  end;

implementation

{ TRelatorioRepository }

constructor TRelatorioRepository.create(Query: TFDQuery);
begin
  QueryEntradas := TFDQuery.Create(nil);
  QueryEntradas.Connection := Query.Connection;

  QueryCanceladas := TFDQuery.Create(nil);
  QueryCanceladas.Connection := Query.Connection;
end;

function TRelatorioRepository.GerarRelatorioValorTotalEntradas(aDataIncio,
  aDataFinal: TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
  try
    DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
    DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    c.nome AS nome_cliente,');
    QueryEntradas.SQL.Add
      ('    COALESCE(SUM(r.valor_total), 0) AS valor_total_receitas,');
    QueryEntradas.SQL.Add
      ('    COALESCE(SUM(r.valor_recebido), 0) AS valor_total_recebido,');
    QueryEntradas.SQL.Add
      ('    COUNT(DISTINCT r.id_ordem_servico) AS quantidade_ordens,');
    QueryEntradas.SQL.Add
      ('    COALESCE(AVG(r.valor_total), 0) AS ticket_medio_cliente,');
    QueryEntradas.SQL.Add('    MIN(r.data_emissao) AS primeira_receita,');
    QueryEntradas.SQL.Add('    MAX(r.data_recebimento) AS ultima_receita,');
    QueryEntradas.SQL.Add
      ('    COUNT(CASE WHEN r.status = ''Recebido'' THEN 1 END) AS receitas_recebidas,');
    QueryEntradas.SQL.Add
      ('    COUNT(CASE WHEN r.status = ''Pendente'' THEN 1 END) AS receitas_pendentes,');
    QueryEntradas.SQL.Add
      ('    COUNT(CASE WHEN r.status = ''Parcial'' THEN 1 END) AS receitas_parciais,');
    QueryEntradas.SQL.Add
      ('    COALESCE(SUM(CASE WHEN r.status != ''Recebido'' THEN r.valor_total - COALESCE(r.valor_recebido, 0) ELSE 0 END), 0) AS valor_pendente');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add
      ('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND '
      + DataFim);
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY valor_total_receitas DESC');
    QueryEntradas.Open;

    Result := QueryEntradas;
    DataModule1.frxReport1.ShowReport();
  except
    on E: Exception do
      raise Exception.create('Erro ao gerar relatório: ' + E.Message);
  end;
end;

function TRelatorioRepository.GerarRelatorioReceitasCanceladas(aDataIncio,
  aDataFinal: TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
try
  DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
  DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

  QueryCanceladas.Close;
  QueryCanceladas.SQL.Clear;
  QueryCanceladas.SQL.Add('SELECT ');
  QueryCanceladas.SQL.Add('    c.nome AS cliente,');
  QueryCanceladas.SQL.Add('    COUNT(*) AS quantidade_canceladas,');
  QueryCanceladas.SQL.Add('    COALESCE(SUM(r.valor_total), 0) AS total_cancelado,');
  QueryCanceladas.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS total_recebido,');
  QueryCanceladas.SQL.Add('    COALESCE(SUM(r.valor_total - COALESCE(r.valor_recebido, 0)), 0) AS total_perdido,');
  QueryCanceladas.SQL.Add('    ROUND(');
  QueryCanceladas.SQL.Add('        CASE');
  QueryCanceladas.SQL.Add('            WHEN SUM(r.valor_total) > 0');
  QueryCanceladas.SQL.Add('            THEN (SUM(r.valor_recebido) * 100.0 / SUM(r.valor_total))');
  QueryCanceladas.SQL.Add('            ELSE 0');
  QueryCanceladas.SQL.Add('        END, 2');
  QueryCanceladas.SQL.Add('    ) AS percentual_recuperado,');
  QueryCanceladas.SQL.Add('    ROUND(');
  QueryCanceladas.SQL.Add('        CASE');
  QueryCanceladas.SQL.Add('            WHEN SUM(r.valor_total) > 0');
  QueryCanceladas.SQL.Add('            THEN ((SUM(r.valor_total - COALESCE(r.valor_recebido, 0))) * 100.0 / SUM(r.valor_total))');
  QueryCanceladas.SQL.Add('            ELSE 0');
  QueryCanceladas.SQL.Add('        END, 2');
  QueryCanceladas.SQL.Add('    ) AS percentual_perda');
  QueryCanceladas.SQL.Add('FROM receitas r');
  QueryCanceladas.SQL.Add('INNER JOIN clientes c ON r.id_cliente = c.id');
  QueryCanceladas.SQL.Add('WHERE r.status = ''Cancelada''');
  QueryCanceladas.SQL.Add('  AND r.ativo = TRUE');
  QueryCanceladas.SQL.Add('  AND c.ativo = TRUE');
  QueryCanceladas.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND ' + DataFim);
  QueryCanceladas.SQL.Add('GROUP BY c.id, c.nome');
  QueryCanceladas.SQL.Add('ORDER BY total_cancelado DESC;');

  QueryCanceladas.Open;
  Result := QueryCanceladas;
  DataModule1.frxReport2.ShowReport();

except
  on E: Exception do
    raise Exception.Create('Erro ao gerar relatório de cancelamentos: ' + E.Message);
end;
end;

end.
