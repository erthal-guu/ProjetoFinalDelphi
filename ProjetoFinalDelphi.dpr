program ProjetoFinalDelphi;



uses
  Vcl.Forms,
  uFormCadastroView in 'src\View\uFormCadastroView.pas' {FormCadastro},
  UsuarioCadastrorepository in 'src\repository\UsuarioCadastrorepository.pas',
  CadastroUsuarioService in 'src\Services\CadastroUsuarioService.pas',
  UsuarioCadastroController in 'src\controller\UsuarioCadastroController.pas',
  UsuarioLoginController in 'src\controller\UsuarioLoginController.pas',
  UsuarioLoginRepository in 'src\repository\UsuarioLoginRepository.pas',
  LoginUsuarioService in 'src\Services\LoginUsuarioService.pas',
  uFormLoginView in 'src\View\uFormLoginView.pas' {FormLogin},
  uUsuarioModel in 'src\Model\uUsuarioModel.pas',
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule},
  uUsuarioDTO in 'src\DTO\uUsuarioDTO.pas',
  uMainController in 'src\controller\uMainController.pas',
  uFormCadastroUsuariosView in 'src\View\uFormCadastroUsuariosView.pas' {FormCadastroUsuarios},
  uFormCadastroClientesView in 'src\View\uFormCadastroClientesView.pas' {FormCadastroClientes},
  uFormCadastroFuncionariosView in 'src\View\uFormCadastroFuncionariosView.pas' {FormCadastroFuncionarios},
  uFormCadastroServi�osView in 'src\View\uFormCadastroServi�osView.pas' {FormCadastroServi�os},
  uFormCadastroPe�asView in 'src\View\uFormCadastroPe�asView.pas' {FormCadastroPe�as},
  uFormCadastroFornecedoresView in 'src\View\uFormCadastroFornecedoresView.pas' {FormCadastroFornecedores},
  uFormCadastroVeiculosView in 'src\View\uFormCadastroVeiculosView.pas' {FormCadastroVeiculos},
  uFormCadastroAgendamentosView in 'src\View\uFormCadastroAgendamentosView.pas' {FormAgendamentos},
  uFormCadastroOrdensServi�oView in 'src\View\uFormCadastroOrdensServi�oView.pas' {FormOrdensServi�o},
  uFormHomeView in 'src\View\uFormHomeView.pas' {FormHome},
  uFormMainView in 'src\View\uFormMainView.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TFormCadastroUsuarios, FormCadastroUsuarios);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormCadastroPe�as, FormCadastroPe�as);
  Application.CreateForm(TFormCadastroClientes, FormCadastroClientes);
  Application.CreateForm(TFormCadastroFuncionarios, FormCadastroFuncionarios);
  Application.CreateForm(TFormCadastroServi�os, FormCadastroServi�os);
  Application.CreateForm(TFormCadastroFornecedores, FormCadastroFornecedores);
  Application.CreateForm(TFormCadastroVeiculos, FormCadastroVeiculos);
  Application.CreateForm(TFormAgendamentos, FormAgendamentos);
  Application.CreateForm(TFormOrdensServi�o, FormOrdensServi�o);
  Application.CreateForm(TFormCadastroVeiculos, FormCadastroVeiculos);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
