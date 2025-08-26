unit uFormLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    PnlMain: TPanel;
    PnlFormulario: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    PnlButton: TPanel;
    BtnEnviar: TButton;
    PnlEdit: TPanel;
    EdtCPF: TEdit;
    EdtSenha: TEdit;
    CheckBox1: TCheckBox;
    imgLogo: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
