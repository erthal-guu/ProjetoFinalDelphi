unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure showCadastro;
    procedure showLogin;
    procedure showHome;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses uFormCadastro.View, uFormLogin.View,uFormHome.view;

procedure TFormMain.FormShow(Sender: TObject);
begin
  showCadastro;
end;

procedure TFormMain.showCadastro;
begin
  FormCadastro.Parent := Panel1;
  FormCadastro.Show;
end;

procedure TFormMain.showHome;
begin
FormHome.Parent := Panel1;
FormHome.Show;
end;

procedure TFormMain.showLogin;
begin
  FormLogin.Parent := Panel1;
  FormLogin.Show;
end;

end.
