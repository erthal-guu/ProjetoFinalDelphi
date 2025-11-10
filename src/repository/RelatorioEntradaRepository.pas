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
  FQuery := Query;
end;

end.
