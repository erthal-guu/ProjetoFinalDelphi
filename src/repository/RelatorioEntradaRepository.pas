unit RelatorioEntradaRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uVeiculo, Data.DB,
  System.Classes;

type
  TRelatorioEntradaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    function GetTotalEntradas: Double;
    function GetQuantidadeEntradas:Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioEntradaRepository }

constructor TRelatorioEntradaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
    FQuery := Query
end;

  function TRelatorioEntradaRepository.GetQuantidadeEntradas: Integer;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COUNT(*) as total FROM Receitas WHERE status = ''CONCLUIDA''');
    FQuery.Open;
    Result := FQuery.FieldByName('total').AsInteger;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao contar quantidade de entradas da tabela Receitas: ' + E.Message);
    end;
  end;
end;

function TRelatorioEntradaRepository.GetTicketMedio: Double;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COALESCE(AVG(valor_total), 0) AS media');
    FQuery.SQL.Add('FROM receitas');
    FQuery.SQL.Add('WHERE ativo = TRUE');
    FQuery.SQL.Add('  AND status IN (''CONCLUIDA'')');
    FQuery.Open;

    Result := FQuery.FieldByName('media').AsFloat;
  except
    on E: Exception do
      raise Exception.Create('Erro ao calcular ticket médio: ' + E.Message);
  end;
end;

function TRelatorioEntradaRepository.GetTotalEntradas: Double;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COALESCE(SUM(valor_total), 0) as total FROM Receitas');
    FQuery.Open;
    Result := FQuery.FieldByName('total').AsFloat;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao calcular total de entradas da tabela Receitas: ' + E.Message);
    end;
  end;
end;

end.
