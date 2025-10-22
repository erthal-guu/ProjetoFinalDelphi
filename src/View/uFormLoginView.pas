unit uFormLoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Mask, Vcl.Imaging.jpeg, uUsuario,
  UsuarioLoginController, uMainController,uSession;

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
    PnlButton: TPanel;
    EdtSenha: TEdit;
    PnlCheckBox: TPanel;
    CheckBox1: TCheckBox;
    Image1: TImage;
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure PnlButtonClick(Sender: TObject);
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure LblCadastroClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure EdtCPFClick(Sender: TObject);
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

procedure TFormLogin.EdtCPFClick(Sender: TObject);
begin
  EdtCPF.SelStart := 0;
end;

procedure TFormLogin.LblCadastroClick(Sender: TObject);
  var
  MainController : TMainController;
begin
  MainController := TMainController.Create;
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
  Usuario, UsuarioLogado: TUsuario;
begin
  Controller := TUsuarioController.Create;
  try
    Usuario := Controller.CriarObjeto(EdtCPF.Text, EdtSenha.Text);

    if Controller.ValidarLogin(Usuario) then
    begin
      UsuarioLogado := Controller.GetIDNome(Usuario);

      MainController.showHome;
      LimparCampos;

      ShowMessage(Format('Login efetuado com sucesso! Bem-vindo %s ID:%d',
        [UsuarioLogado.getNome, UsuarioLogado.getID]));
    end
    else
      ShowMessage('CPF ou Senha inválidos!');

  finally
    Controller.Free;
  end;
end;



procedure TFormLogin.PnlButtonMouseEnter(Sender: TObject);
begin
    PnlButton.Color := $003E1F00;
end;


procedure TFormLogin.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color := $005E2F00;
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
