unit RelatoriosService;

interface

uses
  RelatoriosRepository, System.Classes, Data.DB, System.SysUtils,uDMConexao;
   type TRelatorioService = class
     RelatorioRepository : TRelatorioRepository;
     procedure GerarRelatorioEntrada;
     constructor Create;
   end;
implementation

{ TRelatorioService }

constructor TRelatorioService.Create;
begin
  RelatorioRepository := TRelatorioRepository.create(DataModule1.FDQueryEntradas)
end;

procedure TRelatorioService.GerarRelatorioEntrada;
begin
  RelatorioRepository.GerarRelatorioEntrada;
end;

end.
