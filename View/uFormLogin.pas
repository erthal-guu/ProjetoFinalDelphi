unit uFormLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Mask;

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
    EdtSenha: TEdit;
    CheckBox1: TCheckBox;
    EdtCPF: TMaskEdit;
    MaskEdit1: TMaskEdit;
    imgLogo: TImage;
    procedure EdtCPFChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.EdtCPFChange(Sender: TObject);
begin
if Length(EdtCPF.text)>11 then begin
  ShowMessage('Quantidade de Caracteres inváidas');
end;
end;

end.
