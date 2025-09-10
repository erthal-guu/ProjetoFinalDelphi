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
  uFormCadastroServi�osView;

type
  TFormHome = class(TForm)
    PnlMain: TPanel;
    PgCntrl: TPageControl;
    TabSheet1: TTabSheet;
    PnlMenu: TPanel;
    PnlServi�os: TPanel;
    PnlPe�as: TPanel;
    PnlFornecedores: TPanel;
    PnlFuncionarios: TPanel;
    PnlClientes: TPanel;
    PnlUsuarios: TPanel;
    procedure PnlUsuariosClick(Sender: TObject);
    procedure PnlClientesClick(Sender: TObject);
    procedure PnlFuncionariosClick(Sender: TObject);
    procedure PnlFornecedoresClick(Sender: TObject);
    procedure PnlPe�asClick(Sender: TObject);
    procedure PnlServi�osClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}

procedure TFormHome.PnlClientesClick(Sender: TObject);
begin
  FormCadastroClientes.Show;
end;

procedure TFormHome.PnlFornecedoresClick(Sender: TObject);
begin
  FormCadastroFornecedores.Show
end;

procedure TFormHome.PnlFuncionariosClick(Sender: TObject);
begin
  FormCadastroFuncionarios.Show
end;

procedure TFormHome.PnlPe�asClick(Sender: TObject);
begin
  FormCadastroPe�as.Show
end;

procedure TFormHome.PnlServi�osClick(Sender: TObject);
begin
  FormCadastroServi�os.Show
end;

procedure TFormHome.PnlUsuariosClick(Sender: TObject);
begin
  FormCadastroUsuarios.show;
end;

end.
