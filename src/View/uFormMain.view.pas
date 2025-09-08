unit uFormMain.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    PnlMain: TPanel;
    PnlNav: TPanel;
    Image1: TImage;
    PnlButton4: TPanel;
    Label2: TLabel;
    PnlButton1: TPanel;
    Label1: TLabel;
    PnlButton3: TPanel;
    Label3: TLabel;
    PnlButton2: TPanel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

end.
