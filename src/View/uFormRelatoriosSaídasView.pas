unit uFormRelatoriosSaídasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage,RelatorioSaidaController,RelatoriosController;

type
  TFormSaidas = class(TForm)
    PnlRelatorio: TPanel;
    LblTituloEntradas: TLabel;
    ImgFecharEntradas: TImage;
    Panel5: TPanel;
    Image4: TImage;
    PnlLogo: TImage;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
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
    Image6: TImage;
    DateTimeInicio: TDateTimePicker;
    Panel3: TPanel;
    Shape1: TShape;
    Panel4: TPanel;
    Label4: TLabel;
    Image5: TImage;
    PnlQuantidade: TPanel;
    LblQuantidadeHead: TLabel;
    LblQuantidade: TLabel;
    Image2: TImage;
    PnlTicket: TPanel;
    LblTicketHead: TLabel;
    LblTicketMedio: TLabel;
    Image3: TImage;
    PnlTotal: TPanel;
    LblTotalHead: TLabel;
    LblTotal: TLabel;
    Image1: TImage;
    procedure ImgFecharEntradasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AtualizarTotalSaidas;
    procedure AtualizarQuantidadeSaidas;
    procedure AtualizarTicketMedio;
    procedure FormShow(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure LimparFiltros;
    procedure LblAdicionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSaidas: TFormSaidas;
  Controller: TRelatorioSaidaController;
  RelatorioController : TRelatorioController;

implementation

{$R *.dfm}

procedure TFormSaidas.AtualizarQuantidadeSaidas;
var
  Total: Integer;
begin
  Total := Controller.GetQuantidadeSaidas;
  LblQuantidade.Caption := (Total).ToString;
end;

procedure TFormSaidas.AtualizarTicketMedio;
var
  TicketMedio: Double;
begin
  TicketMedio := Controller.GetTicketMedio;
  LblTicketMedio.Caption := FormatFloat('#,##0.00', TicketMedio);
end;

procedure TFormSaidas.AtualizarTotalSaidas;
var
  Total: Double;
begin
    Total := Controller.GetTotalSaidas;
    LblTotal.Caption := FormatFloat('#,##0.00', Total);
end;

procedure TFormSaidas.FormCreate(Sender: TObject);
begin
  Controller := TRelatorioSaidaController.Create;
  RelatorioController := TRelatorioController.Create;
  DateTimeFinal.Date := now;
  DateTimeInicio.Date := now;
end;

procedure TFormSaidas.FormShow(Sender: TObject);
begin
  AtualizarTotalSaidas;
  AtualizarQuantidadeSaidas;
  AtualizarTicketMedio;
end;

procedure TFormSaidas.ImgFecharEntradasClick(Sender: TObject);
begin
if MessageDlg('Deseja realmente fechar esse Formulário?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then begin
   Self.close;
  end;
end;


procedure TFormSaidas.Label4Click(Sender: TObject);
begin
  LimparFiltros;
end;

procedure TFormSaidas.LblAdicionarClick(Sender: TObject);
begin
    if MessageDlg('Deseja realmente Gerar um Relatório?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then
  begin
  if CmbRelatorios.ItemIndex = 0 then begin
   RelatorioController.GerarRelatorioPendenciasConcluidas(DateTimeInicio.Date,DateTimeFinal.Date);
  end else if CmbRelatorios.ItemIndex = 1 then begin
  RelatorioController.GerarRelatorioPendenciasPendentes(DateTimeInicio.Date,DateTimeFinal.Date);
  end;
end;
end;

procedure TFormSaidas.LimparFiltros;
begin
 DateTimeFinal.Date := now;
 DateTimeInicio.Date := now;
 CmbRelatorios.ItemIndex := -1;
end;

end.
