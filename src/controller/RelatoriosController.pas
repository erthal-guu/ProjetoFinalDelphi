unit RelatoriosController;

interface
  uses
    RelatoriosService,System.Classes, Data.DB, System.SysUtils;
    type TRelatorioController = class
     RelatorioService : TRelatorioService;
     procedure GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
     procedure GerarRelatorioReceitasCanceladas(aDataIncio,aDataFinal:TDate);
     procedure GerarRelatorioReceitasPendentes(aDataIncio,aDataFinal:TDate);
     constructor create ;
    end;
implementation

{ RelatorioController }

constructor TRelatorioController.create;
begin
  RelatorioService := TRelatorioService.Create;
end;

procedure TRelatorioController.GerarRelatorioReceitasCanceladas(aDataIncio,
  aDataFinal: TDate);
begin
  RelatorioService.GerarRelatorioReceitasCanceladas(aDataIncio,aDataFinal);
end;

procedure TRelatorioController.GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal:TDate);
begin
  RelatorioService.GerarRelatorioValorTotalEntrada(aDataIncio,aDataFinal);
end;

procedure TRelatorioController.GerarRelatorioReceitasPendentes(aDataIncio,aDataFinal:TDate);
begin
  RelatorioService.GerarRelatorioReceitasPendentes(aDataIncio,aDataFinal);
end;

end.
