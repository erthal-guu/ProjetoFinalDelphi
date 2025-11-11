unit uFormRelatoriosEntradasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VclTee.TeeGDIPlus, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, RelatorioEntradaController, Vcl.Imaging.pngimage, Data.DB,RelatoriosController,
  VCLTee.DBChart;

type
  TFormEntradas = class(TForm)
    PnlRestaurar: TPanel;
    LblTituloEntradas: TLabel;
    PnlMainRestaurar: TPanel;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    ImgFecharEntradas: TImage;
    Panel1: TPanel;
    LblTitulo: TLabel;
    Label1: TLabel;
    CmbRelatorios: TComboBox;
    Panel2: TPanel;
    Shape2: TShape;
    PnlAdicionar: TPanel;
    LblAdicionar: TLabel;
    Panel3: TPanel;
    Shape1: TShape;
    Panel4: TPanel;
    Label4: TLabel;
    PnlQuantidade: TPanel;
    LblQuantidadeHead: TLabel;
    LblQuantidade: TLabel;
    PnlTicket: TPanel;
    LblTicketHead: TLabel;
    LblTicketMedio: TLabel;
    PnlTotal: TPanel;
    LblTotalHead: TLabel;
    LblTotal: TLabel;
    PnlLogo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgFecharEntradasClick(Sender: TObject);
    procedure LblAdicionarClick(Sender: TObject);
    procedure AtualizarTotalEntradas;
    procedure AtualizarQuantidadeEntradas;
    procedure AtualizarTicketMedio;
  end;

var
  FormEntradas: TFormEntradas;
  Controller: TRelatorioEntradaController;
  RelatorioController : TRelatorioController;

implementation

{$R *.dfm}

{ TFormEntradas }

procedure TFormEntradas.FormCreate(Sender: TObject);
begin
  Controller := TRelatorioEntradaController.Create;
  RelatorioController := TRelatorioController.create
end;

procedure TFormEntradas.FormDestroy(Sender: TObject);
begin
  Controller.Free;
  RelatorioController.Free;
end;

procedure TFormEntradas.FormShow(Sender: TObject);
begin
  AtualizarTotalEntradas;
  AtualizarQuantidadeEntradas;
  AtualizarTicketMedio;
end;

procedure TFormEntradas.ImgFecharEntradasClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar esse Formulário?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then
  begin
   Self.close;
  end;
end;

procedure TFormEntradas.LblAdicionarClick(Sender: TObject);
begin
  RelatorioController.GerarRelatorioEntrada;
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
    LblTicketMedio.Caption := FormatFloat('#,##0.00', TicketMedio);
end;

procedure TFormEntradas.AtualizarTotalEntradas;
var
  Total: Double;
begin
    Total := Controller.GetTotalEntradas;
    LblTotal.Caption := FormatFloat('#,##0.00', Total);
end;

end.
