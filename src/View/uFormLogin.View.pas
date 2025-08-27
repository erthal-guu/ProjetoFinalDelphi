unit uFormLogin.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Mask, Vcl.Imaging.jpeg,uFormCadastro.View;

type
  TFormLogin = class(TForm)
    PnlMain: TPanel;
    PnlBackground: TPanel;
    Image1: TImage;
    PnlFormulario: TPanel;
    PnlContainer: TPanel;
    PnlEdit: TPanel;
    LblSenha: TLabel;
    LblNome: TLabel;
    EdtCPF: TMaskEdit;
    EdtSenha: TEdit;
    PnlButton: TPanel;
    PnlLabel: TPanel;
    LblTitulo: TLabel;
    PnlCadastrar: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    Image2: TImage;
    procedure LblCadastroClick(Sender: TObject);
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure PnlButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}



procedure TFormLogin.LblCadastroClick(Sender: TObject);
begin
  FormCadastro.Show;
end;


procedure TFormLogin.PnlButtonClick(Sender: TObject);
begin
  if EdtCPF.text = '' then begin
  ShowMessage('O Campo de CPF não pode ficar Vazio');
  exit;
  end;
  if EdtSenha.Text = '' then begin
  ShowMessage('O Campo de Senha não pode ficar Vazio');
  exit;
  end;

  if EdtSenha.ControlCount<8 then begin
    ShowMessage('A senha deve Conter Pelo menos "8" Caracteres');
  end;

end;

procedure TFormLogin.PnlButtonMouseEnter(Sender: TObject);
begin
  PnlButton.Color := $00D76B00;
end;

procedure TFormLogin.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color:=clHighlight;
end;



end.
