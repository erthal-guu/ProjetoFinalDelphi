unit uFormCadastroFornecedoresView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, FornecedorCadastroService, FornecedorCadastroController, uFornecedor;

type
  TFormCadastroFornecedores = class(TForm)
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
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlMainEdit: TPanel;
    PnlGrid: TPanel;
    EdtPesquisar: TSearchBox;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlBackgrounEdit: TPanel;
    DBGridMain: TDBGrid;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EdtRazaoSocial: TEdit;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtCNPJ: TMaskEdit;
    EdtNome: TEdit;
    EdtTelefone: TMaskEdit;
    EdtCEP: TMaskEdit;
    CmbStatus: TComboBox;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtEstado: TEdit;
    BtnVincularPeças: TSpeedButton;
    PnlVincularPeça: TPanel;
    ListBoxVincular: TListBox;
    Vincular: TPanel;
    LblVincular: TLabel;
    PnlHeaderVincular: TPanel;

    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    Function ValidarCampos:Boolean;
    procedure LimparCampos;
    procedure EditarFornecedores;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridFornecedores;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarGridClick(Sender: TObject);
    procedure RestaurarFornecedores;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BuscarCEP;
    procedure EdtCEPChange(Sender: TObject);
    procedure EdtTelefoneClick(Sender: TObject);
    procedure EdtCNPJClick(Sender: TObject);
    procedure EdtCEPClick(Sender: TObject);
    procedure BtnVincularPeçasClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroFornecedores: TFormCadastroFornecedores;

implementation

{$R *.dfm}

procedure TFormCadastroFornecedores.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlMainEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := False;
  PnlDesignEdit.Visible := True;
  EdtNome.SetFocus;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormCadastroFornecedores.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroFornecedores.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormCadastroFornecedores.CarregarGrid;
var
  FornecedorService: TFornecedorService;
begin
  FornecedorService := TFornecedorService.Create;
  DataSourceMain.DataSet := FornecedorService.ListarFornecedores;
  DBGridMain.DataSource := DataSourceMain;
  try
    if DBGridMain.Columns.Count >= 11 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'Razão Social';
      DBGridMain.Columns[3].Title.Caption := 'CNPJ';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'CEP';
      DBGridMain.Columns[6].Title.Caption := 'Rua';
      DBGridMain.Columns[7].Title.Caption := 'Número';
      DBGridMain.Columns[8].Title.Caption := 'Bairro';
      DBGridMain.Columns[9].Title.Caption := 'Estado';
      DBGridMain.Columns[10].Title.Caption := 'Ativo';
      for var i := 0 to 11 do begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    FornecedorService.Free;
  end;
end;

procedure TFormCadastroFornecedores.CarregarGridRestaurar;
var
  FornecedorService: TFornecedorService;
begin
  FornecedorService := TFornecedorService.Create;
  DataSourceRestaurar.DataSet := FornecedorService.ListarFornecedoresRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  try
    if DBGridRestaurar.Columns.Count >= 11 then
    begin
      for var i := 0 to 11 do begin
        DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
        DBGridRestaurar.Columns[i].Alignment := taCenter;
        DBGridRestaurar.Columns[i].Width := 120;
        DBGridRestaurar.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    FornecedorService.Free;
  end;
end;

procedure TFormCadastroFornecedores.EdtCEPChange(Sender: TObject);
begin
  BuscarCEP;
end;


procedure TFormCadastroFornecedores.EdtCEPClick(Sender: TObject);
begin
  EdtCEP.SelStart := 0;
end;


procedure TFormCadastroFornecedores.EdtCNPJClick(Sender: TObject);
begin
  EdtCNPJ.SelStart := 0;
end;

procedure TFormCadastroFornecedores.EdtPesquisarChange(Sender: TObject);
var
  FornecedorService: TFornecedorService;
begin
  FornecedorService := TFornecedorService.Create;
  try
    DataSourceMain.DataSet := FornecedorService.PesquisarFornecedores(EdtPesquisar.Text);
    for var i := 0 to DBGridMain.Columns.Count-1 do
    begin
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size :=15;
    end;
  finally
    FornecedorService.Free;
  end;
end;


procedure TFormCadastroFornecedores.EdtTelefoneClick(Sender: TObject);
begin
  EdtTelefone.SelStart := 0;
end;

procedure TFormCadastroFornecedores.PegarCamposGridFornecedores;
begin
  EdtNome.Text         := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtRazaoSocial.Text  := DBGridMain.DataSource.DataSet.FieldByName('razao_social').AsString;
  EdtCNPJ.Text         := DBGridMain.DataSource.DataSet.FieldByName('cnpj').AsString;
  EdtTelefone.Text     := DBGridMain.DataSource.DataSet.FieldByName('telefone').AsString;
  EdtCEP.Text          := DBGridMain.DataSource.DataSet.FieldByName('cep').AsString;
  EdtRua.Text          := DBGridMain.DataSource.DataSet.FieldByName('rua').AsString;
  EdtNumero.Text       := DBGridMain.DataSource.DataSet.FieldByName('numero').AsString;
  EdtBairro.Text       := DBGridMain.DataSource.DataSet.FieldByName('bairro').AsString;
  EdtCidade.Text       := DBGridMain.DataSource.DataSet.FieldByName('cidade').AsString;
  EdtEstado.Text       := DBGridMain.DataSource.DataSet.FieldByName('estado').AsString;
  if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then
    CmbStatus.ItemIndex := 0
  else
    CmbStatus.ItemIndex := 1;
end;

procedure TFormCadastroFornecedores.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridFornecedores;
end;

procedure TFormCadastroFornecedores.BtnExcluirClick(Sender: TObject);
var
  FornecedorController: TFornecedorController;
  IdFornecedor: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum fornecedor selecionado!');
    Exit;
  end;
  IdFornecedor := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar este fornecedor?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FornecedorController := TFornecedorController.Create;
    FornecedorController.DeletarFornecedor(IdFornecedor);
    CarregarGrid;
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarFornecedores;
    CarregarGrid;
  end;
end;

procedure TFormCadastroFornecedores.LblEnviarClick(Sender: TObject);
var
  FornecedorController: TFornecedorController;
  FornecedorDTO: TFornecedor;
begin
  if ValidarCampos then
  begin
    FornecedorController := TFornecedorController.Create;
    try
      FornecedorDTO := FornecedorController.CriarObjeto(
        EdtNome.Text, EdtRazaoSocial.Text, EdtCNPJ.Text, EdtTelefone.Text,
        EdtCEP.Text, EdtRua.Text, EdtNumero.Text,
        EdtBairro.Text, EdtCidade.Text, EdtEstado.Text, CmbStatus.ItemIndex = 0);
      FornecedorController.SalvarFornecedor(FornecedorDTO);
      LimparCampos;
      CarregarGrid;
      FornecedorDTO.Free;
    finally
      FornecedorController.Free;
    end;
  end;
end;

procedure TFormCadastroFornecedores.EditarFornecedores;
var
  FornecedorController: TFornecedorController;
  Fornecedor: TFornecedor;
  IdFornecedor: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum fornecedor selecionado!');
    Exit;
  end;
  IdFornecedor := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  FornecedorController := TFornecedorController.Create;
  try
    Fornecedor := TFornecedor.Create;
    try
      ValidarCampos;
      Fornecedor.setIdFornecedor(IdFornecedor);
      Fornecedor.setNome(EdtNome.Text);
      Fornecedor.setRazaoSocial(EdtRazaoSocial.Text);
      Fornecedor.setCNPJ(EdtCNPJ.Text);
      Fornecedor.setTelefone(EdtTelefone.Text);
      Fornecedor.setCEP(EdtCEP.Text);
      Fornecedor.setRua(EdtRua.Text);
      Fornecedor.setNumero(EdtNumero.Text);
      Fornecedor.setBairro(EdtBairro.Text);
      Fornecedor.setCidade(EdtCidade.Text);
      Fornecedor.setEstado(EdtEstado.Text);
      Fornecedor.setAtivo(CmbStatus.ItemIndex = 0);
      FornecedorController.EditarFornecedor(Fornecedor);
      CarregarGrid;
      LimparCampos;
    finally
      Fornecedor.Free;
    end;
  finally
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroFornecedores.BtnRestaurarGridClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroFornecedores.RestaurarFornecedores;
var
  FornecedorController: TFornecedorController;
  IdFornecedor: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum fornecedor selecionado!');
    Exit;
  end;
  IdFornecedor := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar este fornecedor?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FornecedorController := TFornecedorController.Create;
    FornecedorController.RestaurarFornecedor(IdFornecedor);
    CarregarGridRestaurar;
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarFornecedores;
  CarregarGridRestaurar;
end;

procedure TFormCadastroFornecedores.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroFornecedores.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormCadastroFornecedores.BtnVincularPeçasClick(Sender: TObject);
begin
  PnlVincularPeça.Visible := True;
end;

procedure TFormCadastroFornecedores.BuscarCEP;
var
  Rua, Bairro, Cidade, Estado: string;
  FornecedorService: TFornecedorService;
begin
  FornecedorService := TFornecedorService.Create;
  try
    try
      FornecedorService.BuscarCep(EdtCEP.Text, Rua, Bairro, Cidade, Estado);
      EdtRua.Text    := Rua;
      EdtBairro.Text := Bairro;
      EdtCidade.Text := Cidade;
      EdtEstado.Text := Estado;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    FornecedorService.Free;
  end;
end;

procedure TFormCadastroFornecedores.FormCreate(Sender: TObject);
begin
  CmbStatus.Height := 31;
  CmbStatus.Font.Size := 13;
  EdtNome.Height := 31; EdtRazaoSocial.Height := 31; EdtCNPJ.Height := 31;
  EdtTelefone.Height := 31; EdtCEP.Height := 31;
  EdtRua.Height := 31; EdtNumero.Height := 31;
  EdtBairro.Height := 31; EdtCidade.Height := 31; EdtEstado.Height := 31;
end;

procedure TFormCadastroFornecedores.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

function TFormCadastroFornecedores.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin ShowMessage('O campo Nome não pode ficar vazio'); Exit; end;
  if EdtRazaoSocial.Text = '' then begin ShowMessage('O campo Razão Social não pode ficar vazio'); Exit; end;
  if EdtCNPJ.Text = '' then begin ShowMessage('O campo CNPJ não pode ficar vazio'); Exit; end;
  if EdtTelefone.Text = '' then begin ShowMessage('O campo Telefone não pode ficar vazio'); Exit; end;
  if EdtCEP.Text = '' then begin ShowMessage('O campo CEP não pode ficar vazio'); Exit; end;
  if EdtRua.Text = '' then begin ShowMessage('O campo Rua não pode ficar vazio'); Exit; end;
  if EdtNumero.Text = '' then begin ShowMessage('O campo Número não pode ficar vazio'); Exit; end;
  if EdtBairro.Text = '' then begin ShowMessage('O campo Bairro não pode ficar vazio'); Exit; end;
  if EdtCidade.Text = '' then begin ShowMessage('O campo Cidade não pode ficar vazio'); Exit; end;
  if EdtEstado.Text = '' then begin ShowMessage('O campo Estado não pode ficar vazio'); Exit; end;
  if CmbStatus.ItemIndex = -1 then begin ShowMessage('Selecione o Status'); Exit; end;
  Result := True;
end;

procedure TFormCadastroFornecedores.LimparCampos;
begin
  EdtNome.Clear; EdtRazaoSocial.Clear; EdtCNPJ.Clear; EdtEstado.Clear; EdtTelefone.Clear; EdtBairro.Clear;
  EdtCidade.Clear; EdtRua.Clear; EdtNumero.Clear; EdtCEP.Clear; CmbStatus.ItemIndex := -1;
end;

end.
