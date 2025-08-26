program ProjetoFinalDelphi;



uses
  Vcl.Forms,
  uFormCadastro.View in 'src\View\uFormCadastro.View.pas' {FormCadastro},
  uFormCadastro.Model in 'src\Model\uFormCadastro.Model.pas',
  uFormCadastro.repository in 'src\repository\uFormCadastro.repository.pas',
  uFormCadastro.services in 'src\Services\uFormCadastro.services.pas',
  uFormCadastro.Controller in 'src\controller\uFormCadastro.Controller.pas',
  uFormLogin.controller in 'src\controller\uFormLogin.controller.pas',
  uFormLogin.Model in 'src\Model\uFormLogin.Model.pas',
  uFormLogin.repository in 'src\repository\uFormLogin.repository.pas',
  uFormLogin.services in 'src\Services\uFormLogin.services.pas',
  uFormLogin.View in 'src\View\uFormLogin.View.pas' {FormLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.Run;
end.
