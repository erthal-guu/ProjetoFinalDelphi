unit uFormHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  uFormCadastroUsuariosView,
  uFormCadastroClientesView,
  uFormCadastroFuncionariosView,
  uFormCadastroFornecedoresView,
  uFormCadastroPeçasView,
  uFormCadastroServiçosView,
<<<<<<< HEAD
=======
  uFormCadastroVeiculosView,
  uFormCadastroOrdensServiçoView,
>>>>>>> c49b2d9 (ConfiguraÃ§Ãµes graficas iniciais da tela de home)
   Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus;

type
  TFormHome = class(TForm)
    PnlMain: TPanel;
    Image1: TImage;
    MainMenu1: TMainMenu;
<<<<<<< HEAD
    Cadastror1: TMenuItem;
    Usuarios1: TMenuItem;
    Usuarios2: TMenuItem;
    Funcionarios1: TMenuItem;
    Funcionarios2: TMenuItem;
    Peas1: TMenuItem;
    Peas2: TMenuItem;
    procedure Usuarios1Click(Sender: TObject);
    procedure Usuarios2Click(Sender: TObject);
    procedure Funcionarios1Click(Sender: TObject);
    procedure Funcionarios2Click(Sender: TObject);
    procedure Peas1Click(Sender: TObject);
    procedure Peas2Click(Sender: TObject);
=======
    Cadastros1: TMenuItem;
    Cadastros: TMenuItem;
    Clientes: TMenuItem;
    Fornecedores: TMenuItem;
    Funcionários: TMenuItem;
    Veículos: TMenuItem;
    Serviços: TMenuItem;
    OrdensServiço: TMenuItem;
    Relatórios: TMenuItem;
    Financeiro: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    Peças: TMenuItem;
    Agendamentos: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure CadastrosClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure FornecedoresClick(Sender: TObject);
    procedure FuncionáriosClick(Sender: TObject);
    procedure VeículosClick(Sender: TObject);
    procedure ServiçosClick(Sender: TObject);
    procedure OrdensServiçoClick(Sender: TObject);
    procedure PeçasClick(Sender: TObject);
    procedure AgendamentosClick(Sender: TObject);
>>>>>>> c49b2d9 (ConfiguraÃ§Ãµes graficas iniciais da tela de home)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}

uses uFormCadastroAgendamentosView;


procedure TFormHome.AgendamentosClick(Sender: TObject);
begin
  FormCadastroAgendamentos.Position := poScreenCenter;
  FormCadastroAgendamentos.Show;
end;

procedure TFormHome.CadastrosClick(Sender: TObject);
begin
  FormCadastroUsuarios.Position := poScreenCenter;
  FormCadastroUsuarios.Show;
end;

procedure TFormHome.ClientesClick(Sender: TObject);
begin
  FormCadastroClientes.Position := poScreenCenter;
  FormCadastroClientes.Show;
end;

procedure TFormHome.FornecedoresClick(Sender: TObject);
begin
  FormCadastroFuncionarios.Position := poScreenCenter;
  FormCadastroFuncionarios.Show;
end;

procedure TFormHome.FuncionáriosClick(Sender: TObject);
begin
  FormCadastroFornecedores.Position := poScreenCenter;
  FormCadastroFornecedores.Show;
end;

procedure TFormHome.VeículosClick(Sender: TObject);
begin
  FormCadastroVeiculos.Position := poScreenCenter;
  FormCadastroVeiculos.Show;
end;

procedure TFormHome.PeçasClick(Sender: TObject);
begin
  FormCadastroPeças.Position := poScreenCenter;
  FormCadastroPeças.Show;
end;

procedure TFormHome.ServiçosClick(Sender: TObject);
begin
  FormCadastroServiços.Position := poScreenCenter;
  FormCadastroServiços.Show;
end;

procedure TFormHome.OrdensServiçoClick(Sender: TObject);
begin
  FormCadastroOrdensServiço.Position := poScreenCenter;
  FormCadastroOrdensServiço.Show;
end;


procedure TFormHome.Sair1Click(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar a aplicação?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Application.Terminate;
  end;
end;




procedure TFormHome.Usuarios1Click(Sender: TObject);
begin
  FormCadastroUsuarios.show;
end;


procedure TFormHome.Usuarios2Click(Sender: TObject);
begin
  FormCadastroClientes.show;
end;

procedure TFormHome.Funcionarios1Click(Sender: TObject);
begin
  FormCadastroFuncionarios.Show;
end;

procedure TFormHome.Funcionarios2Click(Sender: TObject);
begin
  FormCadastroFornecedores.Show;
end;

procedure TFormHome.Peas1Click(Sender: TObject);
begin
  FormCadastroPeças.Show;
end;

procedure TFormHome.Peas2Click(Sender: TObject);
begin
  FormCadastroServiços.Show;
end;


end.
