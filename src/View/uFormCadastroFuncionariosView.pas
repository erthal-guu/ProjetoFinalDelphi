unit uFormCadastroFuncionariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, FuncionarioCadastroService, FuncionarioCadastroController, uFuncionarioDTO;

type
  TFormCadastroFuncionarios = class(TForm)
    Panel1: TPanel;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
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
    PnlMainEdit: TPanel;
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
    Label12: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    CmbStatus: TComboBox;
    EdtNome: TEdit;
    EdtNumero: TEdit;
    EdtEstado: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtRua: TEdit;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtCEP: TEdit;
    EdtRG: TMaskEdit;
    EdtCPF: TMaskEdit;
    EdtDataNascimento: TMaskEdit;
    EdtTelefone: TMaskEdit;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtCPFClick(Sender: TObject);
    procedure EdtRGClick(Sender: TObject);
    procedure EdtDataNascimentoClick(Sender: TObject);
    procedure EdtTelefoneClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);

    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    Function ValidarCampos:Boolean;
    procedure LimparCampos;
    procedure EditarFuncionarios;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridFuncionarios;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarGridClick(Sender: TObject);
    procedure RestaurarFuncionarios;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

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
  EdtNome.SetFocus;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
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
  PnlBackgroundEdit.Visible := False;
end;

procedure TFormCadastroFuncionarios.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroFuncionarios.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este Formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormCadastroFuncionarios.EdtCPFClick(Sender: TObject);
begin
  EdtCPF.SelStart := 0;
end;

procedure TFormCadastroFuncionarios.EdtDataNascimentoClick(Sender: TObject);
begin
  EdtDataNascimento.SelStart := 0;
end;

procedure TFormCadastroFuncionarios.EdtRGClick(Sender: TObject);
begin
  EdtRG.SelStart := 0;
end;

procedure TFormCadastroFuncionarios.EdtTelefoneClick(Sender: TObject);
begin
  EdtTelefone.SelStart := 0;
end;

procedure TFormCadastroFuncionarios.FormCreate(Sender: TObject);
begin
  CmbStatus.Height := 31;
  CmbStatus.Font.Size := 13;
  EdtNome.Height := 31; EdtCPF.Height := 31; EdtRG.Height := 31;
  EdtDataNascimento.Height := 31; EdtTelefone.Height := 31; EdtCEP.Height := 31;
  EdtRua.Height := 31; EdtNumero.Height := 31;
  EdtBairro.Height := 31; EdtCidade.Height := 31; EdtEstado.Height := 31;
end;

procedure TFormCadastroFuncionarios.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

procedure TFormCadastroFuncionarios.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

function TFormCadastroFuncionarios.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin ShowMessage('O Campo de NOME não pode ficar Vazio'); Exit; end;
  if EdtCPF.Text = '' then begin ShowMessage('O Campo de CPF não pode ficar Vazio'); Exit; end;
  if EdtRG.Text = '' then begin ShowMessage('O Campo de RG não pode ficar Vazio'); Exit; end;
  if EdtDataNascimento.Text = '' then begin ShowMessage('O Campo de NASCIMENTO não pode ficar Vazio'); Exit; end;
  if EdtTelefone.Text = '' then begin ShowMessage('O Campo de TELEFONE não pode ficar Vazio'); Exit; end;
  if EdtCEP.Text = '' then begin ShowMessage('O Campo de CEP não pode ficar Vazio'); Exit; end;
  if EdtRua.Text = '' then begin ShowMessage('O Campo de RUA não pode ficar Vazio'); Exit; end;
  if EdtNumero.Text = '' then begin ShowMessage('O Campo de NÚMERO não pode ficar Vazio'); Exit; end;
  if EdtBairro.Text = '' then begin ShowMessage('O Campo de BAIRRO não pode ficar Vazio'); Exit; end;
  if EdtCidade.Text = '' then begin ShowMessage('O Campo de CIDADE não pode ficar Vazio'); Exit; end;
  if EdtEstado.Text = '' then begin ShowMessage('O Campo de ESTADO não pode ficar Vazio'); Exit; end;
  if CmbStatus.ItemIndex = -1 then begin ShowMessage('Selecione o STATUS'); Exit; end;
  Result := True;
end;

procedure TFormCadastroFuncionarios.LimparCampos;
begin
  EdtNome.Clear; EdtCPF.Clear; EdtRG.Clear; EdtEstado.Clear; EdtTelefone.Clear; EdtBairro.Clear;
  EdtCidade.Clear; EdtRua.Clear; EdtNumero.Clear; EdtCEP.Clear; EdtDataNascimento.Clear; CmbStatus.ItemIndex := -1;
end;

procedure TFormCadastroFuncionarios.CarregarGrid;
var
  FuncionarioService: TFuncionarioService;
begin
  FuncionarioService := TFuncionarioService.Create;
  DataSourceMain.DataSet := FuncionarioService.ListarFuncionarios;
  DBGridMain.DataSource := DataSourceMain;
  try
    if DBGridMain.Columns.Count >= 13 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'RG';
      DBGridMain.Columns[4].Title.Caption := 'Nascimento';
      DBGridMain.Columns[5].Title.Caption := 'Telefone';
      DBGridMain.Columns[6].Title.Caption := 'CEP';
      DBGridMain.Columns[7].Title.Caption := 'Rua';
      DBGridMain.Columns[8].Title.Caption := 'Número';
      DBGridMain.Columns[9].Title.Caption := 'Bairro';
      DBGridMain.Columns[10].Title.Caption := 'Cidade';
      DBGridMain.Columns[11].Title.Caption := 'Estado';
      DBGridMain.Columns[12].Title.Caption := 'Ativo';

      for var i := 0 to 12 do begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 120;
      end;
    end;
  finally
    FuncionarioService.Free;
  end;
end;

procedure TFormCadastroFuncionarios.CarregarGridRestaurar;
var
  FuncionarioService: TFuncionarioService;
begin
  FuncionarioService := TFuncionarioService.Create;
  DataSourceRestaurar.DataSet := FuncionarioService.ListarFuncionariosRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  try
    if DBGridRestaurar.Columns.Count >= 13 then
    begin
      for var i := 0 to 12 do begin
        DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
        DBGridRestaurar.Columns[i].Alignment := taCenter;
        DBGridRestaurar.Columns[i].Width := 120;
      end;
    end;
  finally
    FuncionarioService.Free;
  end;
end;

procedure TFormCadastroFuncionarios.EdtPesquisarChange(Sender: TObject);
var
  FuncionarioService: TFuncionarioService;
begin
  FuncionarioService := TFuncionarioService.Create;
  try
    DataSourceMain.DataSet := FuncionarioService.PesquisarFuncionarios(EdtPesquisar.Text);
    for var i := 0 to DBGridMain.Columns.Count-1 do
    begin
      DBGridMain.Columns[i].Width := 120;
    end;
  finally
    FuncionarioService.Free;
  end;
end;

procedure TFormCadastroFuncionarios.PegarCamposGridFuncionarios;
begin
  EdtNome.Text          := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtCPF.Text           := DBGridMain.DataSource.DataSet.FieldByName('cpf').AsString;
  EdtRG.Text            := DBGridMain.DataSource.DataSet.FieldByName('rg').AsString;
  EdtDataNascimento.Text:= DBGridMain.DataSource.DataSet.FieldByName('nascimento').AsString;
  EdtTelefone.Text      := DBGridMain.DataSource.DataSet.FieldByName('telefone').AsString;
  EdtCEP.Text           := DBGridMain.DataSource.DataSet.FieldByName('cep').AsString;
  EdtRua.Text           := DBGridMain.DataSource.DataSet.FieldByName('rua').AsString;
  EdtNumero.Text        := DBGridMain.DataSource.DataSet.FieldByName('numero').AsString;
  EdtBairro.Text        := DBGridMain.DataSource.DataSet.FieldByName('bairro').AsString;
  EdtCidade.Text        := DBGridMain.DataSource.DataSet.FieldByName('cidade').AsString;
  EdtEstado.Text        := DBGridMain.DataSource.DataSet.FieldByName('estado').AsString;

  if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then
    CmbStatus.ItemIndex := 0
  else
    CmbStatus.ItemIndex := 1;
end;

procedure TFormCadastroFuncionarios.BtnEditarClick(Sender: TObject);
begin
  PnlBackgroundEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridFuncionarios;
end;

procedure TFormCadastroFuncionarios.BtnExcluirClick(Sender: TObject);
var
  FuncionarioController: TFuncionarioController;
  IdFuncionario: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum funcionário selecionado!');
    Exit;
  end;
  IdFuncionario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar este funcionário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FuncionarioController := TFuncionarioController.Create;
    FuncionarioController.DeletarFuncionario(IdFuncionario);
    CarregarGrid;
    FuncionarioController.Free;
  end;
end;

procedure TFormCadastroFuncionarios.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarFuncionarios;
    CarregarGrid;
  end;
end;

procedure TFormCadastroFuncionarios.LblEnviarClick(Sender: TObject);
var
  FuncionarioController: TFuncionarioController;
  FuncionarioDTO: TFuncionarioDTO;
begin
  if ValidarCampos then
  begin
    FuncionarioController := TFuncionarioController.Create;
    try
      FuncionarioDTO := FuncionarioController.CriarObjeto(
        EdtNome.Text, EdtCPF.Text, EdtRG.Text, EdtDataNascimento.Text,
        EdtTelefone.Text, EdtCEP.Text, EdtRua.Text, EdtNumero.Text,
        EdtBairro.Text, EdtCidade.Text, EdtEstado.Text, CmbStatus.ItemIndex = 0);
      FuncionarioController.SalvarFuncionario(FuncionarioDTO);
      LimparCampos;
      CarregarGrid;
      FuncionarioDTO.Free;
    finally
      FuncionarioController.Free;
    end;
  end;
end;

procedure TFormCadastroFuncionarios.EditarFuncionarios;
var
  FuncionarioController: TFuncionarioController;
  FuncionarioDTO: TFuncionarioDTO;
  IdFuncionario: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum funcionário selecionado!');
    Exit;
  end;
  IdFuncionario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  FuncionarioController := TFuncionarioController.Create;
  try
    FuncionarioDTO := TFuncionarioDTO.Create;
    try
      ValidarCampos;
      FuncionarioDTO.setIdFuncionario(IdFuncionario);
      FuncionarioDTO.setNome(EdtNome.Text);
      FuncionarioDTO.setCPF(EdtCPF.Text);
      FuncionarioDTO.setRG(EdtRG.Text);
      FuncionarioDTO.setNascimento(EdtDataNascimento.Text);
      FuncionarioDTO.setTelefone(EdtTelefone.Text);
      FuncionarioDTO.setCEP(EdtCEP.Text);
      FuncionarioDTO.setRua(EdtRua.Text);
      FuncionarioDTO.setNumero(EdtNumero.Text);
      FuncionarioDTO.setBairro(EdtBairro.Text);
      FuncionarioDTO.setCidade(EdtCidade.Text);
      FuncionarioDTO.setEstado(EdtEstado.Text);
      FuncionarioDTO.setAtivo(CmbStatus.ItemIndex = 0);
      FuncionarioController.EditarFuncionario(FuncionarioDTO);
      CarregarGrid;
      LimparCampos;
    finally
      FuncionarioDTO.Free;
    end;
  finally
    FuncionarioController.Free;
  end;
end;

procedure TFormCadastroFuncionarios.BtnRestaurarGridClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroFuncionarios.RestaurarFuncionarios;
var
  FuncionarioController: TFuncionarioController;
  IdFuncionario: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum funcionário selecionado!');
    Exit;
  end;
  IdFuncionario := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente Restaurar este funcionário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FuncionarioController := TFuncionarioController.Create;
    FuncionarioController.RestaurarFuncionario(IdFuncionario);
    CarregarGridRestaurar;
    FuncionarioController.Free;
  end;
end;

procedure TFormCadastroFuncionarios.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarFuncionarios;
  CarregarGridRestaurar;
end;

end.
