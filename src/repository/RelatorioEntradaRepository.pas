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
    procedure CarregarGraficoMensal;
    function GetTotalEntradas: Double;
    function GetQuantidadeEntradas:Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioEntradaRepository }

procedure TRelatorioEntradaRepository.CarregarGraficoMensal;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM usuarios');
  FQuery.ExecSQL;
end;

constructor TRelatorioEntradaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  if Assigned(Query) then
    FQuery := Query
  else
  begin
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := DataModule1.FDConnection1;
  end;
end;

  function TRelatorioEntradaRepository.GetQuantidadeEntradas: Integer;
begin
  try
    if not Assigned(FQuery) then
      raise Exception.Create('Query não foi inicializada no Repository');

    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COUNT(*) as total FROM Receitas WHERE status = ''Recebido''');
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
    if not Assigned(FQuery) then
      raise Exception.Create('Query não foi inicializada no Repository');

    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT COALESCE(AVG(valor_total), 0) as media FROM Receitas');
    FQuery.Open;
    Result := FQuery.FieldByName('media').AsFloat;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao calcular ticket médio da tabela Receitas: ' + E.Message);
    end;
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
