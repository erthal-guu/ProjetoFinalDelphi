unit uFormCadastroPe�asView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Pe�asCadastroController, Pe�asCadastroService, uPe�as,
  Vcl.Imaging.pngimage;

type
  TFormCadastroPecas = class(TForm)
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
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
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    EdtDescri��o: TEdit;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    CmbStatus: TComboBox;
    EdtPre�o: TEdit;
    Label7: TLabel;

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
    procedure CarregarCategorias;

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
    if DBGridMain.Columns.Count >= 8 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'Descri��o';
      DBGridMain.Columns[3].Title.Caption := 'C�digo Interno';
      DBGridMain.Columns[4].Title.Caption := 'Categoria';
      DBGridMain.Columns[5].Title.Caption := 'Pre�o';
      DBGridMain.Columns[6].Title.Caption := 'Unidade';
      DBGridMain.Columns[7].Title.Caption := 'Modelo';
      DBGridMain.Columns[8].Title.Caption := 'Status';
      for var i := 0 to 8 do
      begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
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
    for var i := 0 to 7 do
    begin
      DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[i].Alignment := taCenter;
      DBGridRestaurar.Columns[i].Width := 140;
      DBGridRestaurar.Columns[i].Title.Font.Size := 15;
    end;
    DBGridRestaurar.Columns[0].Width := 40;
  finally
    PecaService.Free;
  end;
end;

procedure TFormCadastroPecas.CarregarCategorias;
var
  Pe�aController: TPecaController;
  ListaCategorias: TStringList;
  i: Integer;
begin
  CmbCategoria.Items.Clear;
  Pe�aController := TPecaController.Create;
  try
    ListaCategorias := Pe�aController.CarregarCategorias;
    try
      for i := 0 to ListaCategorias.Count - 1 do
        CmbCategoria.Items.AddObject(ListaCategorias[i], ListaCategorias.Objects[i]);
      CmbCategoria.ItemIndex := -1;
    finally
      ListaCategorias.Free;
    end;
  finally
    Pe�aController.Free;
  end;
end;

procedure TFormCadastroPecas.EdtPesquisarChange(Sender: TObject);
var
  PecaService: TPecaService;
begin
  PecaService := TPecaService.Create;
  try
    DataSourceMain.DataSet := PecaService.PesquisarPecas(EdtPesquisar.Text);
    for var i := 0 to 7 do
    begin
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;
    DBGridRestaurar.Columns[0].Width := 40;
  finally
    PecaService.Free;
  end;
end;

procedure TFormCadastroPecas.PegarCamposGridPecas;
var
  pre�o: Currency;
  CategoriaNome: String;
  i: Integer;
begin
  try
    EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('Nome').AsString;
    EdtDescri��o.Text := DBGridMain.DataSource.DataSet.FieldByName('Descri��o').AsString;
    EdtCodigoInt.Text := DBGridMain.DataSource.DataSet.FieldByName('C�digo interno').AsString;
    CategoriaNome := DBGridMain.DataSource.DataSet.FieldByName('Categoria').AsString;
    for i := 0 to CmbCategoria.Items.Count - 1 do
    begin
      if CmbCategoria.Items[i] = CategoriaNome then
      begin
        CmbCategoria.ItemIndex := i;
        Break;
      end;
    end;
    pre�o := DBGridMain.DataSource.DataSet.FieldByName('Pre�o').AsCurrency;
    EdtPre�o.Text := CurrToStr(pre�o);

    CmbUnidade.Text := DBGridMain.DataSource.DataSet.FieldByName('Unidade').AsString;
    CmbModelo.Text := DBGridMain.DataSource.DataSet.FieldByName('Modelo').AsString;
    CmbStatus.Text := DBGridMain.DataSource.DataSet.FieldByName('Ativo').AsString;

  except
    on E: Exception do
      ShowMessage('Erro ao carregar dados: ' + E.Message);
  end;
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
    ShowMessage('Nenhuma pe�a selecionada!');
    Exit;
  end;
  IdPeca := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar esta pe�a?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
  Peca: TPeca;
  Ativo: Boolean;
  preco: Currency;
  IdCategoria: Integer;
begin
  if ValidarCampos then
  begin
    PecaController := TPecaController.Create;
    try
      Ativo := (CmbStatus.Text = 'Ativo');
      preco := StrToCurr(EdtPre�o.Text);

      if CmbCategoria.ItemIndex >= 0 then
        IdCategoria := Integer(CmbCategoria.Items.Objects[CmbCategoria.ItemIndex])
      else
      begin
        ShowMessage('Selecione uma categoria v�lida!');
        Exit;
      end;

      Peca := PecaController.CriarObjeto(
        EdtNome.Text,
        EdtDescri��o.Text,
        EdtCodigoInt.Text,
        IdCategoria,
        CmbUnidade.Text,
        CmbModelo.Text,
        Ativo,
        preco
      );

      try
        PecaController.SalvarPeca(Peca);
        ShowMessage('Pe�a cadastrada com sucesso!');
        LimparCampos;
        CarregarGrid;
      finally
        Peca.Free;
      end;

    finally
      PecaController.Free;
    end;
  end;
end;

procedure TFormCadastroPecas.EditarPecas;
var
  PecaController: TPecaController;
  Peca: TPeca;
  IdPeca: Integer;
  IdCategoria: Integer;
  Ativo: Boolean;
  Preco: Currency;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma pe�a selecionada!');
    Exit;
  end;

  IdPeca := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  PecaController := TPecaController.Create;
  try
    Peca := TPeca.Create;
    try
      if not ValidarCampos then
        Exit;
      if CmbCategoria.ItemIndex >= 0 then
        IdCategoria := Integer(CmbCategoria.Items.Objects[CmbCategoria.ItemIndex])
      else
      begin
        ShowMessage('Selecione uma categoria v�lida!');
        Exit;
      end;

      Ativo := (CmbStatus.Text = 'Ativo');
      Preco := StrToCurr(EdtPre�o.Text);

      Peca.setIdPeca(IdPeca);
      Peca.setNome(EdtNome.Text);
      Peca.setDescricao(EdtDescri��o.Text);
      Peca.setCodigoInterno(EdtCodigoInt.Text);
      Peca.setCategoria(IdCategoria);
      Peca.setUnidade(CmbUnidade.Text);
      Peca.setModelo(CmbModelo.Text);
      Peca.setAtivo(Ativo);
      Peca.setPre�o(Preco);

      PecaController.EditarPeca(Peca);
      ShowMessage('Pe�a atualizada com sucesso!');
      CarregarGrid;
      LimparCampos;
      PnlBackgrounEdit.Visible := False;
      PnlEdit.Visible := False;
    finally
      Peca.Free;
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
    ShowMessage('Nenhuma pe�a selecionada!');
    Exit;
  end;
  IdPeca := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar esta pe�a?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
  if MessageDlg('Deseja realmente fechar este formul�rio?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormCadastroPecas.FormCreate(Sender: TObject);
begin
  CmbCategoria.Height := 31;
  CmbUnidade.Height := 31;
  CmbModelo.Height := 31;
  CmbStatus.Height := 31;
  EdtNome.Height := 31;
  EdtDescri��o.Height := 31;
  EdtCodigoInt.Height := 31;
end;

procedure TFormCadastroPecas.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarCategorias;
end;

function TFormCadastroPecas.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin ShowMessage('O campo Nome n�o pode ficar vazio'); Exit; end;
  if EdtPre�o.Text = '' then begin ShowMessage('O campo Pre�o n�o pode ficar vazio'); Exit; end;
  if EdtDescri��o.Text = '' then begin ShowMessage('O campo Descri��o n�o pode ficar vazio'); Exit; end;
  if EdtCodigoInt.Text = '' then begin ShowMessage('O campo C�digo Interno n�o pode ficar vazio'); Exit; end;
  if CmbCategoria.ItemIndex = -1 then begin ShowMessage('Selecione uma Categoria v�lida'); Exit; end;
  if CmbUnidade.Text = '' then begin ShowMessage('O campo Unidade n�o pode ficar vazio'); Exit; end;
  if CmbModelo.Text = '' then begin ShowMessage('O campo Modelo n�o pode ficar vazio'); Exit; end;
  if CmbStatus.Text = '' then begin ShowMessage('Selecione o Status'); Exit; end;
  Result := True;
end;

procedure TFormCadastroPecas.LimparCampos;
begin
  EdtNome.Clear;
  EdtDescri��o.Clear;
  EdtCodigoInt.Clear;
  EdtPre�o.Clear;
  CmbCategoria.ItemIndex := -1;
  CmbUnidade.ItemIndex := -1;
  CmbModelo.ItemIndex := -1;
  CmbStatus.ItemIndex := -1;
end;

end.
