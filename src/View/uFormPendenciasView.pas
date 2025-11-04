unit uFormPendenciasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.CheckLst;

type
  TFormPendencias = class(TForm)
    PnlMain: TPanel;
    Panel1: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LblStatus: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtObservacao: TEdit;
    CmbFormaPagamento: TComboBox;
    EdtValorTotal: TEdit;
    CmbStatusReceita: TComboBox;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    EdtDataRecebimento: TDateTimePicker;
    EdtReceita: TEdit;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnReceber: TSpeedButton;
    BtnDetalhar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnHistorico: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    BtnCancelar: TSpeedButton;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnLHistorico: TPanel;
    LblHistorico: TLabel;
    ImgFecharHistorico: TImage;
    PnlDesingGrid: TPanel;
    PnlBackgroundGrid: TPanel;
    DBGridHistorico: TDBGrid;
    PnlDetlhamento: TPanel;
    LblDetalhamento: TLabel;
    ImgFecharDetalhamento: TImage;
    PnlDesingDetalhamento: TPanel;
    ListBoxDetalhes: TListBox;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    Panel2: TPanel;
    Label2: TLabel;
    Image2: TImage;
    ComboBox1: TComboBox;
    Label7: TLabel;
    procedure BtnReceberClick(Sender: TObject);
    procedure parcelar;
    procedure CmbFormaPagamentoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPendencias: TFormPendencias;

implementation

{$R *.dfm}

procedure TFormPendencias.BtnReceberClick(Sender: TObject);
begin
  EdtDataRecebimento.Date := Date;
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
end;

procedure TFormPendencias.CmbFormaPagamentoChange(Sender: TObject);
begin
  parcelar;
end;

procedure TFormPendencias.FormCreate(Sender: TObject);
  begin
    EdtObservacao.Left := 521;
    label5.Left := 482;
    LblStatus.Left := 617
  end;

procedure TFormPendencias.parcelar;
begin
  if CmbFormaPagamento.ItemIndex = 2 then begin
  ComboBox1.Visible := True;
  Label7.Visible := True;
  label5.Left := 620;
  LblStatus.Left := 754;
  end else begin
  ComboBox1.Visible := False;
  Label7.Visible := False;
  label5.Left := 482;
  LblStatus.Left := 617;
  end;

end;

end.
