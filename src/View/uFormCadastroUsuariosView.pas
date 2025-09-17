unit uFormCadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls;

type
  TFormCadastroUsuarios = class(TForm)
    PageControl1: TPageControl;
    Usuarios: TTabSheet;
    PnlMain: TPanel;
    Panel1: TPanel;
    PnlMainButton: TPanel;
    PnlButton: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    PnlMainEdit: TPanel;
    PnlCadastro: TPanel;
    PnlEdit: TPanel;
    Edit2: TEdit;
    Edit1: TEdit;
    Edit3: TEdit;
    PnlGrid: TPanel;
    DBGrid1: TDBGrid;
    PnlHeader: TPanel;
    SearchBox1: TSearchBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroUsuarios: TFormCadastroUsuarios;

implementation

{$R *.dfm}

end.
