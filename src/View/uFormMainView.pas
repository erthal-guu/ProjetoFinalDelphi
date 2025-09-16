unit uFormMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Menus;

type
  TFormMain = class(TForm)
    PnlMain: TPanel;
  private
    { Private declarations }
  public
    procedure ShowLogin;
    procedure ShowHome;
    procedure ShowCadastro;
  end;

var
  FormMain: TFormMain;

implementation

uses uFormCadastroView, uFormLoginView,uFormHomeView;

{$R *.dfm}

{ TFormMain }

procedure TFormMain.ShowCadastro;
begin
  FormCadastro.Show;
end;

procedure TFormMain.ShowHome;
begin
  FormHome.Show;
end;

procedure TFormMain.ShowLogin;
begin
  FormLogin.Show;
end;

end.
