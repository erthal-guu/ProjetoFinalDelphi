unit uFormRelatoriosEntradasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,RelatorioEntradaController, Vcl.Imaging.pngimage, Data.DB,RelatoriosController;

type
  TFormEntradas = class(TForm)
    PnlRelatorio: TPanel;
    LblTituloEntradas: TLabel;
    ImgFecharEntradas: TImage;
    Panel5: TPanel;
    PnlLogo: TImage;
    PnlQuantidade: TPanel;
    LblQuantidadeHead: TLabel;
    LblQuantidade: TLabel;
    Shape3: TShape;
    Shape5: TShape;
    PnlTicket: TPanel;
    LblTicketHead: TLabel;
    LblTicketMedio: TLabel;
    PnlTotal: TPanel;
    LblTotalHead: TLabel;
    LblTotal: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    PnlEdits: TPanel;
    LblTitulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CmbRelatorios: TComboBox;
    DateTimeFinal: TDateTimePicker;
    Panel2: TPanel;
    Shape2: TShape;
    PnlAdicionar: TPanel;
    LblAdicionar: TLabel;
    DateTimeInicio: TDateTimePicker;
    Panel3: TPanel;
    Shape1: TShape;
    Panel4: TPanel;
    Label4: TLabel;
    Shape6: TShape;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Shape4: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgFecharEntradasClick(Sender: TObject);
    procedure LblAdicionarClick(Sender: TObject);
    procedure AtualizarTotalEntradas;
    procedure AtualizarQuantidadeEntradas;
    procedure AtualizarTicketMedio;
    procedure LimparFiltros;
    procedure Label4Click(Sender: TObject);
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
  RelatorioController := TRelatorioController.Create;
  DateTimeFinal.Date := now;
 DateTimeInicio.Date := now;
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

procedure TFormEntradas.Label4Click(Sender: TObject);
begin
  LimparFiltros;
end;

procedure TFormEntradas.LblAdicionarClick(Sender: TObject);
begin
  if CmbRelatorios.ItemIndex = 0 then begin
   RelatorioController.GerarRelatorioValorTotalEntrada(DateTimeInicio.Date,DateTimeFinal.Date);
  end else if CmbRelatorios.ItemIndex = 1 then begin
  RelatorioController.GerarRelatorioReceitasCanceladas(DateTimeInicio.Date,DateTimeFinal.Date);
  end else if CmbRelatorios.ItemIndex = 2 then begin
  RelatorioController.GerarRelatorioReceitasPendentes(DateTimeInicio.Date,DateTimeFinal.Date);
  end;
  end;

procedure TFormEntradas.LimparFiltros;
begin
 DateTimeFinal.Date := now;
 DateTimeInicio.Date := now;
 CmbRelatorios.ItemIndex := -1;
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
