unit uFormRelatoriosEntradasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VclTee.TeeGDIPlus, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, RelatorioEntradaController, Vcl.Imaging.pngimage;

type
  TFormEntradas = class(TForm)
    PnlRestaurar: TPanel;
    LblTituloEntradas: TLabel;
    PnlMainRestaurar: TPanel;
    Panel1: TPanel;
    LblTitulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtDataInicio: TDateTimePicker;
    CmbRelatorios: TComboBox;
    EdtDataFinal: TDateTimePicker;
    Panel2: TPanel;
    Shape2: TShape;
    PnlAdicionar: TPanel;
    LblAdicionar: TLabel;
    Panel3: TPanel;
    Shape1: TShape;
    Panel4: TPanel;
    Label4: TLabel;
    PnlGraficoPecasUsadas: TPanel;
    PnlGraficoEntradasMes: TPanel;
    GraficoEntradasMes: TChart;
    Series2: TAreaSeries;
    Shape3: TShape;
    LblTotalHead: TLabel;
    LblTotal: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    LblQuantidadeHead: TLabel;
    LblQuantidade: TLabel;
    LblTickMedioHead: TLabel;
    LblTickMedio: TLabel;
    GraficoPeçasUsadas: TChart;
    Series1: TBarSeries;
    ImgFecharEntradas: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgFecharEntradasClick(Sender: TObject);
  private
    { Private declarations }
    Controller: TRelatorioEntradaController;
    procedure AtualizarTotalEntradas;
    procedure AtualizarQuantidadeEntradas;
    procedure AtualizarTicketMedio;
  public
    { Public declarations }
  end;

var
  FormEntradas: TFormEntradas;

implementation

{$R *.dfm}

{ TFormEntradas }

procedure TFormEntradas.FormCreate(Sender: TObject);
begin
  Controller := TRelatorioEntradaController.Create;
end;

procedure TFormEntradas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TFormEntradas.FormShow(Sender: TObject);
begin
  AtualizarTotalEntradas;
  AtualizarQuantidadeEntradas;
  AtualizarTicketMedio;
end;

  procedure TFormEntradas.ImgFecharEntradasClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormEntradas.AtualizarQuantidadeEntradas;
  var
    Total: Integer;
  begin
      Total := Controller.GetQuantidadeEntradas;
      LblQuantidade.Caption := (Total).ToString;
  end;

procedure TFormEntradas.AtualizarTicketMedio;
var
  TicketMedio: Double;
begin
    TicketMedio := Controller.GetTicketMedio;
    LblTickMedio.Caption := FormatFloat('#,##0.00', TicketMedio);
end;

procedure TFormEntradas.AtualizarTotalEntradas;
var
  Total: Double;
begin
    Total := Controller.GetTotalEntradas;
    LblTotal.Caption := FormatFloat('#,##0.00', Total);
end;

end.
