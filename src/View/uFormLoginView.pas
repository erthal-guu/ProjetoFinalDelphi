unit uFormLoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Mask, Vcl.Imaging.jpeg, uUsuarioDTO,
  UsuarioLoginController, uMainController;

type
  TFormLogin = class(TForm)
    PnlMain: TPanel;
    PnlBackground: TPanel;
    PnlFormulario: TPanel;
    Image2: TImage;
    PnlContainer: TPanel;
    LblTitulo: TLabel;
    PnlEdit: TPanel;
    LblSenha: TLabel;
    LblNome: TLabel;
    EdtCPF: TMaskEdit;
    PnlLabel: TPanel;
    PnlCadastrar: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    PnlButton: TPanel;
    Image1: TImage;
    EdtSenha: TEdit;
    PnlCheckBox: TPanel;
    CheckBox1: TCheckBox;
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure PnlButtonClick(Sender: TObject);
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure LblCadastroClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}



procedure TFormLogin.CheckBox1Click(Sender: TObject);
begin
  if EdtSenha.PasswordChar = #0 then begin
    EdtSenha.PasswordChar := '*'
   end else begin
    EdtSenha.PasswordChar := #0;
end;
end;

procedure TFormLogin.LblCadastroClick(Sender: TObject);
begin
  MainController.showCadastro;
  Application.ProcessMessages;
  Self.hide
end;

procedure TFormLogin.LimparCampos;
begin
  EdtCPF.Clear;
  EdtSenha.Clear;
end;


procedure TFormLogin.PnlButtonClick(Sender: TObject);
var
  Controller: TUsuarioController;
  UsuarioDTO: TUsuarioDTO;
begin
  try
    Controller := TUsuarioController.Create;
    UsuarioDTO := Controller.CriarObjeto(EdtCPF.Text, EdtSenha.Text);
    if ValidarCampos and Controller.ValidarLogin(UsuarioDTO) then begin
      ShowMessage('Login Bem Sucedido !');
      MainController.showHome;
    end else begin
      ShowMessage('CPF ou Senha inválidos!');
      LimparCampos;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormLogin.PnlButtonMouseEnter(Sender: TObject);
begin
    PnlButton.Color := $00D76B00;
end;


procedure TFormLogin.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color := clHighlight;
end;



procedure TFormLogin.RadioButton1Click(Sender: TObject);
begin
  if EdtSenha.PasswordChar = #0 then
    EdtSenha.PasswordChar := '*'
  else
    EdtSenha.PasswordChar := #0;
end;

function TFormLogin.ValidarCampos: Boolean;
begin
  if EdtCPF.Text = '' then begin
    ShowMessage('O Campo de CPF não pode ficar Vazio');
    exit;
  end;
  if EdtSenha.Text = '' then begin
    ShowMessage('O Campo de Senha não pode ficar Vazio');
    exit;
  end;
  if Length(EdtSenha.Text) < 6 then begin
    ShowMessage('A senha deve Conter Pelo menos "6" Caracteres');
    exit;
  end;
  Result := True;
end;

end.
