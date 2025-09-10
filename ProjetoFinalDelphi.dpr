program ProjetoFinalDelphi;



uses
  Vcl.Forms,
  uFormCadastroView in 'src\View\uFormCadastroView.pas' {FormCadastro},
  UsuarioCadastrorepository in 'src\repository\UsuarioCadastrorepository.pas',
  uFormCadastro.services in 'src\Services\uFormCadastro.services.pas',
  UsuarioCadastroController in 'src\controller\UsuarioCadastroController.pas',
  UsuarioLoginController in 'src\controller\UsuarioLoginController.pas',
  UsuarioLoginRepository in 'src\repository\UsuarioLoginRepository.pas',
  uFormLogin.services in 'src\Services\uFormLogin.services.pas',
  uFormLoginView in 'src\View\uFormLoginView.pas' {FormLogin},
  uUsuarioModel in 'src\Model\uUsuarioModel.pas',
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule},
  uUsuarioDTO in 'src\DTO\uUsuarioDTO.pas',
  uFormMain in 'src\View\uFormMain.pas' {FormMain},
  uFormHomeView in 'src\View\uFormHomeView.pas' {FormHome},
  uMainController in 'src\controller\uMainController.pas',
  uFormCadastroUsuariosView in 'src\View\uFormCadastroUsuariosView.pas' {FormCadastroUsuarios},
  uFormCadastroClientesView in 'src\View\uFormCadastroClientesView.pas' {FormCadastroClientes},
  uFormCadastroFuncionariosView in 'src\View\uFormCadastroFuncionariosView.pas' {FormCadastroFuncionarios},
  uFormCadastroFornecedoresView in 'uFormCadastroFornecedoresView.pas' {FormCadastroFornecedores},
  uFormCadastroServiçosView in 'src\View\uFormCadastroServiçosView.pas' {FormCadastroServiços},
  uFormCadastroPeçasView in 'src\View\uFormCadastroPeçasView.pas' {FormCadastroPeças};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormCadastroUsuarios, FormCadastroUsuarios);
  Application.CreateForm(TFormCadastroClientes, FormCadastroClientes);
  Application.CreateForm(TFormCadastroFuncionarios, FormCadastroFuncionarios);
  Application.CreateForm(TFormCadastroFornecedores, FormCadastroFornecedores);
  Application.CreateForm(TFormCadastroServiços, FormCadastroServiços);
  Application.CreateForm(TFormCadastroPeças, FormCadastroPeças);
  Application.Run;
end.
