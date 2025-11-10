unit uFormRelatoriosEntradasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VclTee.TeeGDIPlus, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart;

type
  TFormEntradas = class(TForm)
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
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
    Label5: TLabel;
    Label6: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GraficoPeçasUsadas: TChart;
    Series1: TBarSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntradas: TFormEntradas;

implementation

{$R *.dfm}
{ TFormEntradas }

end.
