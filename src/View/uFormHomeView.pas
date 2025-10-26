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
  uFormCadastroOrdensServiçoView, Vcl.Menus, Vcl.Imaging.pngimage, Vcl.StdCtrls;


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
    OrdensServiço: TMenuItem;
    Relatorios: TMenuItem;
    Financeiro: TMenuItem;
    Sair: TMenuItem;
    PnlMain: TPanel;
    PnlLogo: TImage;
    PnlFooter: TPanel;
    Timer: TTimer;
    PnlDataTime: TPanel;
    ShapeFooter: TShape;
    LblDataTime: TLabel;
    Pendncias1: TMenuItem;
    Receitas1: TMenuItem;
    procedure SairClick(Sender: TObject);
    procedure FuncionariosClick(Sender: TObject);
    procedure FornecedoresClick(Sender: TObject);
    procedure PeçasClick(Sender: TObject);
    procedure VeiculosClick(Sender: TObject);
    procedure ServiçosClick(Sender: TObject);
    procedure OrdensServiçoClick(Sender: TObject);
    procedure UsuariosClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Pendncias1Click(Sender: TObject);
    procedure Receitas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}


procedure TFormHome.FuncionariosClick(Sender: TObject);
begin
  FormCadastroFuncionarios.Show;
  FormCadastroFuncionarios.Position := poScreenCenter;
end;

procedure TFormHome.SairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar a aplicação?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then begin
    Application.Terminate;
  end;
end;

procedure TFormHome.ServiçosClick(Sender: TObject);
begin
  FormCadastroServiços.Position := poScreenCenter;
  FormCadastroServiços.Show;
end;

procedure TFormHome.TimerTimer(Sender: TObject);
begin
  LblDataTime.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
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

procedure TFormHome.ClientesClick(Sender: TObject);
begin
  FormCadastroClientes.Position := poScreenCenter;
  FormCadastroClientes.Show;
end;

procedure TFormHome.FornecedoresClick(Sender: TObject);
begin
  FormCadastroFornecedores.Position := poScreenCenter;
  FormCadastroFornecedores.Show;
end;

procedure TFormHome.OrdensServiçoClick(Sender: TObject);
begin
  FormOrdensServiço.Position := poScreenCenter;
  FormOrdensServiço.Show;
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
