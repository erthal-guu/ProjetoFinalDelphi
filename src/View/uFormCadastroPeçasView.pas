unit uFormCadastroPeçasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls;

type
  TFormCadastroPeças = class(TForm)
    PageControl1: TPageControl;
    Peças: TTabSheet;
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
    EdtDescrição: TEdit;
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
  FormCadastroPeças: TFormCadastroPeças;

implementation

{$R *.dfm}

procedure TFormCadastroPeças.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroPeças.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroPeças.FormCreate(Sender: TObject);
begin
  EdtNome.Height := 31;
  EdtDescrição.Height := 31;
  EdtCodigoInt.Height := 31;
  CmbCategoria.Height:= 31;
  CmbCategoria.Font.Size := 13;
  CmbUnidade.Font.Size := 13;
  CmbUnidade.Height:= 31;
end;

end.
