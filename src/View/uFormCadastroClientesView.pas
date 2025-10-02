unit uFormCadastroClientesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormCadastroClientes = class(TForm)
    PageControl1: TPageControl;
    Clientes: TTabSheet;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    LblNome: TLabel;
    LblEmail: TLabel;
    LblCPF: TLabel;
    LblTelefone: TLabel;
    LblNascimento: TLabel;
    EdtNome: TEdit;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtCPF: TMaskEdit;
    EdtEmail: TEdit;
    EdtDataNascimento: TMaskEdit;
    EdtTelefone: TMaskEdit;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlGrid: TPanel;
    DBGrid1: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    Edit1: TEdit;
    LblEndereço: TLabel;
    CmbStatus: TComboBox;
    LblStatus: TLabel;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroClientes: TFormCadastroClientes;

implementation

{$R *.dfm}

procedure TFormCadastroClientes.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroClientes.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroClientes.FormCreate(Sender: TObject);
begin
  EdtNome.Height := 31;
  EdtEmail.Height := 31;
  EdtCPF.Height := 31;
  EdtTelefone.Height := 31;
  EdtDataNascimento.Height := 31;
end;

end.
