unit uFormHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  uFormCadastroUsuariosView,
  uFormCadastroClientesView,
  uFormCadastroFuncionariosView,
  uFormCadastroFornecedoresView,
  uFormCadastroVeiculosView,
  uFormPendenciasView,
  uFormReceitasView,
  uFormCadastroPeçasView,
  uFormCadastroServiçosView,
  uFormCadastroOrdensServiçoView, Vcl.Menus, Vcl.Imaging.pngimage, Vcl.StdCtrls,uSession,
  Vcl.Buttons,uMainController;


type
  TFormHome = class(TForm)
    MainMenu: TMainMenu;
    Cadastros: TMenuItem;
    Usuarios: TMenuItem;
    Clientes: TMenuItem;
    Funcionarios: TMenuItem;
    Fornecedores: TMenuItem;
    Peças: TMenuItem;
    Veiculos: TMenuItem;
    Serviços: TMenuItem;
    Relatorios: TMenuItem;
    Financeiro: TMenuItem;
    Sair: TMenuItem;
    PnlMain: TPanel;
    PnlLogo: TImage;
    Pendncias1: TMenuItem;
    Receitas1: TMenuItem;
    PnlFooter: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Shape2: TShape;
    LblUsuarioLogado: TLabel;
    Panel1: TPanel;
    Panel6: TPanel;
    Shape3: TShape;
    Image1: TImage;
    Movimentações: TMenuItem;
    OrdensServio1: TMenuItem;
    procedure SairClick(Sender: TObject);
    procedure FuncionariosClick(Sender: TObject);
    procedure FornecedoresClick(Sender: TObject);
    procedure PeçasClick(Sender: TObject);
    procedure VeiculosClick(Sender: TObject);
    procedure ServiçosClick(Sender: TObject);
    procedure UsuariosClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure Pendncias1Click(Sender: TObject);
    procedure Receitas1Click(Sender: TObject);
    procedure ExibirDadosUsuarioLogado;
    procedure FormShow(Sender: TObject);
    procedure VerificarPermissoes;
    procedure Image1Click(Sender: TObject);
    procedure OrdensServio1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}



procedure TFormHome.ExibirDadosUsuarioLogado;
begin
LblUsuarioLogado.Caption := Format('Bem-vindo %s : %s', [uSession.UsuarioLogadoNome, uSession.UsuarioLogadoGrupo]);
end;

procedure TFormHome.FuncionariosClick(Sender: TObject);
begin
  FormCadastroFuncionarios.Show;
  FormCadastroFuncionarios.Position := poScreenCenter;
end;

procedure TFormHome.Image1Click(Sender: TObject);
begin
  MainController.ShowLogin;
  Self.Hide;
end;

procedure TFormHome.SairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar a aplicação?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then
  begin
    Application.Terminate;
  end;
end;

procedure TFormHome.ServiçosClick(Sender: TObject);
begin
  FormCadastroServiços.Position := poScreenCenter;
  FormCadastroServiços.Show;
end;


procedure TFormHome.UsuariosClick(Sender: TObject);
begin
  FormCadastroUsuarios.Position := poScreenCenter;
  FormCadastroUsuarios.Show;
end;

procedure TFormHome.VeiculosClick(Sender: TObject);
begin
  FormCadastroVeiculos.Position := poScreenCenter;
  FormCadastroVeiculos.Show;
end;

procedure TFormHome.VerificarPermissoes;
var
  grupo: string;
begin
  grupo := LowerCase(Trim(uSession.UsuarioLogadoGrupo));

  if grupo = 'administrador' then begin
  end;

  if grupo = 'gerente' then begin
    FormCadastroFornecedores.BtnExcluir.Visible := False;
    FormCadastroFornecedores.BtnRestaurar.Visible := False;
    FormCadastroPecas.BtnExcluir.Visible := False;
    FormCadastroPecas.BtnRestaurar.Visible := False;
    FormCadastroVeiculos.BtnExcluir.Visible := False;
    FormCadastroVeiculos.BtnRestaurar.Visible := False;
  end;

  if grupo = 'atendente' then begin
    Usuarios.Visible := False;
    Funcionarios.Visible := False;
    Fornecedores.Visible := False;
    Peças.Visible := False;
    FormCadastroVeiculos.BtnExcluir.Visible := False;
    FormCadastroVeiculos.BtnRestaurar.Visible := False;
    FormCadastroServiços.BtnExcluir.Visible := False;
    FormCadastroServiços.BtnRestaurar.Visible := False;
    FormCadastroServiços.BtnEditar.Visible := False;
    FormCadastroOrdensServiço.BtnEditar.Visible := False;
    FormCadastroOrdensServiço.BtnExcluir.Visible := False;
    FormCadastroOrdensServiço.BtnRestaurar.Visible := False;
    Financeiro.Visible := False;
  end;

  if grupo = 'mecânico' then begin
    Usuarios.Visible := False;
    Clientes.Visible := False;
    Funcionarios.Visible := False;
    Fornecedores.Visible := False;
    Peças.Visible := False;
    FormCadastroServiços.PnlMainButton.Visible := False;
    FormCadastroServiços.EdtPesquisar.Visible := True;
    FormCadastroVeiculos.PnlMainButton.Visible := False;
    FormCadastroVeiculos.EdtPesquisar.Visible := True;
    FormCadastroOrdensServiço.PnlMainButton.Visible := False;
    FormCadastroOrdensServiço.PnlBackgroundButton.Visible := False;
    FormCadastroOrdensServiço.EdtPesquisar.Visible := True;
    Financeiro.Visible := False;
    Movimentações.Visible := False;
  end;
  end;

procedure TFormHome.ClientesClick(Sender: TObject);
begin
  FormCadastroClientes.Position := poScreenCenter;
  FormCadastroClientes.Show;
end;

procedure TFormHome.FormShow(Sender: TObject);
begin
 if not Assigned(FormCadastroFornecedores) then
    FormCadastroFornecedores := TFormCadastroFornecedores.Create(Application);

  if not Assigned(FormCadastroPecas) then
    FormCadastroPecas := TFormCadastroPecas.Create(Application);

  if not Assigned(FormCadastroVeiculos) then
    FormCadastroVeiculos := TFormCadastroVeiculos.Create(Application);

  if not Assigned(FormCadastroServiços) then
    FormCadastroServiços := TFormCadastroServiços.Create(Application);

  if not Assigned(FormCadastroOrdensServiço) then
    FormCadastroOrdensServiço := TFormCadastroOrdensServiço.Create(Application);
  ExibirDadosUsuarioLogado;
  VerificarPermissoes;
  FormCadastroOrdensServiço.AplicarPermissoes(uSession.UsuarioLogadoGrupo);
end;

procedure TFormHome.FornecedoresClick(Sender: TObject);
begin
  FormCadastroFornecedores.Position := poScreenCenter;
  FormCadastroFornecedores.Show;
end;

procedure TFormHome.OrdensServio1Click(Sender: TObject);
begin
  FormCadastroOrdensServiço.Position := poScreenCenter;
  FormCadastroOrdensServiço.Show;
end;


procedure TFormHome.Pendncias1Click(Sender: TObject);
begin
  FormPendencias.Position := poScreenCenter;
  FormPendencias.Show;
end;

procedure TFormHome.PeçasClick(Sender: TObject);
begin
  FormCadastroPecas.Position := poScreenCenter;
  FormCadastroPecas.Show;
end;

procedure TFormHome.Receitas1Click(Sender: TObject);
begin
  FormReceitas.Position := poScreenCenter;
  FormReceitas.Show;
end;

end.
