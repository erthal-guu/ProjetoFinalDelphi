unit uFormHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  uFormCadastroUsuariosView,

  uFormCadastroClientesView,
  uFormCadastroFuncionariosView,
  uFormCadastroFornecedoresView,
  uFormCadastroPeçasView,
  uFormCadastroServiçosView, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus;

type
  TFormHome = class(TForm)
    PnlMain: TPanel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}


end.
