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
  uFormCadastroPe�asView,
  uFormCadastroServi�osView,
<<<<<<< HEAD
=======
  uFormCadastroVeiculosView,
  uFormCadastroOrdensServi�oView,
>>>>>>> c49b2d9 (Configurações graficas iniciais da tela de home)
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
    Funcion�rios: TMenuItem;
    Ve�culos: TMenuItem;
    Servi�os: TMenuItem;
    OrdensServi�o: TMenuItem;
    Relat�rios: TMenuItem;
    Financeiro: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    Pe�as: TMenuItem;
    Agendamentos: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure CadastrosClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure FornecedoresClick(Sender: TObject);
    procedure Funcion�riosClick(Sender: TObject);
    procedure Ve�culosClick(Sender: TObject);
    procedure Servi�osClick(Sender: TObject);
    procedure OrdensServi�oClick(Sender: TObject);
    procedure Pe�asClick(Sender: TObject);
    procedure AgendamentosClick(Sender: TObject);
>>>>>>> c49b2d9 (Configurações graficas iniciais da tela de home)
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

procedure TFormHome.Funcion�riosClick(Sender: TObject);
begin
  FormCadastroFornecedores.Position := poScreenCenter;
  FormCadastroFornecedores.Show;
end;

procedure TFormHome.Ve�culosClick(Sender: TObject);
begin
  FormCadastroVeiculos.Position := poScreenCenter;
  FormCadastroVeiculos.Show;
end;

procedure TFormHome.Pe�asClick(Sender: TObject);
begin
  FormCadastroPe�as.Position := poScreenCenter;
  FormCadastroPe�as.Show;
end;

procedure TFormHome.Servi�osClick(Sender: TObject);
begin
  FormCadastroServi�os.Position := poScreenCenter;
  FormCadastroServi�os.Show;
end;

procedure TFormHome.OrdensServi�oClick(Sender: TObject);
begin
  FormCadastroOrdensServi�o.Position := poScreenCenter;
  FormCadastroOrdensServi�o.Show;
end;


procedure TFormHome.Sair1Click(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar a aplica��o?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
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
  FormCadastroPe�as.Show;
end;

procedure TFormHome.Peas2Click(Sender: TObject);
begin
  FormCadastroServi�os.Show;
end;


end.
