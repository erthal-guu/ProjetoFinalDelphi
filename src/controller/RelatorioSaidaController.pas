unit RelatorioSaidaController;

interface

uses
  RelatorioSaidaService, uDMConexao, FireDAC.Comp.Client,Data.DB;
  type
  TRelatorioSaidaController = class
  private
    Service: TRelatorioSaidaService;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTotalSaidas: Double;
    function GetQuantidadeSaidas: Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioSaidaController }

constructor TRelatorioSaidaController.Create;
begin
  inherited Create;
    Service := TRelatorioSaidaService.Create(DataModule1.FDQuery)
end;

destructor TRelatorioSaidaController.Destroy;
begin
  Service.Free;
  inherited Destroy;
end;

function TRelatorioSaidaController.GetQuantidadeSaidas: Integer;
begin
    Result := Service.GetQuantidadeSaidas;
end;

function TRelatorioSaidaController.GetTicketMedio: Double;
begin
    Result := Service.GetTicketMedio;
end;

function TRelatorioSaidaController.GetTotalSaidas: Double;
begin
  Result := Service.GetTotalSaidas;
end;

end.
