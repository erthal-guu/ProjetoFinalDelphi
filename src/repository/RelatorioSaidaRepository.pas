unit RelatorioSaidaRepository;

interface
uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uVeiculo, Data.DB,
  System.Classes;

type
  TRelatorioSaidaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    function GetTotalSaidas: Double;
    function GetQuantidadeSaidas:Integer;
    function GetTicketMedio: Double;
  end;
implementation

{ TRelatorioSaidaRepository }

constructor TRelatorioSaidaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
    FQuery := Query
end;

function TRelatorioSaidaRepository.GetQuantidadeSaidas: Integer;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COUNT(*) as total FROM pendencias WHERE status = ''CONCLUIDA''');
    FQuery.Open;
    Result := FQuery.FieldByName('total').AsInteger;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao contar quantidade de saídas da tabela Despesas: ' + E.Message);
    end;
  end;
end;

function TRelatorioSaidaRepository.GetTicketMedio: Double;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COALESCE(AVG(valor_total), 0) AS media');
    FQuery.SQL.Add('FROM pendencias');
    FQuery.SQL.Add('WHERE ativo = TRUE');
    FQuery.SQL.Add('  AND status IN (''CONCLUIDA'')');
    FQuery.Open;

    Result := FQuery.FieldByName('media').AsFloat;
  except
    on E: Exception do
      raise Exception.Create('Erro ao calcular ticket médio de saídas: ' + E.Message);
    end;
end;

function TRelatorioSaidaRepository.GetTotalSaidas: Double;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COALESCE(SUM(valor_total), 0) as total FROM pendencias WHERE status =''CONCLUIDA''');
    FQuery.Open;
    Result := FQuery.FieldByName('total').AsFloat;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao calcular total de saídas da tabela Despesas: ' + E.Message);
    end;
  end;
end;

end.
