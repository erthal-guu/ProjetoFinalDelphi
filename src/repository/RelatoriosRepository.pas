unit RelatoriosRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uReceita, Data.DB,
  Generics.Collections, System.Classes, Vcl.Tee.Chart;

type
  TRelatorioRepository = class
  private
    QueryEntradas: TFDQuery;

    // Métodos privados para gráficos
    procedure CarregarGraficoFormasPagamento(Chart: TChart);
    procedure CarregarGraficoEvolucaoMensal(Chart: TChart);
    procedure CarregarGraficoTopClientes(Chart: TChart);

  public
    procedure GerarRelatorioEntrada;

    // Método principal para carregar todos os gráficos
    procedure CarregarGraficos(ChartFormasPagamento, ChartEvolucao, ChartTopClientes: TChart);

    constructor create(Query: TFDQuery);
  end;

implementation

uses Vcl.Tee.Series, Vcl.Tee.TeEngine;

{ TRelatorioRepository }

constructor TRelatorioRepository.create(Query: TFDQuery);
begin
  QueryEntradas := Query;
end;

procedure TRelatorioRepository.GerarRelatorioEntrada;
begin
  try
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  r.id,');
    QueryEntradas.SQL.Add('  c.nome AS cliente,');
    QueryEntradas.SQL.Add('  r.valor_recebido,');
    QueryEntradas.SQL.Add('  r.forma_pagamento,');
    QueryEntradas.SQL.Add('  r.data_recebimento');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('  AND r.data_recebimento IS NOT NULL');
    QueryEntradas.SQL.Add('ORDER BY r.data_recebimento DESC');
    QueryEntradas.Open;

    DataModule1.frxDBDataset1.DataSet := QueryEntradas;
    DataModule1.frxDBDataset1.UserName := 'dsReceitas';
    DataModule1.frxReport1.DataSet := DataModule1.frxDBDataset1;

    if FileExists('relatorio_receitas.fr3') then
      DataModule1.frxReport1.LoadFromFile('relatorio_receitas.fr3')
    else
      DataModule1.frxReport1.DesignReport;

    DataModule1.frxReport1.ShowReport();

  except
    on E: Exception do
      ShowMessage('Erro ao gerar relatório: ' + E.Message);
  end;
end;

procedure TRelatorioRepository.CarregarGraficos(ChartFormasPagamento, ChartEvolucao, ChartTopClientes: TChart);
begin
  try
    CarregarGraficoFormasPagamento(ChartFormasPagamento);
    CarregarGraficoEvolucaoMensal(ChartEvolucao);
    CarregarGraficoTopClientes(ChartTopClientes);
  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar gráficos: ' + E.Message);
  end;
end;

procedure TRelatorioRepository.CarregarGraficoFormasPagamento(Chart: TChart);
var
  PieSeries: TPieSeries;
begin
  try
    Chart.SeriesList.Clear;

    // Cria gráfico de pizza
    PieSeries := TPieSeries.Create(Chart);
    PieSeries.ParentChart := Chart;
    PieSeries.Title := 'Formas de Pagamento';
    PieSeries.Marks.Visible := True;
    PieSeries.Marks.Style := smsPercent;

    // Busca dados no banco
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  forma_pagamento,');
    QueryEntradas.SQL.Add('  SUM(valor_recebido) as total');
    QueryEntradas.SQL.Add('FROM receitas');
    QueryEntradas.SQL.Add('WHERE ativo = TRUE AND valor_recebido > 0');
    QueryEntradas.SQL.Add('GROUP BY forma_pagamento');
    QueryEntradas.SQL.Add('ORDER BY total DESC');
    QueryEntradas.Open;

    // Carrega dados no gráfico
    QueryEntradas.First;
    while not QueryEntradas.Eof do
    begin
      PieSeries.AddPie(
        QueryEntradas.FieldByName('total').AsCurrency,
        QueryEntradas.FieldByName('forma_pagamento').AsString,
        clTeeColor
      );
      QueryEntradas.Next;
    end;

    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('Distribuição por Forma de Pagamento');
    Chart.Legend.Visible := True;
    Chart.View3D := False;

  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar gráfico de formas pagamento: ' + E.Message);
  end;
end;

procedure TRelatorioRepository.CarregarGraficoEvolucaoMensal(Chart: TChart);
var
  LineSeries: TLineSeries;
begin
  try
    Chart.SeriesList.Clear;

    // Cria gráfico de linhas
    LineSeries := TLineSeries.Create(Chart);
    LineSeries.ParentChart := Chart;
    LineSeries.Title := 'Evolução Mensal';
    LineSeries.Marks.Visible := True;
    LineSeries.LinePen.Width := 3;

    // Busca dados de evolução
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  TO_CHAR(data_recebimento, ''MM/YYYY'') as mes,');
    QueryEntradas.SQL.Add('  SUM(valor_recebido) as total');
    QueryEntradas.SQL.Add('FROM receitas');
    QueryEntradas.SQL.Add('WHERE ativo = TRUE');
    QueryEntradas.SQL.Add('  AND data_recebimento >= CURRENT_DATE - INTERVAL ''6 months''');
    QueryEntradas.SQL.Add('GROUP BY TO_CHAR(data_recebimento, ''MM/YYYY'')');
    QueryEntradas.SQL.Add('ORDER BY mes');
    QueryEntradas.Open;

    // Carrega dados
    QueryEntradas.First;
    while not QueryEntradas.Eof do
    begin
      LineSeries.Add(
        QueryEntradas.FieldByName('total').AsCurrency,
        QueryEntradas.FieldByName('mes').AsString
      );
      QueryEntradas.Next;
    end;

    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('Evolução de Receitas (6 meses)');
    Chart.Legend.Visible := True;
    Chart.View3D := False;

  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar gráfico de evolução: ' + E.Message);
  end;
end;

procedure TRelatorioRepository.CarregarGraficoTopClientes(Chart: TChart);
var
  BarSeries: TBarSeries;
begin
  try
    Chart.SeriesList.Clear;

    // Cria gráfico de barras
    BarSeries := TBarSeries.Create(Chart);
    BarSeries.ParentChart := Chart;
    BarSeries.Title := 'Top Clientes';
    BarSeries.Marks.Visible := True;
    BarSeries.BarStyle := bsRectGradient;

    // Busca top clientes
    QueryEntradas.Close;
    QueryEntradas.SQL.Clear;
    QueryEntradas.SQL.Add('SELECT ');
    QueryEntradas.SQL.Add('  c.nome AS cliente,');
    QueryEntradas.SQL.Add('  SUM(r.valor_recebido) as total_gasto');
    QueryEntradas.SQL.Add('FROM receitas r');
    QueryEntradas.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    QueryEntradas.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    QueryEntradas.SQL.Add('WHERE r.ativo = TRUE');
    QueryEntradas.SQL.Add('  AND r.data_recebimento >= DATE_TRUNC(''month'', CURRENT_DATE)');
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY total_gasto DESC');
    QueryEntradas.SQL.Add('LIMIT 10');
    QueryEntradas.Open;

    // Carrega dados
    QueryEntradas.First;
    while not QueryEntradas.Eof do
    begin
      BarSeries.Add(
        QueryEntradas.FieldByName('total_gasto').AsCurrency,
        Copy(QueryEntradas.FieldByName('cliente').AsString, 1, 15),
        clTeeColor
      );
      QueryEntradas.Next;
    end;

    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('Top 10 Clientes do Mês');
    Chart.Legend.Visible := True;
    Chart.View3D := False;

  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar gráfico de top clientes: ' + E.Message);
  end;
end;

end.
