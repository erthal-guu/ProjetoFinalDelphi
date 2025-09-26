unit uFormCadastroServiçosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TFormCadastroServiços = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    Veículos: TTabSheet;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
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
    PnlEdit: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtNome: TEdit;
    EdtObs: TEdit;
    CmbProfissional: TComboBox;
    EdtPreço: TEdit;
    CmbCategoria: TComboBox;
    Label2: TLabel;
    CmbPeças: TComboBox;
    Label6: TLabel;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroServiços: TFormCadastroServiços;

implementation

{$R *.dfm}

procedure TFormCadastroServiços.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroServiços.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroServiços.FormCreate(Sender: TObject);
begin
  EdtObs.Height := 31;
  EdtNome.Height := 31;
  EdtPreço.Height := 31;
  CmbCategoria.Height:= 31;
  CmbProfissional.Height:= 31;
  CmbPeças.Height:= 31;
  CmbPeças.Font.Size := 13;
  CmbProfissional.Font.Size := 13;
  CmbCategoria.Font.Size := 13;
end;

end.
