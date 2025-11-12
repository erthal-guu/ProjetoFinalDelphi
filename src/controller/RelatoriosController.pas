unit RelatoriosController;

interface
  uses
    RelatoriosService,System.Classes, Data.DB, System.SysUtils;
    type TRelatorioController = class
     RelatorioService : TRelatorioService;
     procedure GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
     constructor create ;
    end;
implementation

{ RelatorioController }

constructor TRelatorioController.create;
begin
  RelatorioService := TRelatorioService.Create;
end;

procedure TRelatorioController.GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
begin
  RelatorioService.GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal);
end;

end.
