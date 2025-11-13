unit uFormCadastroServiçosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls,
  ServiçoCadastroController, uServiço;

type
  TFormCadastroServiços = class(TForm)
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
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
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    EdtNome: TEdit;
    EdtObs: TEdit;
    CmbProfissional: TComboBox;
    EdtPreço: TEdit;
    CmbCategoria: TComboBox;
    CmbPeças: TComboBox;
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
    Image1: TImage;
    Label7: TLabel;
    ImgFecharForm: TImage;
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    Image6: TImage;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    Image2: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure BtnRestaurarGridClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure LblAtualizarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    procedure CarregarCategorias;
    procedure CarregarPecas;
    procedure CarregarProfissionais;
    procedure PegarCamposGridServicos;
    procedure EditarServicos;
    procedure RestaurarServicos;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure TituloGridRestaurar;
    procedure TituloGridMain;
    procedure ExcluirServicos;
    procedure CadastrarServicos;
    procedure ImgFecharFormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroServiços: TFormCadastroServiços;

implementation

{$R *.dfm}

procedure TFormCadastroServiços.FormCreate(Sender: TObject);
begin
  EdtObs.Height := 31;
  EdtNome.Height := 31;
  EdtPreço.Height := 31;
  CmbCategoria.Height := 31;
  CmbProfissional.Height := 31;
  CmbPeças.Height := 31;
  CmbPeças.Font.Size := 13;
  CmbProfissional.Font.Size := 13;
  CmbCategoria.Font.Size := 13;
end;

procedure TFormCadastroServiços.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarCategorias;
  CarregarPecas;
  CarregarProfissionais;
end;

procedure TFormCadastroServiços.LimparCampos;
begin
  EdtNome.Clear;
  EdtObs.Clear;
  EdtPreço.Clear;
  CmbCategoria.ItemIndex := -1;
  CmbProfissional.ItemIndex := -1;
  CmbPeças.ItemIndex := -1;
end;

function TFormCadastroServiços.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin
    ShowMessage('O campo Nome não pode ficar vazio');
    Exit(False);
  end;
  if EdtPreço.Text = '' then begin
    ShowMessage('O campo Preço não pode ficar vazio');
    Exit(False);
  end;
  if CmbCategoria.ItemIndex = -1 then begin
    ShowMessage('Selecione uma Categoria');
    Exit(False);
  end;
  if CmbPeças.ItemIndex = -1 then begin
    ShowMessage('Selecione uma Peça');
    Exit(False);
  end;
  if CmbProfissional.ItemIndex = -1 then begin
    ShowMessage('Selecione um Profissional');
    Exit(False);
  end;
  Result := True;
end;

procedure TFormCadastroServiços.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormCadastroServiços.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormCadastroServiços.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroServiços.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridServicos;
end;

procedure TFormCadastroServiços.PegarCamposGridServicos;
var
  Categoria, Pecas, Funcionario: Integer;
  CategoriaStr, PecasStr, FuncionarioStr: String;
  i: Integer;
begin
  EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtObs.Text := DBGridMain.DataSource.DataSet.FieldByName
    ('observacao').AsString;
  EdtPreço.Text := CurrToStr(DBGridMain.DataSource.DataSet.FieldByName('preco')
    .AsCurrency);

  CategoriaStr := DBGridMain.DataSource.DataSet.FieldByName
    ('categoria_nome').AsString;
  for i := 0 to CmbCategoria.Items.Count - 1 do
    if Integer(CmbCategoria.Items.Objects[i]) = Categoria then
      CmbCategoria.ItemIndex := i;

  PecasStr := DBGridMain.DataSource.DataSet.FieldByName('peca_nome').AsString;
  for i := 0 to CmbPeças.Items.Count - 1 do
    if Integer(CmbPeças.Items.Objects[i]) = Pecas then
      CmbPeças.ItemIndex := i;

  FuncionarioStr := DBGridMain.DataSource.DataSet.FieldByName
    ('funcionario_nome').AsString;
  for i := 0 to CmbProfissional.Items.Count - 1 do
    if Integer(CmbProfissional.Items.Objects[i]) = Funcionario then
      CmbProfissional.ItemIndex := i;
end;

procedure TFormCadastroServiços.LblEnviarClick(Sender: TObject);
begin
  if ValidarCampos then begin
    CadastrarServicos;
    LimparCampos;
    CarregarGrid;
    ShowMessage('Serviço Cadastrado com sucesso!');
  end;
end;

procedure TFormCadastroServiços.EditarServicos;
var
  ServicoController: TServicoController;
  Servico: TServico;
  IdServico, Categoria, Pecas, Profissional: Integer;
  Preco: Currency;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhum serviço selecionado!');
    Exit;
  end;
  IdServico := DataSourceMain.DataSet.FieldByName('id').AsInteger;
  Categoria := Integer(CmbCategoria.Items.Objects[CmbCategoria.ItemIndex]);
  Pecas := Integer(CmbPeças.Items.Objects[CmbPeças.ItemIndex]);
  Profissional := Integer(CmbProfissional.Items.Objects
    [CmbProfissional.ItemIndex]);
  Preco := StrToCurr(EdtPreço.Text);

  Servico := TServico.Create;
  try
    Servico.SetId(IdServico);
    Servico.SetNome(EdtNome.Text);
    Servico.SetCategoria(Categoria);
    Servico.SetPreco(Preco);
    Servico.SetObservacao(EdtObs.Text);
    Servico.SetPecas(Pecas);
    Servico.SetProfissional(Profissional);

    ServicoController := TServicoController.Create;
    try
      if ServicoController.EditarServico(Servico) then begin
        ShowMessage('Serviço atualizado com sucesso!');
        LimparCampos;
        CarregarGrid;
        PnlBackgrounEdit.Visible := False;
        PnlEdit.Visible := False;
      end;
    finally
      ServicoController.Free;
    end;
  finally
    Servico.Free;
  end;
end;

procedure TFormCadastroServiços.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then begin
    EditarServicos;
    CarregarGrid;
  end;
end;

procedure TFormCadastroServiços.BtnExcluirClick(Sender: TObject);
begin
  ExcluirServicos;
end;

procedure TFormCadastroServiços.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroServiços.BtnRestaurarGridClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroServiços.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Close;
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroServiços.RestaurarServicos;
var
  ServicoController: TServicoController;
  IdServico: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then begin
    ShowMessage('Nenhum serviço selecionado!');
    Exit;
  end;

  IdServico := DataSourceRestaurar.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar este serviço?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    ServicoController := TServicoController.Create;
    ServicoController.RestaurarServico(IdServico);
    CarregarGridRestaurar;
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.TituloGridMain;
begin
  DBGridMain.Columns[0].Title.Caption := 'Id';
  DBGridMain.Columns[1].Title.Caption := 'Nome';
  DBGridMain.Columns[2].Title.Caption := 'Categoria';
  DBGridMain.Columns[3].Title.Caption := 'Preço';
  DBGridMain.Columns[4].Title.Caption := 'Observação';
  DBGridMain.Columns[5].Title.Caption := 'Peças';
  DBGridMain.Columns[6].Title.Caption := 'Funcionario';
  DBGridMain.Columns[7].Title.Caption := 'Ativo';
end;

procedure TFormCadastroServiços.TituloGridRestaurar;
begin
  DBGridMain.Columns[0].Title.Caption := 'Id';
  DBGridMain.Columns[1].Title.Caption := 'Nome';
  DBGridMain.Columns[2].Title.Caption := 'Categoria';
  DBGridMain.Columns[3].Title.Caption := 'Preço';
  DBGridMain.Columns[4].Title.Caption := 'Observação';
  DBGridMain.Columns[5].Title.Caption := 'Peças';
  DBGridMain.Columns[6].Title.Caption := 'Funcionario';
  DBGridMain.Columns[7].Title.Caption := 'Ativo';
end;

procedure TFormCadastroServiços.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroServiços.ImgFecharFormClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    Close;
  end;
end;

procedure TFormCadastroServiços.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarServicos;
  CarregarGridRestaurar;
end;

procedure TFormCadastroServiços.CarregarGrid;
var
  ServicoController: TServicoController;
begin
  ServicoController := TServicoController.Create;
  try
    DataSourceMain.DataSet := ServicoController.ListarServicos;
    DBGridMain.DataSource := DataSourceMain;
    for var i := 0 to 7 do begin
      DBGridMain.Columns[i].Title.Alignment := taCenter;
      DBGridMain.Columns[i].Alignment := taCenter;
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
      TituloGridMain;
    end;
    DBGridMain.Columns[0].Width := 40;
    DBGridMain.Columns[1].Width := 170;
    DBGridMain.Columns[4].Width := 210;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.CarregarGridRestaurar;
var
  ServicoController: TServicoController;
begin
  ServicoController := TServicoController.Create;
  try
    DataSourceRestaurar.DataSet := ServicoController.ListarServicosRestaurar;
    DBGridRestaurar.DataSource := DataSourceRestaurar;
    if DBGridRestaurar.Columns.Count > 0 then begin
      for var i := 0 to DBGridRestaurar.Columns.Count - 1 do begin
        DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
        DBGridRestaurar.Columns[i].Alignment := taCenter;
        DBGridRestaurar.Columns[i].Width := 140;
        DBGridRestaurar.Columns[i].Title.Font.Size := 15;
        TituloGridRestaurar;
      end;
      DBGridRestaurar.Columns[0].Width := 40;
      DBGridMain.Columns[1].Width := 170;
      DBGridMain.Columns[4].Width := 210;
    end;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.CadastrarServicos;
var
  ServicoController: TServicoController;
  IdServico: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhum serviço selecionado!');
    Exit;
  end;
  IdServico := DataSourceMain.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente excluir este serviço?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    ServicoController := TServicoController.Create;
    ServicoController.DeletarServico(IdServico);
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.CarregarCategorias;
var
  ServicoController: TServicoController;
  ListaCategorias: TStringList;
  i: Integer;
begin
  CmbCategoria.Items.Clear;
  ServicoController := TServicoController.Create;
  try
    ListaCategorias := ServicoController.CarregarCategorias;
    try
      for i := 0 to ListaCategorias.Count - 1 do
        CmbCategoria.Items.AddObject(ListaCategorias[i],
          ListaCategorias.Objects[i]);
    finally
      ListaCategorias.Free;
    end;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.CarregarPecas;
var
  ServicoController: TServicoController;
  ListaPecas: TStringList;
  i: Integer;
begin
  CmbPeças.Items.Clear;
  ServicoController := TServicoController.Create;
  try
    ListaPecas := ServicoController.CarregarPecas;
    try
      for i := 0 to ListaPecas.Count - 1 do
        CmbPeças.Items.AddObject(ListaPecas[i], ListaPecas.Objects[i]);
    finally
      ListaPecas.Free;
    end;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.CarregarProfissionais;
var
  ServicoController: TServicoController;
  ListaProfissionais: TStringList;
  i: Integer;
begin
  CmbProfissional.Items.Clear;
  ServicoController := TServicoController.Create;
  try
    ListaProfissionais := ServicoController.CarregarProfissionais;
    try
      for i := 0 to ListaProfissionais.Count - 1 do
        CmbProfissional.Items.AddObject(ListaProfissionais[i],
          ListaProfissionais.Objects[i]);
    finally
      ListaProfissionais.Free;
    end;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.EdtPesquisarChange(Sender: TObject);
var
  ServicoController: TServicoController;
begin
  ServicoController := TServicoController.Create;
  try
    DataSourceMain.DataSet := ServicoController.PesquisarServicos
      (EdtPesquisar.Text);
    DBGridMain.DataSource := DataSourceMain;
    if DBGridMain.Columns.Count > 0 then begin
      for var i := 0 to DBGridMain.Columns.Count - 1 do begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
        TituloGridMain;
      end;
      DBGridMain.Columns[0].Width := 40;
      DBGridMain.Columns[1].Width := 170;
      DBGridMain.Columns[4].Width := 210;
    end;
  finally
    ServicoController.Free;
  end;
end;

procedure TFormCadastroServiços.ExcluirServicos;
var
  ServicoController: TServicoController;
  IdServico: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhum serviço selecionado!');
    Exit;
  end;
  IdServico := DataSourceMain.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente excluir este serviço?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    ServicoController := TServicoController.Create;
    ServicoController.DeletarServico(IdServico);
    CarregarGrid;
    ServicoController.Free;
  end;
end;

end.
