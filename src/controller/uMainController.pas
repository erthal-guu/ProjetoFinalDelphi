unit uMainController;

interface

uses uFormMainView;

type TMainController = class
  public
  procedure showCadastro;
  procedure showLogin;
  procedure showHome;
end;

var MainController : TMainController;
implementation

procedure TMainController.showCadastro;
begin
  FormMain.showCadastro;
end;

procedure TMainController.showHome;
begin
  FormMain.ShowHome;
end;

procedure TMainController.showLogin;
begin
  FormMain.showLogin;
end;


end.
