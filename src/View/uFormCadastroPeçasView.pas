unit uFormCadastroPeçasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PeçasCadastroController, PeçasCadastroService, uPeçasDTO,
  Vcl.Imaging.pngimage;

type
  TFormCadastroPecas = class(TForm)
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
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlBackgrounEdit: TPanel;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LblStatus: TLabel;
    EdtCodigoInt: TEdit;
    EdtNome: TEdit;
    CmbUnidade: TComboBox;
    CmbCategoria: TComboBox;
    CmbModelo: TComboBox;
    CmbStatus: TComboBox;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    EdtDescrição: TEdit;

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
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure EditarPecas;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridPecas;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarGridClick(Sender: TObject);
    procedure RestaurarPecas;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroPecas: TFormCadastroPecas;

implementation

{$R *.dfm}

procedure TFormCadastroPecas.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := False;
  EdtNome.SetFocus;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormCadastroPecas.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroPecas.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormCadastroPecas.CarregarGrid;
var
  PecaService: TPecaService;
begin
  PecaService := TPecaService.Create;
  DataSourceMain.DataSet := PecaService.ListarPecas;
  DBGridMain.DataSource := DataSourceMain;
  try
    if DBGridMain.Columns.Count >= 7 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'Descrição';
      DBGridMain.Columns[3].Title.Caption := 'Código Interno';
      DBGridMain.Columns[4].Title.Caption := 'Categoria';
      DBGridMain.Columns[5].Title.Caption := 'Unidade';
      DBGridMain.Columns[6].Title.Caption := 'Modelo';
      DBGridMain.Columns[7].Title.Caption := 'Status';
      for var i := 0 to 7 do
      begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 120;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    PecaService.Free;
  end;
end;

procedure TFormCadastroPecas.CarregarGridRestaurar;
var
  PecaService: TPecaService;
begin
  PecaService := TPecaService.Create;
  DataSourceRestaurar.DataSet := PecaService.ListarPecasRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  try
    // Ajuste conforme necessário
    for var i := 0 to DBGridRestaurar.Columns.Count-1 do
    begin
      DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[i].Alignment := taCenter;
      DBGridRestaurar.Columns[i].Width := 120;
      DBGridRestaurar.Columns[i].Title.Font.Size := 15;
    end;
  finally
    PecaService.Free;
  end;
end;

procedure TFormCadastroPecas.EdtPesquisarChange(Sender: TObject);
var
  PecaService: TPecaService;
begin
  PecaService := TPecaService.Create;
  try
    DataSourceMain.DataSet := PecaService.PesquisarPecas(EdtPesquisar.Text);
    for var i := 0 to DBGridMain.Columns.Count-1 do
    begin
      DBGridMain.Columns[i].Width := 120;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;
  finally
    PecaService.Free;
  end;
end;

procedure TFormCadastroPecas.PegarCamposGridPecas;
begin
  EdtNome.Text         := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtDescrição.Text    := DBGridMain.DataSource.DataSet.FieldByName('descricao').AsString;
  EdtCodigoInt.Text:= DBGridMain.DataSource.DataSet.FieldByName('codigo_interno').AsString;
  CmbCategoria.Text    := DBGridMain.DataSource.DataSet.FieldByName('categoria').AsString;
  CmbUnidade.Text      := DBGridMain.DataSource.DataSet.FieldByName('unidade').AsString;
  CmbModelo.Text       := DBGridMain.DataSource.DataSet.FieldByName('modelo').AsString;
  CmbStatus.Text       := DBGridMain.DataSource.DataSet.FieldByName('status').AsString;
end;

procedure TFormCadastroPecas.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridPecas;
end;

procedure TFormCadastroPecas.BtnExcluirClick(Sender: TObject);
var
  PecaController: TPecaController;
  IdPeca: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma peça selecionada!');
    Exit;
  end;
  IdPeca := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar esta peça?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    PecaController := TPecaController.Create;
    PecaController.DeletarPeca(IdPeca);
    CarregarGrid;
    PecaController.Free;
  end;
end;

procedure TFormCadastroPecas.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarPecas;
    CarregarGrid;
  end;
end;

procedure TFormCadastroPecas.LblEnviarClick(Sender: TObject);
var
  PecaController: TPecaController;
  PecaDTO: TPecaDTO;
begin
  if ValidarCampos then
  begin
    PecaController := TPecaController.Create;
    try
      PecaDTO := PecaController.CriarObjeto(
        EdtNome.Text, EdtDescrição.Text, EdtCodigoInt.Text,
        CmbCategoria.Text, CmbUnidade.Text, CmbModelo.Text, CmbStatus.Text);
      PecaController.SalvarPeca(PecaDTO);
      LimparCampos;
      CarregarGrid;
      PecaDTO.Free;
    finally
      PecaController.Free;
    end;
  end;
end;

procedure TFormCadastroPecas.EditarPecas;
var
  PecaController: TPecaController;
  PecaDTO: TPecaDTO;
  IdPeca: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma peça selecionada!');
    Exit;
  end;
  IdPeca := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  PecaController := TPecaController.Create;
  try
    PecaDTO := TPecaDTO.Create;
    try
      ValidarCampos;
      PecaDTO.setIdPeca(IdPeca);
      PecaDTO.setNome(EdtNome.Text);
      PecaDTO.setDescricao(EdtDescrição.Text);
      PecaDTO.setCodigoInterno(EdtCodigoInt.Text);
      PecaDTO.setCategoria(CmbCategoria.Text);
      PecaDTO.setUnidade(CmbUnidade.Text);
      PecaDTO.setModelo(CmbModelo.Text);
      PecaDTO.setStatus(CmbStatus.Text);
      PecaController.EditarPeca(PecaDTO);
      CarregarGrid;
      LimparCampos;
    finally
      PecaDTO.Free;
    end;
  finally
    PecaController.Free;
  end;
end;

procedure TFormCadastroPecas.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroPecas.BtnRestaurarGridClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroPecas.RestaurarPecas;
var
  PecaController: TPecaController;
  IdPeca: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma peça selecionada!');
    Exit;
  end;
  IdPeca := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar esta peça?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    PecaController := TPecaController.Create;
    PecaController.RestaurarPeca(IdPeca);
    CarregarGridRestaurar;
    PecaController.Free;
  end;
end;

procedure TFormCadastroPecas.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarPecas;
  CarregarGridRestaurar;
end;

procedure TFormCadastroPecas.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroPecas.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormCadastroPecas.FormCreate(Sender: TObject);
begin
  CmbCategoria.Height := 31;
  CmbUnidade.Height := 31;
  CmbModelo.Height := 31;
  CmbStatus.Height := 31;
  EdtNome.Height := 31;
  EdtDescrição.Height := 31;
  EdtCodigoInt.Height := 31;
end;

procedure TFormCadastroPecas.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

function TFormCadastroPecas.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin ShowMessage('O campo Nome não pode ficar vazio'); Exit; end;
  if EdtDescrição.Text = '' then begin ShowMessage('O campo Descrição não pode ficar vazio'); Exit; end;
  if EdtCodigoInt.Text = '' then begin ShowMessage('O campo Código Interno não pode ficar vazio'); Exit; end;
  if CmbCategoria.Text = '' then begin ShowMessage('O campo Categoria não pode ficar vazio'); Exit; end;
  if CmbUnidade.Text = '' then begin ShowMessage('O campo Unidade não pode ficar vazio'); Exit; end;
  if CmbModelo.Text = '' then begin ShowMessage('O campo Modelo não pode ficar vazio'); Exit; end;
  if CmbStatus.Text = '' then begin ShowMessage('Selecione o Status'); Exit; end;
  Result := True;
end;

procedure TFormCadastroPecas.LimparCampos;
begin
  EdtNome.Clear;
  EdtDescrição.Clear;
  EdtCodigoInt.Clear;
  CmbCategoria.ItemIndex := -1;
  CmbUnidade.ItemIndex := -1;
  CmbModelo.ItemIndex := -1;
  CmbStatus.ItemIndex := -1;
end;

end.
