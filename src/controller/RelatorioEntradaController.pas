unit RelatorioEntradaController;

interface

uses
  RelatorioEntradaService, uDMConexao, FireDAC.Comp.Client, VCLTee.Series;

type
  TRelatorioEntradaController = class
  private
    Service: TRelatorioEntradaService;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTotalEntradas: Double;
    function GetQuantidadeEntradas: Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioEntradaController }

constructor TRelatorioEntradaController.Create;
begin
  inherited Create;
  Service := TRelatorioEntradaService.Create(nil);
end;

destructor TRelatorioEntradaController.Destroy;
begin
  Service.Free;
  inherited Destroy;
end;

function TRelatorioEntradaController.GetQuantidadeEntradas: Integer;
begin
    Result := Service.GetQuantidadeEntradas;
end;

function TRelatorioEntradaController.GetTicketMedio: Double;
begin
    Result := Service.GetTicketMedio;
end;

function TRelatorioEntradaController.GetTotalEntradas: Double;
begin
  Result := Service.GetTotalEntradas;
end;



end.
