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
    EdtSenha: TEdit;
    EdtCPF: TMaskEdit;
    PnlLabel: TPanel;
    PnlCadastrar: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    PnlButton: TPanel;
    Image1: TImage;
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure PnlButtonClick(Sender: TObject);
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure LblCadastroClick(Sender: TObject);
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
  MainController.showCadastro;
  Application.ProcessMessages;
  Self.Close;
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
