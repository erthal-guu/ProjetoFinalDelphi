unit uFormCadastro.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormCadastro = class(TForm)
    PnlMain: TPanel;
    PnlBackground: TPanel;
    Image1: TImage;
    PnlFormulario: TPanel;
    PnlContainer: TPanel;
    LblTitulo: TLabel;
    PnlEdit: TPanel;
    LblSenha: TLabel;
    LblNome: TLabel;
    LblCPF: TLabel;
    EdtCPF: TMaskEdit;
    EdtSenha: TEdit;
    EdtNome: TEdit;
    PnlButton: TPanel;
    PnlLabel: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    Image2: TImage;
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure PnlButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.dfm}

procedure TFormCadastro.PnlButtonClick(Sender: TObject);
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

procedure TFormCadastro.PnlButtonMouseEnter(Sender: TObject);
begin
  PnlButton.Color := $00D76B00;
end;

procedure TFormCadastro.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color:=clHighlight;
end;



end.
