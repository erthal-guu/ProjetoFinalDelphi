unit uFormCadastro.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormCadastro = class(TForm)
    PnlMain: TPanel;
    PnlFormulario: TPanel;
    imgLogo: TImage;
    PnlLabel: TPanel;
    LblLogin: TLabel;
    LblCadastro: TLabel;
    PnlEdit: TPanel;
    LblSenha: TLabel;
    LblNome: TLabel;
    EdtCPF: TMaskEdit;
    LblCPF: TLabel;
    EdtSenha: TEdit;
    EdtNome: TEdit;
    PnlButton: TPanel;
    LblEnviar: TLabel;
    PnlBackground: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.dfm}

end.
