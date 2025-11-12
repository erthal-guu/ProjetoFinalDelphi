unit RelatoriosController;

interface
  uses
    RelatoriosService,System.Classes, Data.DB, System.SysUtils;
    type TRelatorioController = class
     RelatorioService : TRelatorioService;
     procedure GerarRelatorioEntrda(aDataIncio,aDataFinal:TDate);
     constructor create ;
    end;
implementation

{ RelatorioController }

constructor TRelatorioController.create;
begin
  RelatorioService := TRelatorioService.Create;
end;

procedure TRelatorioController.GerarRelatorioEntrda(aDataIncio,aDataFinal:TDate);
begin
  RelatorioService.GerarRelatorioEntrada(aDataIncio,aDataFinal);
end;

end.
