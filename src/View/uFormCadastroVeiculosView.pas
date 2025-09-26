unit uFormCadastroVeiculosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.Mask;

type
  TFormCadastroVeiculos = class(TForm)
    PageControl1: TPageControl;
    Veículos: TTabSheet;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtModelo: TEdit;
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
    EdtFabricação: TEdit;
    EdtCor: TEdit;
    CmbCliente: TComboBox;
    CmbCategoria: TComboBox;
    Label6: TLabel;
    EdtPlaca: TMaskEdit;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroVeiculos: TFormCadastroVeiculos;

implementation

{$R *.dfm}

procedure TFormCadastroVeiculos.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroVeiculos.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroVeiculos.FormCreate(Sender: TObject);
begin
  EdtModelo.Height := 31;
  EdtFabricação.Height := 31;
  EdtCor.Height := 31;
  EdtPlaca.Height := 31;
  CmbCategoria.Height:= 31;
  CmbCliente.Height:= 31;
  CmbCliente.Font.Size := 13;
  CmbCategoria.Font.Size := 13;
end;

end.
