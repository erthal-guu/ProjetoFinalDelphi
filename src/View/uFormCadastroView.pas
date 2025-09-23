unit uFormCadastroView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, uUsuarioDTO, UsuarioCadastroController,
  uMainController,uFormLoginView;

type
  TFormCadastro = class(TForm)
    PnlMain: TPanel;
    PnlBackground: TPanel;
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
    Image1: TImage;
    PnlCheckBox: TPanel;
    CheckBox1: TCheckBox;
    procedure PnlButtonMouseEnter(Sender: TObject);
    procedure PnlButtonMouseLeave(Sender: TObject);
    procedure PnlButtonClick(Sender: TObject);
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure LblCadastroClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.dfm}

procedure TFormCadastro.CheckBox1Click(Sender: TObject);
begin
    if EdtSenha.PasswordChar = #0 then begin
    EdtSenha.PasswordChar := '*'
   end else begin
    EdtSenha.PasswordChar := #0;
end;
end;

procedure TFormCadastro.LblCadastroClick(Sender: TObject);
begin
  MainController.showLogin;
  Application.ProcessMessages;
  Self.hide
end;

procedure TFormCadastro.LimparCampos;
begin
  EdtNome.Clear;
  EdtCPF.Clear;
  EdtSenha.Clear;
end;

procedure TFormCadastro.PnlButtonClick(Sender: TObject);
var
  Controller: TUsuarioController;
  UsuarioDTO: TUsuarioDTO;
begin
  if ValidarCampos = True then begin
    Controller := TUsuarioController.Create;
    try
      UsuarioDTO := Controller.CriarObjeto(EdtNome.Text, EdtCPF.Text,
        EdtSenha.Text);
        if Controller.SalvarUsuario(UsuarioDTO) then begin
          LimparCampos;
        end else begin
          ShowMessage('J� existe um Usu�rio com esse CPF');
        end;

    finally
      Controller.Free;
    end;
  end else begin
    exit;
  end;
end;

procedure TFormCadastro.PnlButtonMouseEnter(Sender: TObject);
begin
  PnlButton.Color := $003E1F00;
end;

procedure TFormCadastro.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color := $005E2F00;
end;

function TFormCadastro.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin
    ShowMessage('O Campo de NOME n�o pode ficar Vazio');
    exit;
  end;

  if EdtCPF.Text = '' then begin
    ShowMessage('O Campo de CPF n�o pode ficar Vazio');
    exit;
  end;
  if EdtSenha.Text = '' then begin
    ShowMessage('O Campo de SENHA n�o pode ficar Vazio');
    exit;
  end;
  if Length(EdtSenha.Text) < 5 then begin
    ShowMessage('A senha deve Conter Pelo menos "5" Caracteres');
    exit;
  end;
  Result := True;
end;

end.
