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
   Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus;

type
  TFormHome = class(TForm)
    PnlMain: TPanel;
    Image1: TImage;
    MainMenu1: TMainMenu;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}




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
