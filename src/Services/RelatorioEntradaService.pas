unit RelatorioEntradaService;

interface

uses
  RelatorioEntradaRepository, uDMConexao, FireDAC.Comp.Client, System.SysUtils,
   Graphics,System.Classes,Data.DB;

type
  TRelatorioEntradaService = class
  private
    Repository: TRelatorioEntradaRepository;
  public
    constructor Create(Query: TFDQuery);
    destructor Destroy; override;
    function GetTotalEntradas: Double;
    function GetQuantidadeEntradas: Integer;
    function GetTicketMedio: Double;
  end;

implementation

{ TRelatorioEntradaService }

constructor TRelatorioEntradaService.Create(Query: TFDQuery);
begin
  inherited Create;
  Repository := TRelatorioEntradaRepository.Create(Query);
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
