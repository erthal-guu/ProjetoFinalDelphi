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
  uFormLogin.View in 'src\View\uFormLogin.View.pas' {FormLogin},
  uUsuarioModel in 'src\Model\uUsuarioModel.pas',
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
