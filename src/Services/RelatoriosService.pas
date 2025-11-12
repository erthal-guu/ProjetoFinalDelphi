unit RelatoriosService;

interface

uses
  RelatoriosRepository, System.Classes, Data.DB, System.SysUtils,uDMConexao;
   type TRelatorioService = class
     RelatorioRepository : TRelatorioRepository;
     procedure GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
     procedure GerarRelatorioReceitasCanceladas(aDataIncio,aDataFinal:TDate);
     constructor Create;
   end;
implementation

{ TRelatorioService }

constructor TRelatorioService.Create;
begin
  RelatorioRepository := TRelatorioRepository.create(DataModule1.FDQueryValorTotal)
end;

procedure TRelatorioService.GerarRelatorioReceitasCanceladas(aDataIncio,
  aDataFinal: TDate);
begin
  RelatorioRepository.GerarRelatorioReceitasCanceladas(aDataIncio,aDataFinal);
end;

procedure TRelatorioService.GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
begin
  RelatorioRepository.GerarRelatorioValorTotalEntradas(aDataIncio,aDataFinal);
end;

end.
