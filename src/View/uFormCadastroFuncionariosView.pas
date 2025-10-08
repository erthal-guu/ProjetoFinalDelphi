unit uFormCadastroFuncionariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls,TFuncionarioDTO,FuncionarioCadastroController;

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
    PnlButtonAtualizar: TPanel;
    Label13: TLabel;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    function ValidarCampos : Boolean;
    procedure LblEnviarClick(Sender: TObject);
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

procedure TFormCadastroFuncionarios.BtnSairClick(Sender: TObject);
  begin
  if MessageDlg('Deseja realmente fechar este Formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FormCadastroFuncionarios.close;
  end;
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

//procedure TFormCadastroFuncionarios.LblEnviarClick(Sender: TObject);
//  var
//    FuncionarioController: TFuncionarioController;
//    FuncionarioDTO: TFuncionarioDTO;
//begin
//    if ValidarCampos then begin
//    FuncionarioController := TFuncionarioController.Create;
//end;
//end;

function TFormCadastroFuncionarios.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then
  begin
    ShowMessage('O Campo de NOME não pode ficar Vazio');
    Exit;
  end;
  if EdtCPF.Text = '' then
  begin
    ShowMessage('O Campo de CPF não pode ficar Vazio');
    Exit;
  end;
  if EdtRG.Text = '' then
  begin
    ShowMessage('O Campo de RG não pode ficar Vazio');
    Exit;
  end;
  if EdtDataNascimento.Text = '' then
  begin
    ShowMessage('O Campo de NASCIMENTO não pode ficar Vazio');
    Exit;
  end;
  if EdtTelefone.Text = '' then
  begin
    ShowMessage('O Campo de TELEFONE não pode ficar Vazio');
    Exit;
  end;
  if EdtCEP.Text = '' then
  begin
    ShowMessage('O Campo de CEP não pode ficar Vazio');
    Exit;
  end;
  if EdtRua.Text = '' then
  begin
    ShowMessage('O Campo de RUA não pode ficar Vazio');
    Exit;
  end;
  if EdtNumero.Text = '' then
  begin
    ShowMessage('O Campo de NÚMERO não pode ficar Vazio');
    Exit;
  end;
  if EdtBairro.Text = '' then
  begin
    ShowMessage('O Campo de BAIRRO não pode ficar Vazio');
    Exit;
  end;
  if EdtCidade.Text = '' then
  begin
    ShowMessage('O Campo de CIDADE não pode ficar Vazio');
    Exit;
  end;
  if EdtEstado.Text = '' then
  begin
    ShowMessage('O Campo de ESTADO não pode ficar Vazio');
    Exit;
  end;

  if CmbStatus.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o STATUS');
    Exit;
  end;

  Result := True;
end;

end.
