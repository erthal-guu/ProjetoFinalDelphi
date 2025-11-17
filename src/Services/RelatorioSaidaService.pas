unit RelatorioSaidaService;

interface
uses
  RelatorioSaidaRepository, uDMConexao, FireDAC.Comp.Client, System.SysUtils,
   Graphics,System.Classes,Data.DB;

type
  TRelatorioSaidaService = class
  private
    Repository: TRelatorioSaidaRepository;
  public
    constructor Create(Query: TFDQuery);
    destructor Destroy; override;
    function GetTotalSaidas: Double;
    function GetQuantidadeSaidas: Integer;
    function GetTicketMedio: Double;
  end;
implementation

{ TRelatorioSaidaService }

constructor TRelatorioSaidaService.Create(Query: TFDQuery);
begin
  inherited Create;
  Repository := TRelatorioSaidaRepository.Create(Query);
end;

destructor TRelatorioSaidaService.Destroy;
begin
  Repository.Free;
  inherited Destroy;
end;

function TRelatorioSaidaService.GetQuantidadeSaidas: Integer;
begin
    Result := Repository.GetQuantidadeSaidas;
end;

function TRelatorioSaidaService.GetTicketMedio: Double;
begin
    Result := Repository.GetTicketMedio;
end;

function TRelatorioSaidaService.GetTotalSaidas: Double;
begin
  Result := Repository.GetTotalSaidas;
end;

end.
