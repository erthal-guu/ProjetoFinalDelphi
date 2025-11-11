unit RelatoriosRepository;

interface

uses
  uDMconexao, FireDAC.Comp.Client, System.SysUtils, uReceita, Data.DB,
  Generics.Collections, System.Classes;


type
  TRelatorioRepository = class
  private
    QueryEntradas: TFDQuery;

  public

    // Novas funções de relatório de entradas financeiras
    function GetRelatorioCompletoEntradas: TDataSet;
    function GetRelatorioResumidoPorPeriodo(DataInicio, DataFim: TDateTime): TDataSet;
    function GetRelatorioPorFormaPagamento(DataInicio: TDateTime): TDataSet;
    function GetRelatorioPorStatus: TDataSet;
    function GetRelatorioEntradasVencidas: TDataSet;
    function GetRelatorioEntradasRecebidas(DataInicio, DataFim: TDateTime): TDataSet;
    function GetRelatorioEvolucaoMensal: TDataSet;
    function GetRelatorioTopClientes(MesReferencia: TDateTime): TDataSet;

    constructor create(Query: TFDQuery);
  end;

implementation

{ TRelatorioRepository }

constructor TRelatorioRepository.create(Query: TFDQuery);
begin
  QueryEntradas := Query;
end;


// Novas funções de relatório de entradas financeiras

function TRelatorioRepository.GetRelatorioCompletoEntradas: TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    c.id AS codigo_cliente,');
    QueryEntradas.SQL.Add('    c.nome AS nome_cliente,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_total), 0) AS valor_total_receitas,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS valor_total_recebido,');
    QueryEntradas.SQL.Add('    COUNT(DISTINCT r.id_ordem_servico) AS quantidade_ordens,');
    QueryEntradas.SQL.Add('    COALESCE(AVG(r.valor_total), 0) AS ticket_medio_cliente,');
    QueryEntradas.SQL.Add('    MIN(r.data_emissao) AS primeira_receita,');
    QueryEntradas.SQL.Add('    MAX(r.data_recebimento) AS ultima_receita,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Recebido'' THEN 1 END) AS receitas_recebidas,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Pendente'' THEN 1 END) AS receitas_pendentes,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Parcial'' THEN 1 END) AS receitas_parciais,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(CASE WHEN r.status != ''Recebido'' THEN r.valor_total - COALESCE(r.valor_recebido, 0) ELSE 0 END), 0) AS valor_pendente');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY valor_total_receitas DESC');
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório completo de entradas por cliente: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioResumidoPorPeriodo(DataInicio, DataFim: TDateTime): TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    DATE_TRUNC(''month'', r.data_recebimento) AS mes_referencia,');
    QueryEntradas.SQL.Add('    COUNT(*) AS quantidade_receitas,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_total), 0) AS valor_total_previsto,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS valor_total_recebido,');
    QueryEntradas.SQL.Add('    COALESCE(AVG(r.valor_total), 0) AS ticket_medio,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Recebido'' THEN 1 END) AS receitas_recebidas,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Pendente'' THEN 1 END) AS receitas_pendentes,');
    QueryEntradas.SQL.Add('    COUNT(CASE WHEN r.status = ''Parcial'' THEN 1 END) AS receitas_parciais');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('    AND r.data_recebimento BETWEEN :data_inicio AND :data_fim');
    QueryEntradas.SQL.Add('GROUP BY DATE_TRUNC(''month'', r.data_recebimento)');
    QueryEntradas.SQL.Add('ORDER BY mes_referencia');
    QueryEntradas.ParamByName('data_inicio').AsDateTime := DataInicio;
    QueryEntradas.ParamByName('data_fim').AsDateTime := DataFim;
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório resumido por período: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioPorFormaPagamento(DataInicio: TDateTime): TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    r.forma_pagamento,');
    QueryEntradas.SQL.Add('    COUNT(*) AS quantidade,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS valor_total,');
    QueryEntradas.SQL.Add('    COALESCE(AVG(r.valor_recebido), 0) AS valor_medio,');
    QueryEntradas.SQL.Add('    MAX(r.valor_recebido) AS maior_valor,');
    QueryEntradas.SQL.Add('    MIN(r.valor_recebido) AS menor_valor');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE ');
    QueryEntradas.SQL.Add('    AND r.status = ''Recebido''');
    QueryEntradas.SQL.Add('    AND r.data_recebimento >= :data_inicio');
    QueryEntradas.SQL.Add('GROUP BY r.forma_pagamento');
    QueryEntradas.SQL.Add('ORDER BY valor_total DESC');
    QueryEntradas.ParamByName('data_inicio').AsDateTime := DataInicio;
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório por forma de pagamento: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioPorStatus: TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    r.status,');
    QueryEntradas.SQL.Add('    COUNT(*) AS quantidade,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_total), 0) AS valor_total,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_recebido), 0) AS valor_recebido,');
    QueryEntradas.SQL.Add('    COALESCE(SUM(r.valor_total - r.valor_recebido), 0) AS valor_pendente');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('GROUP BY r.status');
    QueryEntradas.SQL.Add('ORDER BY ');
    QueryEntradas.SQL.Add('    CASE r.status ');
    QueryEntradas.SQL.Add('        WHEN ''Recebido'' THEN 1');
    QueryEntradas.SQL.Add('        WHEN ''Parcial'' THEN 2');
    QueryEntradas.SQL.Add('        WHEN ''Pendente'' THEN 3');
    QueryEntradas.SQL.Add('        ELSE 4');
    QueryEntradas.SQL.Add('    END');
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório por status: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioEntradasVencidas: TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    r.id AS codigo_receita,');
    QueryEntradas.SQL.Add('    c.nome AS nome_cliente,');
    QueryEntradas.SQL.Add('    r.valor_total AS valor_previsto,');
    QueryEntradas.SQL.Add('    r.valor_recebido AS valor_recebido,');
    QueryEntradas.SQL.Add('    (r.valor_total - COALESCE(r.valor_recebido, 0)) AS valor_pendente,');
    QueryEntradas.SQL.Add('    r.data_vencimento,');
    QueryEntradas.SQL.Add('    (CURRENT_DATE - r.data_vencimento) AS dias_atraso,');
    QueryEntradas.SQL.Add('    r.forma_pagamento');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('    AND r.data_vencimento < CURRENT_DATE');
    QueryEntradas.SQL.Add('    AND r.status != ''Recebido''');
    QueryEntradas.SQL.Add('ORDER BY r.data_vencimento ASC');
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório de entradas vencidas: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioEntradasRecebidas(DataInicio, DataFim: TDateTime): TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('    r.id AS codigo_receita,');
    QueryEntradas.SQL.Add('    c.nome AS nome_cliente,');
    QueryEntradas.SQL.Add('    r.valor_total AS valor_total,');
    QueryEntradas.SQL.Add('    r.valor_recebido AS valor_recebido,');
    QueryEntradas.SQL.Add('    r.data_emissao,');
    QueryEntradas.SQL.Add('    r.data_vencimento,');
    QueryEntradas.SQL.Add('    r.data_recebimento,');
    QueryEntradas.SQL.Add('    r.forma_pagamento,');
    QueryEntradas.SQL.Add('    r.observacao');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('    AND r.status = ''Recebido''');
    QueryEntradas.SQL.Add('    AND r.data_recebimento BETWEEN :data_inicio AND :data_fim');
    QueryEntradas.SQL.Add('ORDER BY r.data_recebimento DESC');
    QueryEntradas.ParamByName('data_inicio').AsDateTime := DataInicio;
    QueryEntradas.ParamByName('data_fim').AsDateTime := DataFim;
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório de entradas recebidas: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioEvolucaoMensal: TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  TO_CHAR(data_recebimento, ''MM/YYYY'') as mes,');
    QueryEntradas.SQL.Add('  SUM(valor_recebido) as total_recebido,');
    QueryEntradas.SQL.Add('  COUNT(*) as quantidade_receitas,');
    QueryEntradas.SQL.Add('  AVG(valor_recebido) as ticket_medio');
    QueryEntradas.SQL.Add('FROM receitas');
    QueryEntradas.SQL.Add('WHERE ativo = TRUE');
    QueryEntradas.SQL.Add('  AND data_recebimento IS NOT NULL');
    QueryEntradas.SQL.Add('  AND data_recebimento >= CURRENT_DATE - INTERVAL ''12 months''');
    QueryEntradas.SQL.Add('GROUP BY TO_CHAR(data_recebimento, ''MM/YYYY'')');
    QueryEntradas.SQL.Add('ORDER BY mes');
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório de evolução mensal: ' + E.Message);
    end;
  end;
end;

function TRelatorioRepository.GetRelatorioTopClientes(MesReferencia: TDateTime): TDataSet;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  c.id AS codigo_cliente,');
    QueryEntradas.SQL.Add('  c.nome AS nome_cliente,');
    QueryEntradas.SQL.Add('  SUM(r.valor_recebido) as total_gasto,');
    QueryEntradas.SQL.Add('  COUNT(*) AS quantidade_ordens,');
    QueryEntradas.SQL.Add('  AVG(r.valor_recebido) AS ticket_medio_cliente');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('  AND r.data_recebimento >= DATE_TRUNC(''month'', :mes_referencia)');
    QueryEntradas.SQL.Add('  AND r.data_recebimento < DATE_TRUNC(''month'', :mes_referencia) + INTERVAL ''1 month''');
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY total_gasto DESC');
    QueryEntradas.SQL.Add('LIMIT 10');
    QueryEntradas.ParamByName('mes_referencia').AsDateTime := MesReferencia;
    QueryEntradas.Open;
    Result := QueryEntradas;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao gerar relatório de top clientes: ' + E.Message);
    end;
  end;
end;

end.