program ProjetoFinalDelphi;



uses
  Vcl.Forms,
  uFormCadastro.View in 'src\View\uFormCadastro.View.pas' {FormCadastro},
  UsuarioCadastrorepository in 'src\repository\UsuarioCadastrorepository.pas',
  uFormCadastro.services in 'src\Services\uFormCadastro.services.pas',
  UsuarioCadastroController in 'src\controller\UsuarioCadastroController.pas',
  UsuarioLoginController in 'src\controller\UsuarioLoginController.pas',
  UsuarioLoginRepository in 'src\repository\UsuarioLoginRepository.pas',
  uFormLogin.services in 'src\Services\uFormLogin.services.pas',
  uFormLogin.View in 'src\View\uFormLogin.View.pas' {FormLogin},
  uUsuarioModel in 'src\Model\uUsuarioModel.pas',
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule},
  uUsuarioDTO in 'src\DTO\uUsuarioDTO.pas',
  uFormMain.view in 'src\View\uFormMain.view.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
