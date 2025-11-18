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
    QueryPendentes: TFDQuery;
    QueryPendenciasConcluidas: TFDQuery;
    QueryPendenciasPendentes: TFDQuery;

  public
    function GerarRelatorioValorTotalEntradas(aDataIncio, aDataFinal: TDate)
      : TDataSet;
    function GerarRelatorioReceitasCanceladas(aDataIncio, aDataFinal: TDate)
      : TDataSet;
    function GerarRelatorioReceitasPendentes(aDataIncio, aDataFinal: TDate)
      : TDataSet;
    function GerarRelatorioPendenciasConcluidas(aDataIncio, aDataFinal: TDate)
      : TDataSet;
    function GerarRelatorioPendenciasPendentes(aDataIncio, aDataFinal: TDate)
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

  QueryPendentes := TFDQuery.Create(nil);
  QueryPendentes.Connection := Query.Connection;

  QueryPendenciasConcluidas := TFDQuery.Create(nil);
  QueryPendenciasConcluidas.Connection := Query.Connection;

  QueryPendenciasPendentes := TFDQuery.Create(nil);
  QueryPendenciasPendentes.Connection := Query.Connection;
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
    QueryEntradas.SQL.Add('    c.id AS codigo_cliente,');
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
      ('    COUNT(CASE WHEN r.status = ''CONCLUIDA'' THEN 1 END) AS receitas_concluidas,');
    QueryEntradas.SQL.Add
      ('    COALESCE(SUM(CASE WHEN r.status != ''CONCLUIDA'' THEN r.valor_total - COALESCE(r.valor_recebido, 0) ELSE 0 END), 0) AS valor_pendente,');
    QueryEntradas.SQL.Add('    SUM(SUM(r.valor_total)) OVER () AS valor_total_geral_todas_receitas');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add
      ('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.status = ''CONCLUIDA''');
    QueryEntradas.SQL.Add('  AND r.ativo = TRUE');
    QueryEntradas.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND '
      + DataFim);
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY valor_total_receitas DESC');
    QueryEntradas.Open;
    DataModule1.frxDBDataset1.DataSet := QueryEntradas;

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
    QueryCanceladas.SQL.Add('    ) AS percentual_perda,');
    QueryCanceladas.SQL.Add('    SUM(SUM(r.valor_total)) OVER () AS valor_total_geral');
  QueryCanceladas.SQL.Add('FROM receitas r');
  QueryCanceladas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
  QueryCanceladas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
  QueryCanceladas.SQL.Add('WHERE r.status = ''CANCELADA''');
  QueryCanceladas.SQL.Add('  AND r.ativo = FALSE');
  QueryCanceladas.SQL.Add('  AND os.ativo = TRUE');
  QueryCanceladas.SQL.Add('  AND c.ativo = TRUE');
  QueryCanceladas.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND ' + DataFim);
  QueryCanceladas.SQL.Add('GROUP BY c.id, c.nome');
  QueryCanceladas.SQL.Add('ORDER BY total_cancelado DESC;');

  QueryCanceladas.Open;
  DataModule1.frxDBDataset2.DataSet := QueryCanceladas;

  Result := QueryCanceladas;
  DataModule1.frxReport2.ShowReport();

except
  on E: Exception do
    raise Exception.Create('Erro ao gerar relatório de cancelamentos: ' + E.Message);
end;
end;

function TRelatorioRepository.GerarRelatorioReceitasPendentes(aDataIncio, aDataFinal: TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
try
  DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
  DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

  QueryPendentes.Close;
  QueryPendentes.SQL.Clear;
  QueryPendentes.SQL.Add('SELECT ');
  QueryPendentes.SQL.Add('    c.id AS codigo_cliente,');
  QueryPendentes.SQL.Add('    c.nome AS cliente,');
  QueryPendentes.SQL.Add('    COUNT(*) AS quantidade_pendentes,');
  QueryPendentes.SQL.Add('    COALESCE(SUM(r.valor_total), 0) AS valor_total_pendente,');
  QueryPendentes.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS valor_recebido_pendente,');
  QueryPendentes.SQL.Add('    COALESCE(SUM(r.valor_total), 0) - COALESCE(SUM(r.valor_recebido), 0) AS valor_a_receber,');
  QueryPendentes.SQL.Add('    ROUND(');
  QueryPendentes.SQL.Add('        CASE');
  QueryPendentes.SQL.Add('            WHEN SUM(r.valor_total) > 0');
  QueryPendentes.SQL.Add('            THEN ((SUM(r.valor_total) - COALESCE(SUM(r.valor_recebido), 0)) * 100.0 / SUM(r.valor_total))');
  QueryPendentes.SQL.Add('            ELSE 0');
  QueryPendentes.SQL.Add('        END, 2');
  QueryPendentes.SQL.Add('    ) AS percentual_pendente,');
  QueryPendentes.SQL.Add('    ROUND(');
  QueryPendentes.SQL.Add('        CASE');
  QueryPendentes.SQL.Add('            WHEN COUNT(*) > 0');
  QueryPendentes.SQL.Add('            THEN AVG(r.valor_total)');
  QueryPendentes.SQL.Add('            ELSE 0');
  QueryPendentes.SQL.Add('        END, 2');
  QueryPendentes.SQL.Add('    ) AS valor_medio_pendente,');
  QueryPendentes.SQL.Add('    SUM(SUM(r.valor_total)) OVER () AS valor_total_geral');
  QueryPendentes.SQL.Add('FROM receitas r');
  QueryPendentes.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
  QueryPendentes.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
  QueryPendentes.SQL.Add('WHERE r.status = ''PENDENTE''');
  QueryPendentes.SQL.Add('  AND r.ativo = TRUE');
  QueryPendentes.SQL.Add('  AND os.ativo = TRUE');
  QueryPendentes.SQL.Add('  AND c.ativo = TRUE');
  QueryPendentes.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND ' + DataFim);
  QueryPendentes.SQL.Add('GROUP BY c.id, c.nome');
  QueryPendentes.SQL.Add('ORDER BY c.nome');

  QueryPendentes.Open;
  DataModule1.frxDBDataset3.DataSet := QueryPendentes;

  Result := QueryPendentes;
  DataModule1.frxReport3.ShowReport();

except
  on E: Exception do
    raise Exception.Create('Erro ao gerar relatório de receitas pendentes: ' + E.Message);
end;
end;

function TRelatorioRepository.GerarRelatorioPendenciasConcluidas(aDataIncio, aDataFinal: TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
  try
    DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
    DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

    QueryPendenciasConcluidas.Close;
    QueryPendenciasConcluidas.SQL.Clear;
    QueryPendenciasConcluidas.SQL.Add('SELECT ');
    QueryPendenciasConcluidas.SQL.Add('    f.id AS codigo_fornecedor,');
    QueryPendenciasConcluidas.SQL.Add('    f.nome AS nome_fornecedor,');
    QueryPendenciasConcluidas.SQL.Add('    COUNT(*) AS quantidade_pendencias_concluidas,');
    QueryPendenciasConcluidas.SQL.Add('    COALESCE(SUM(p.valor_total), 0) AS valor_total_concluido,');
    QueryPendenciasConcluidas.SQL.Add('    0 AS valor_total_pago,');
    QueryPendenciasConcluidas.SQL.Add('    COALESCE(AVG(p.valor_total), 0) AS ticket_medio_concluido,');
    QueryPendenciasConcluidas.SQL.Add('    MIN(p.data_criacao) AS primeira_pendencia,');
    QueryPendenciasConcluidas.SQL.Add('    0 AS ultima_conclusao,');
    QueryPendenciasConcluidas.SQL.Add('    0 AS menor_prazo,');
    QueryPendenciasConcluidas.SQL.Add('    0 AS maior_prazo,');
    QueryPendenciasConcluidas.SQL.Add('    0 AS tempo_medio_conclusao_dias,');
    QueryPendenciasConcluidas.SQL.Add('    SUM(SUM(p.valor_total)) OVER () AS valor_total_geral');
    QueryPendenciasConcluidas.SQL.Add('FROM pendencias p');
    QueryPendenciasConcluidas.SQL.Add('INNER JOIN fornecedores f ON p.id_fornecedor = f.id');
    QueryPendenciasConcluidas.SQL.Add('WHERE p.status = ''CONCLUIDA''');
    QueryPendenciasConcluidas.SQL.Add('  AND p.ativo = TRUE');
    QueryPendenciasConcluidas.SQL.Add('  AND f.ativo = TRUE');
    QueryPendenciasConcluidas.SQL.Add('  AND p.data_criacao BETWEEN ' + DataIni + ' AND ' + DataFim);
    QueryPendenciasConcluidas.SQL.Add('GROUP BY f.id, f.nome');
    QueryPendenciasConcluidas.SQL.Add('ORDER BY valor_total_concluido DESC');
    QueryPendenciasConcluidas.Open;
    DataModule1.frxDBDataset4.DataSet := QueryPendenciasConcluidas;
    DataModule1.frxReport4.ShowReport();

    Result := QueryPendenciasConcluidas;
  except
    on E: Exception do
      raise Exception.Create('Erro ao gerar relatório de pendências concluídas: ' + E.Message);
  end;
end;

function TRelatorioRepository.GerarRelatorioPendenciasPendentes(aDataIncio, aDataFinal: TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
  try
    DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
    DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

    QueryPendenciasPendentes.Close;
    QueryPendenciasPendentes.SQL.Clear;
    QueryPendenciasPendentes.SQL.Add('SELECT ');
    QueryPendenciasPendentes.SQL.Add('    f.id AS codigo_fornecedor,');
    QueryPendenciasPendentes.SQL.Add('    f.nome AS nome_fornecedor,');
    QueryPendenciasPendentes.SQL.Add('    COUNT(*) AS quantidade_pendentes,');
    QueryPendenciasPendentes.SQL.Add('    COALESCE(SUM(p.valor_total), 0) AS valor_total_pendente,');
    QueryPendenciasPendentes.SQL.Add('    0 AS valor_total_pago_pendente,');
    QueryPendenciasPendentes.SQL.Add('    COALESCE(SUM(p.valor_total), 0) AS valor_a_pagar,');
    QueryPendenciasPendentes.SQL.Add('    COALESCE(AVG(p.valor_total), 0) AS valor_medio_pendente,');
    QueryPendenciasPendentes.SQL.Add('    MIN(p.data_criacao) AS primeira_pendencia,');
    QueryPendenciasPendentes.SQL.Add('    0 AS prazo_mais_tarde,');
    QueryPendenciasPendentes.SQL.Add('    0 AS prazo_mais_cedo,');
    QueryPendenciasPendentes.SQL.Add('    COUNT(CASE WHEN p.data_vencimento < CURRENT_DATE THEN 1 END) AS quantidade_vencidas,');
    QueryPendenciasPendentes.SQL.Add('    COALESCE(SUM(CASE WHEN p.data_vencimento < CURRENT_DATE THEN p.valor_total ELSE 0 END), 0) AS valor_vencido,');
    QueryPendenciasPendentes.SQL.Add('    COUNT(CASE WHEN p.data_vencimento >= CURRENT_DATE THEN 1 END) AS quantidade_a_vencer,');
    QueryPendenciasPendentes.SQL.Add('    COALESCE(SUM(CASE WHEN p.data_vencimento >= CURRENT_DATE THEN p.valor_total ELSE 0 END), 0) AS valor_a_vencer,');
    QueryPendenciasPendentes.SQL.Add('    ROUND(');
    QueryPendenciasPendentes.SQL.Add('        CASE');
    QueryPendenciasPendentes.SQL.Add('            WHEN COUNT(*) > 0');
    QueryPendenciasPendentes.SQL.Add('            THEN (COUNT(CASE WHEN p.data_vencimento < CURRENT_DATE THEN 1 END) * 100.0 / COUNT(*))');
    QueryPendenciasPendentes.SQL.Add('            ELSE 0');
    QueryPendenciasPendentes.SQL.Add('        END, 2');
    QueryPendenciasPendentes.SQL.Add('    ) AS percentual_vencidas,');
    QueryPendenciasPendentes.SQL.Add('    0 AS dias_medios_atraso,');
    QueryPendenciasPendentes.SQL.Add('    SUM(SUM(p.valor_total)) OVER () AS valor_total_geral');
    QueryPendenciasPendentes.SQL.Add('FROM pendencias p');
    QueryPendenciasPendentes.SQL.Add('INNER JOIN fornecedores f ON p.id_fornecedor = f.id');
    QueryPendenciasPendentes.SQL.Add('WHERE p.status = ''PENDENTE''');
    QueryPendenciasPendentes.SQL.Add('  AND p.ativo = TRUE');
    QueryPendenciasPendentes.SQL.Add('  AND f.ativo = TRUE');
    QueryPendenciasPendentes.SQL.Add('  AND p.data_criacao BETWEEN ' + DataIni + ' AND ' + DataFim);
    QueryPendenciasPendentes.SQL.Add('GROUP BY f.id, f.nome');
    QueryPendenciasPendentes.SQL.Add('ORDER BY valor_total_pendente DESC');
    QueryPendenciasPendentes.Open;
    DataModule1.frxDBDataset5.DataSet := QueryPendenciasPendentes;
    DataModule1.frxReport5.ShowReport();

    Result := QueryPendenciasPendentes;
  except
    on E: Exception do
      raise Exception.Create('Erro ao gerar relatório de pendências pendentes: ' + E.Message);
  end;
end;

end.
