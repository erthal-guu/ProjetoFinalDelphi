unit RelatorioEntradaService;

interface

uses
  RelatorioEntradaRepository, uDMConexao, FireDAC.Comp.Client, System.SysUtils,
  VCLTee.Series, VCLTee.TeEngine, Graphics;

type
  TRelatorioEntradaService = class
  private
    Repository: TRelatorioEntradaRepository;
  public
    constructor Create(AQuery: TFDQuery);
    destructor Destroy; override;
    function GetTotalEntradas: Double;
    function GetQuantidadeEntradas: Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioEntradaService }

constructor TRelatorioEntradaService.Create(AQuery: TFDQuery);
begin
  inherited Create;
  Repository := TRelatorioEntradaRepository.Create(AQuery);
end;

destructor TRelatorioEntradaService.Destroy;
begin
  Repository.Free;
  inherited Destroy;
end;

function TRelatorioEntradaService.GetQuantidadeEntradas: Integer;
begin
    Result := Repository.GetQuantidadeEntradas;
end;

function TRelatorioEntradaService.GetTicketMedio: Double;
begin
    Result := Repository.GetTicketMedio;
end;

function TRelatorioEntradaService.GetTotalEntradas: Double;
begin
  Result := Repository.GetTotalEntradas;
end;

end.
