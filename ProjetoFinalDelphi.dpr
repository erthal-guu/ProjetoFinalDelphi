program ProjetoFinalDelphi;



uses
  Vcl.Forms,
  uFormCadastroView in 'src\View\uFormCadastroView.pas' {FormCadastro},
  UsuarioCadastrorepository in 'src\repository\UsuarioCadastrorepository.pas',
  UsuarioCadastroService in 'src\Services\UsuarioCadastroService.pas',
  UsuarioCadastroController in 'src\controller\UsuarioCadastroController.pas',
  UsuarioLoginController in 'src\controller\UsuarioLoginController.pas',
  UsuarioLoginRepository in 'src\repository\UsuarioLoginRepository.pas',
  LoginUsuarioService in 'src\Services\LoginUsuarioService.pas',
  uFormLoginView in 'src\View\uFormLoginView.pas' {FormLogin},
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule},
  uMainController in 'src\controller\uMainController.pas',
  uFormCadastroUsuariosView in 'src\View\uFormCadastroUsuariosView.pas' {FormCadastroUsuarios},
  uFormCadastroFuncionariosView in 'src\View\uFormCadastroFuncionariosView.pas' {FormCadastroFuncionarios},
  uFormCadastroServiçosView in 'src\View\uFormCadastroServiçosView.pas' {FormCadastroServiços},
  uFormCadastroFornecedoresView in 'src\View\uFormCadastroFornecedoresView.pas' {FormCadastroFornecedores},
  uFormCadastroVeiculosView in 'src\View\uFormCadastroVeiculosView.pas' {FormCadastroVeiculos},
  uFormCadastroAgendamentosView in 'src\View\uFormCadastroAgendamentosView.pas' {FormAgendamentos},
  uFormCadastroOrdensServiçoView in 'src\View\uFormCadastroOrdensServiçoView.pas' {FormOrdensServiço},
  uFormHomeView in 'src\View\uFormHomeView.pas' {FormHome},
  uFormMainView in 'src\View\uFormMainView.pas' {FormMain},
  uFormCadastroClientesView in 'src\View\uFormCadastroClientesView.pas' {FormCadastroClientes},
  ClienteCadastroRepository in 'src\repository\ClienteCadastroRepository.pas',
  ClienteCadastroService in 'src\Services\ClienteCadastroService.pas',
  ClienteCadastroController in 'src\controller\ClienteCadastroController.pas',
  FuncionarioCadastroRepository in 'src\repository\FuncionarioCadastroRepository.pas',
  FuncionarioCadastroService in 'src\Services\FuncionarioCadastroService.pas',
  FuncionarioCadastroController in 'src\controller\FuncionarioCadastroController.pas',
  FornecedorCadastroRepository in 'src\repository\FornecedorCadastroRepository.pas',
  FornecedorCadastroController in 'src\controller\FornecedorCadastroController.pas',
  FornecedorCadastroService in 'src\Services\FornecedorCadastroService.pas',
  PeçasCadastroRepository in 'src\repository\PeçasCadastroRepository.pas',
  PeçasCadastroService in 'src\Services\PeçasCadastroService.pas',
  PeçasCadastroController in 'src\controller\PeçasCadastroController.pas',
  uFormCadastroPeçasView in 'src\View\uFormCadastroPeçasView.pas' {FormCadastroPecas},
  uCliente in 'src\Model\uCliente.pas',
  uFornecedor in 'src\Model\uFornecedor.pas',
  uFuncionario in 'src\Model\uFuncionario.pas',
  uPeças in 'src\Model\uPeças.pas',
  uUsuario in 'src\Model\uUsuario.pas',
  VeiculoCadastroRepository in 'src\repository\VeiculoCadastroRepository.pas',
  VeiculoCadastroService in 'src\Services\VeiculoCadastroService.pas',
  VeiculoCadastroController in 'src\controller\VeiculoCadastroController.pas',
  uVeiculo in 'src\Model\uVeiculo.pas',
  uServiço in 'src\Model\uServiço.pas',
  ServiçoCadastroRepository in 'src\repository\ServiçoCadastroRepository.pas',
  ServiçoCadastroService in 'src\Services\ServiçoCadastroService.pas',
  ServiçoCadastroController in 'src\controller\ServiçoCadastroController.pas',
  LogTxt in 'LogTxt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TFormCadastroUsuarios, FormCadastroUsuarios);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormCadastroFuncionarios, FormCadastroFuncionarios);
  Application.CreateForm(TFormCadastroServiços, FormCadastroServiços);
  Application.CreateForm(TFormCadastroFornecedores, FormCadastroFornecedores);
  Application.CreateForm(TFormCadastroVeiculos, FormCadastroVeiculos);
  Application.CreateForm(TFormAgendamentos, FormAgendamentos);
  Application.CreateForm(TFormOrdensServiço, FormOrdensServiço);
  Application.CreateForm(TFormCadastroVeiculos, FormCadastroVeiculos);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCadastroClientes, FormCadastroClientes);
  Application.CreateForm(TFormCadastroPecas, FormCadastroPecas);
  Application.Run;
end.
