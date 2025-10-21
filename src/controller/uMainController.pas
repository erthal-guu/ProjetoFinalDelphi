unit uMainController;

interface

uses uFormMainView;

type TMainController = class
  public
  procedure showLogin;
  procedure showHome;
end;

var MainController : TMainController;
implementation


procedure TMainController.showHome;
begin
  FormMain.ShowHome;
end;

procedure TMainController.showLogin;
begin
  FormMain.showLogin;
end;


end.
