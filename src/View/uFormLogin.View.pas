unit uFormLogin.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Mask;

type
  TFormLogin = class(TForm)
    PnlMain: TPanel;
    PnlFormulario: TPanel;
    PnlBackground: TPanel;
    PnlCadastrar: TPanel;
    LblLogin: TLabel;
    PnlButton: TPanel;
    PnlEdit: TPanel;
    CheckBox1: TCheckBox;
    imgLogo: TImage;
    EdtSenha: TEdit;
    MaskEdit1: TMaskEdit;
    LblCPF: TLabel;
    Label1: TLabel;
    LblCadastro: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}


end.
