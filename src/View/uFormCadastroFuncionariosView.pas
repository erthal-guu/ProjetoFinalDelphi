unit uFormCadastroFuncionariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TFormCadastroFuncionarios = class(TForm)
    Panel1: TPanel;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlBackgroundEdit: TPanel;
    PnlEdit: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CmbStatus: TComboBox;
    EdtNome: TEdit;
    EdtNumero: TEdit;
    EdtEstado: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtRua: TEdit;
    Label12: TLabel;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EdtCEP: TEdit;
    Image1: TImage;
    EdtRG: TMaskEdit;
    EdtCPF: TMaskEdit;
    EdtDataNascimento: TMaskEdit;
    EdtTelefone: TMaskEdit;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroFuncionarios: TFormCadastroFuncionarios;

implementation

{$R *.dfm}

procedure TFormCadastroFuncionarios.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgroundEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroFuncionarios.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgroundEdit.Visible := False;
  PnlEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroFuncionarios.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgroundEdit.Visible := false;
end;

procedure TFormCadastroFuncionarios.BtnRestaurarClick(Sender: TObject);
begin
 PnlRestaurar.Visible := True;
end;

procedure TFormCadastroFuncionarios.FormCreate(Sender: TObject);
begin
  CmbStatus.Height:= 31;
  CmbStatus.Font.Size:= 13;
end;

procedure TFormCadastroFuncionarios.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := false;
end;

end.
