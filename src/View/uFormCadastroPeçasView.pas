unit uFormCadastroPe�asView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls;

type
  TFormCadastroPe�as = class(TForm)
    PageControl1: TPageControl;
    Pe�as: TTabSheet;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtCodigoInt: TEdit;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtDescri��o: TEdit;
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
    EdtNome: TEdit;
    Label3: TLabel;
    CmbUnidade: TComboBox;
    Label4: TLabel;
    CmbCategoria: TComboBox;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FormCadastroPe�as: TFormCadastroPe�as;

implementation

{$R *.dfm}

procedure TFormCadastroPe�as.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroPe�as.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroPe�as.FormCreate(Sender: TObject);
begin
  EdtNome.Height := 31;
  EdtDescri��o.Height := 31;
  EdtCodigoInt.Height := 31;
  CmbCategoria.Height:= 31;
  CmbCategoria.Font.Size := 13;
  CmbUnidade.Font.Size := 13;
  CmbUnidade.Height:= 31;
end;

end.
