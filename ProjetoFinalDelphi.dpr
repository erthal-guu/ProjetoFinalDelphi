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
  uFormHomeView in 'src\View\uFormHomeView.pas' {FormHome},
  uMainController in 'src\controller\uMainController.pas',
  uFormCadastroUsuariosView in 'src\View\uFormCadastroUsuariosView.pas' {FormCadastroUsuarios},
  uFormCadastroClientesView in 'src\View\uFormCadastroClientesView.pas' {FormCadastroClientes},
  uFormCadastroFuncionariosView in 'src\View\uFormCadastroFuncionariosView.pas' {FormCadastroFuncionarios},
  uFormCadastroServiçosView in 'src\View\uFormCadastroServiçosView.pas' {FormCadastroServiços},
  uFormCadastroPeçasView in 'src\View\uFormCadastroPeçasView.pas' {FormCadastroPeças},
  uFormCadastroFornecedoresView in 'src\View\uFormCadastroFornecedoresView.pas' {FormCadastroFornecedores},
<<<<<<< HEAD
  Vcl.Themes,
  Vcl.Styles;
=======
  uFormCadastroVeiculosView in 'src\View\uFormCadastroVeiculosView.pas' {FormCadastroVeiculos},
  uFormCadastroAgendamentosView in 'src\View\uFormCadastroAgendamentosView.pas' {FormCadastroAgendamentos},
  uFormCadastroOrdensServiçoView in 'src\View\uFormCadastroOrdensServiçoView.pas' {FormCadastroOrdensServiço},
  uFormMainView in 'src\View\uFormMainView.pas' {FormMain};
>>>>>>> c49b2d9 (ConfiguraÃ§Ãµes graficas iniciais da tela de home)

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormCadastroUsuarios, FormCadastroUsuarios);
  Application.CreateForm(TFormCadastroClientes, FormCadastroClientes);
  Application.CreateForm(TFormCadastroFuncionarios, FormCadastroFuncionarios);
  Application.CreateForm(TFormCadastroServiços, FormCadastroServiços);
  Application.CreateForm(TFormCadastroPeças, FormCadastroPeças);
  Application.CreateForm(TFormCadastroFornecedores, FormCadastroFornecedores);
  Application.CreateForm(TFormCadastroVeiculos, FormCadastroVeiculos);
  Application.CreateForm(TFormCadastroAgendamentos, FormCadastroAgendamentos);
  Application.CreateForm(TFormCadastroOrdensServiço, FormCadastroOrdensServiço);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
