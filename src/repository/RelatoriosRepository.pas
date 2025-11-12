unit RelatoriosRepository;

interface

uses
  uDMconexao, FireDAC.Comp.Client, System.SysUtils, uReceita, Data.DB,
  Generics.Collections, System.Classes,VCL.Dialogs;


type
  TRelatorioRepository = class
  private
    QueryEntradas: TFDQuery;

  public
    function GerarRelatorioValorTotalEntradas(aDataIncio, aDataFinal : TDate): TDataSet;

    constructor create(Query: TFDQuery);
  end;

implementation

{ TRelatorioRepository }

constructor TRelatorioRepository.create(Query: TFDQuery);
begin
  QueryEntradas := Query;
end;
function TRelatorioRepository.GerarRelatorioValorTotalEntradas(aDataIncio, aDataFinal : TDate): TDataSet;
var
  DataIni, DataFim: string;
begin
  try
    // Formata as datas
    DataIni := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataIncio));
    DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', aDataFinal));

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
    QueryEntradas.SQL.Add('  AND r.data_emissao BETWEEN ' + DataIni + ' AND ' + DataFim);
    QueryEntradas.SQL.Add('GROUP BY c.id, c.nome');
    QueryEntradas.SQL.Add('ORDER BY valor_total_receitas DESC');
    QueryEntradas.Open;

    Result := QueryEntradas;
    DataModule1.frxReport1.ShowReport();
  except
    on E: Exception do
      raise Exception.Create('Erro ao gerar relatório: ' + E.Message);
  end;
end;

end.