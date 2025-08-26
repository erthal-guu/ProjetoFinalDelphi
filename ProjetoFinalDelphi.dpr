program ProjetoFinalDelphi;

uses
  Vcl.Forms,
  uFormLogin in 'src\View\uFormLogin.pas' {Form1},
  loginForm.services in 'src\Services\loginForm.services.pas',
  LoginForm.Model in 'src\Model\LoginForm.Model.pas',
  LoginForm.controller in 'src\controller\LoginForm.controller.pas',
  LoginForm.repository in 'src\repository\LoginForm.repository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
