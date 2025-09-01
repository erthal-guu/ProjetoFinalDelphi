unit uFormCadastro.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, uUsuarioDTO, UsuarioCadastroController;

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
    function ValidarCampos: Boolean;
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
var
  Controller: TUsuarioController;
  UsuarioDTO: TUsuarioDTO;
begin

  if ValidarCampos = True then begin
    UsuarioDTO := TUsuarioDTO.Create;
    Controller := TUsuarioController.Create;
    try
      Controller.CriarObjeto(UsuarioDTO, EdtNome.Text, EdtCPF.Text, EdtSenha.Text);
      Controller.SalvarUsuario(UsuarioDTO);

      ShowMessage('Usuário salvo com sucesso!');
    finally
      Controller.Free;
    end;

  end else begin
    exit;
  end;
end;

procedure TFormCadastro.PnlButtonMouseEnter(Sender: TObject);
begin
  PnlButton.Color := $00D76B00;
end;

procedure TFormCadastro.PnlButtonMouseLeave(Sender: TObject);
begin
  PnlButton.Color := clHighlight;
end;

function TFormCadastro.ValidarCampos: Boolean;
begin
  if EdtCPF.Text = '' then begin
    ShowMessage('O Campo de CPF não pode ficar Vazio');
    exit;
  end;
  if EdtSenha.Text = '' then begin
    ShowMessage('O Campo de Senha não pode ficar Vazio');
    exit;
  end;
  if Length(EdtSenha.Text) < 8 then begin
    ShowMessage('A senha deve Conter Pelo menos "8" Caracteres');
  end;
end;

end.
