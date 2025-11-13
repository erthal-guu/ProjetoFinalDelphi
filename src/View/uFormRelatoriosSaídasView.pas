unit uFormRelatoriosSaídasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSaidas: TFormSaidas;

implementation

{$R *.dfm}

end.
