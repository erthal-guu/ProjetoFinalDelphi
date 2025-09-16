unit uFormCadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TFormCadastroUsuarios = class(TForm)
    PageControl1: TPageControl;
    Usuarios: TTabSheet;
    Grupos: TTabSheet;
    Panel2: TPanel;
    PnlMain: TPanel;
    PnlButton: TPanel;
    PnlExcluir: TPanel;
    PnlEditar: TPanel;
    PnlEdt: TPanel;
    PnlAdicionar: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    PnlSair: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    DBGrid1: TDBGrid;
    PnlGrid: TPanel;
    Grid: TDBGrid;
    PnlRestaurar: TPanel;
    PnlPesquisar: TPanel;
    Panel10: TPanel;
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
