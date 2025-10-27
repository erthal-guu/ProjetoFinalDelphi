unit uFormReceitasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormReceitas = class(TForm)
    PnlMain: TPanel;
    Panel1: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
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
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    ImgRestaurar: TImage;
    PnLHistorico: TPanel;
    LblHistorico: TLabel;
    ImgFecharHistorico: TImage;
    PnlDesingGrid: TPanel;
    PnlBackgroundGrid: TPanel;
    DBGridHistorico: TDBGrid;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtObservacao: TEdit;
    CmbFormaPagamento: TComboBox;
    EdtValorTotal: TEdit;
    CmbStatusReceita: TComboBox;
    LblStatus: TLabel;
    EdtValorRecebido: TEdit;
    Label5: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    PnlDetlhamento: TPanel;
    LblDetalhamento: TLabel;
    PnlDesingDetalhamento: TPanel;
    ListBoxDetalhes: TListBox;
    ImgFecharDetalhamento: TImage;
    Label6: TLabel;
    EdtDataRecebimento: TDateTimePicker;
    BtnCancelar: TSpeedButton;
    CmbReceita: TComboBox;
    procedure BtnDetalharClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure BtnHistoricoClick(Sender: TObject);
    procedure ImgFecharHistoricoClick(Sender: TObject);
    procedure ImgFecharDetalhamentoClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnReceberClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReceitas: TFormReceitas;

implementation

{$R *.dfm}

procedure TFormReceitas.BtnHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := True;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDetlhamento.Visible := False;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormReceitas.BtnReceberClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlDetlhamento.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  PnlHistorico.Visible := false;
  PnlDetlhamento.Visible := false;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;
procedure TFormReceitas.BtnSairClick(Sender: TObject);
begin
    if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
    PnlDetlhamento.Visible := True;
    PnlRestaurar.Visible := False;
    PnLHistorico.Visible := False;
    PnlBackgrounEdit.Visible := False;
    EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.FormCreate(Sender: TObject);
begin
    EdtObservacao.Height := 31;
    EdtValorTotal.Height := 31;
    EdtValorRecebido.Height := 31;
    EdtDataRecebimento.Height := 31;
    CmbStatusReceita.Font.Size := 13;
    CmbFormaPagamento.Font.Size := 13;
    CmbReceita.Font.Size := 13;
end;

procedure TFormReceitas.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
end;

procedure TFormReceitas.ImgFecharDetalhamentoClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
end;

procedure TFormReceitas.ImgFecharHistoricoClick(Sender: TObject);
begin
  PnlHistorico.Visible := false;
end;

procedure TFormReceitas.BtnCancelarClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.BtnDetalharClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := True;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

end.
