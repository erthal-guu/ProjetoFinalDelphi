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
  uUsuarioModel in 'src\Model\uUsuarioModel.pas',
  uDMConexao in 'src\repository\uDMConexao.pas' {DataModule1: TDataModule},
  uUsuarioDTO in 'src\DTO\uUsuarioDTO.pas',
  uMainController in 'src\controller\uMainController.pas',
  uFormCadastroUsuariosView in 'src\View\uFormCadastroUsuariosView.pas' {FormCadastroUsuarios},
  uFormCadastroFuncionariosView in 'src\View\uFormCadastroFuncionariosView.pas' {FormCadastroFuncionarios},
  uFormCadastroServi�osView in 'src\View\uFormCadastroServi�osView.pas' {FormCadastroServi�os},
  uFormCadastroFornecedoresView in 'src\View\uFormCadastroFornecedoresView.pas' {FormCadastroFornecedores},
  uFormCadastroVeiculosView in 'src\View\uFormCadastroVeiculosView.pas' {FormCadastroVeiculos},
  uFormCadastroAgendamentosView in 'src\View\uFormCadastroAgendamentosView.pas' {FormAgendamentos},
  uFormCadastroOrdensServi�oView in 'src\View\uFormCadastroOrdensServi�oView.pas' {FormOrdensServi�o},
  uFormHomeView in 'src\View\uFormHomeView.pas' {FormHome},
  uFormMainView in 'src\View\uFormMainView.pas' {FormMain},
  uFormCadastroClientesView in 'src\View\uFormCadastroClientesView.pas' {FormCadastroClientes},
  ClienteCadastroRepository in 'src\repository\ClienteCadastroRepository.pas',
  ClienteCadastroService in 'src\Services\ClienteCadastroService.pas',
  ClienteCadastroController in 'src\controller\ClienteCadastroController.pas',
  uClienteModel in 'src\Model\uClienteModel.pas',
  uClienteDTO in 'src\DTO\uClienteDTO.pas',
  FuncionarioCadastroRepository in 'src\repository\FuncionarioCadastroRepository.pas',
  FuncionarioCadastroService in 'src\Services\FuncionarioCadastroService.pas',
  FuncionarioCadastroController in 'src\controller\FuncionarioCadastroController.pas',
  uFuncionarioDTO in 'src\DTO\uFuncionarioDTO.pas',
  FornecedorCadastroRepository in 'src\repository\FornecedorCadastroRepository.pas',
  uFornecedorDTO in 'src\DTO\uFornecedorDTO.pas',
  FornecedorCadastroController in 'src\controller\FornecedorCadastroController.pas',
  FornecedorCadastroService in 'src\Services\FornecedorCadastroService.pas',
  uPe�asDTO in 'src\DTO\uPe�asDTO.pas',
  Pe�asCadastroRepository in 'src\repository\Pe�asCadastroRepository.pas',
  Pe�asCadastroService in 'src\Services\Pe�asCadastroService.pas',
  Pe�asCadastroController in 'src\controller\Pe�asCadastroController.pas',
  uFormCadastroPe�asView in 'src\View\uFormCadastroPe�asView.pas' {FormCadastroPecas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TFormCadastroUsuarios, FormCadastroUsuarios);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
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
  Application.CreateForm(TFormCadastroClientes, FormCadastroClientes);
  Application.CreateForm(TFormCadastroPecas, FormCadastroPecas);
  Application.Run;
end.
