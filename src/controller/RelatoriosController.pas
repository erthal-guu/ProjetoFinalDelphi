unit RelatoriosController;

interface
  uses
    RelatoriosService,System.Classes, Data.DB, System.SysUtils;
    type TRelatorioController = class
     RelatorioService : TRelatorioService;
     procedure GerarRelatorioEntrda;
     constructor create ;
    end;
implementation

{ RelatorioController }

constructor TRelatorioController.create;
begin
  RelatorioService := TRelatorioService.Create;
end;

procedure TRelatorioController.GerarRelatorioEntrda;
begin
  RelatorioService.GerarRelatorioEntrada;
end;

end.
