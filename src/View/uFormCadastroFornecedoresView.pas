unit uFormCadastroFornecedoresView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, FornecedorCadastroService,
  FornecedorCadastroController, uFornecedor, PeçasCadastroService,
  Vcl.CheckLst, System.Generics.Collections, uPedido;

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
    PnlBackgrounEdit: TPanel;
    DBGridMain: TDBGrid;
    PnlDesignEdit: TPanel;
    BtnVincularPeças: TSpeedButton;
    DBGridRestaurar: TDBGrid;
    DataSourceVincular: TDataSource;
    BtnCancelar: TSpeedButton;
    BtnPedido: TSpeedButton;
    PnlPedido: TPanel;
    ImgFecharPedido: TImage;
    LblPedido: TLabel;
    PnlBackgroundPedido: TPanel;
    PnlDesingPedido: TPanel;
    PnlEditPedido: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    PnlAdicionar: TPanel;
    EdtValorTotal: TEdit;
    CmbFornecedorPedido: TComboBox;
    CmbFormaPagamento: TComboBox;
    EdtQuantidade: TEdit;
    EdtObservacao: TEdit;
    CmbPeças: TComboBox;
    PnlFinalizar: TPanel;
    LblFinalizar: TLabel;
    ListBoxPedidos: TListBox;
    Panel3: TPanel;
    Label18: TLabel;
    Image1: TImage;
    Label12: TLabel;
    PnlVincularPeça: TPanel;
    Image3: TImage;
    PnlDesignVincular: TPanel;
    PnlBackgroundVincular: TPanel;
    PnlFooter: TPanel;
    LblPeçasVinculadas: TLabel;
    CheckBoxPeçasVinculadas: TCheckBox;
    DBGridVincular: TDBGrid;
    PnlEditVincular: TPanel;
    LblFornecedorVincular: TLabel;
    ImgLogoVincular: TImage;
    CmbFornecedor: TComboBox;
    PnlButtonVincular: TPanel;
    LblVincular: TLabel;
    PnlButtonDesvincular: TPanel;
    LblDesvincular: TLabel;
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
    EdtCNPJ: TMaskEdit;
    EdtNome: TEdit;
    EdtTelefone: TMaskEdit;
    EdtCEP: TMaskEdit;
    CmbStatus: TComboBox;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtEstado: TEdit;
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlButtonAtualizar: TPanel;
    LlAtualizar: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    LblAdicionar: TLabel;
    Image6: TImage;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image7: TImage;

    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharVincularClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    Function ValidarCampos: Boolean;
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
    procedure ImageFecharVincularClick(Sender: TObject);
    procedure CarregarGridVincular;
    procedure ListarPecaPorFornecedor;
    procedure CarregarFornecedores;
    procedure CarregarPeças;
    procedure LblVincularClick(Sender: TObject);
    procedure LblDesvincularClick(Sender: TObject);

    procedure BtnPedidoClick(Sender: TObject);
    procedure ImgFecharPedidoClick(Sender: TObject);
    procedure CarregarFornecedoresPedido;
    procedure CheckBoxPeçasVinculadasClick(Sender: TObject);
    procedure CmbFornecedorChange(Sender: TObject);
    procedure LblAdicionarClick(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure AtualizarEstadoCombos;
    procedure LblFinalizarClick(Sender: TObject);
    procedure CmbFornecedorPedidoChange(Sender: TObject);
    procedure CmbPeçasChange(Sender: TObject);
    procedure EdtQuantidadeChange(Sender: TObject);
    procedure CalcularValorTotalPedido;
    procedure ExcluirFornecedores;
    procedure CadastrarFornecedores;
    procedure DesvincularPecaFornecedor;
    procedure VincularPecaFornecedor;
    function ValidarCamposPedido: Boolean;

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
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
  PnlRestaurar.Visible := False;
  PnlPedido.Visible := False;
  PnlVincularPeça.Visible := False;
  EdtNome.SetFocus;
  LimparCampos;
end;

procedure TFormCadastroFornecedores.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  EdtPesquisar.Visible := False;
  PnlVincularPeça.Visible := False;
  PnlPedido.Visible := False;
  LimparCampos;
end;

procedure TFormCadastroFornecedores.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlRestaurar.Visible := False;
  PnlPedido.Visible := False;
  PnlVincularPeça.Visible := False;
  PnlBackgrounEdit.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroFornecedores.CarregarFornecedores;
var
  Controller: TFornecedorController;
  ListaFornecedores: TStringList;
  i: Integer;
begin
  CmbFornecedor.Items.Clear;
  Controller := TFornecedorController.Create;
  try
    ListaFornecedores := Controller.CarregarFornecedores;
    try
      for i := 0 to ListaFornecedores.Count - 1 do
        CmbFornecedor.Items.AddObject(ListaFornecedores[i],
          ListaFornecedores.Objects[i]);
      CmbFornecedor.ItemIndex := -1;
    finally
      ListaFornecedores.Free;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.CarregarPeças;
var
  Controller: TFornecedorController;
  ListaPeças: TStringList;
  i: Integer;
begin
  CmbPeças.Items.Clear;
  Controller := TFornecedorController.Create;
  try
    ListaPeças := Controller.CarregarPecas;
    try
      for i := 0 to ListaPeças.Count - 1 do
        CmbPeças.Items.AddObject(ListaPeças[i], ListaPeças.Objects[i]);
      CmbPeças.ItemIndex := -1;
    finally
      ListaPeças.Free;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.CarregarGrid;
var
  FornecedorController: TFornecedorController;
begin
  FornecedorController := TFornecedorController.Create;
  try
    DataSourceMain.DataSet := FornecedorController.ListarFornecedores;
    DBGridMain.DataSource := DataSourceMain;
    if DBGridMain.Columns.Count >= 11 then begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'Razão Social';
      DBGridMain.Columns[3].Title.Caption := 'CNPJ';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'CEP';
      DBGridMain.Columns[6].Title.Caption := 'Rua';
      DBGridMain.Columns[7].Title.Caption := 'Número';
      DBGridMain.Columns[8].Title.Caption := 'Bairro';
      DBGridMain.Columns[9].Title.Caption := 'Cidade';
      DBGridMain.Columns[10].Title.Caption := 'Estado';
      DBGridMain.Columns[11].Title.Caption := 'Ativo';
      for var i := 0 to 11 do begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
      DBGridMain.Columns[0].Width := 50;
    end;
  finally
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.DesvincularPecaFornecedor;
var
  Controller: TFornecedorController;
  IdPeca, IdFornecedor: Integer;
begin
  if CmbFornecedor.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor!');
    Exit;
  end;

  if DataSourceVincular.DataSet.IsEmpty then begin
    ShowMessage('Selecione uma peça vinculada para desvincular!');
    Exit;
  end;

  if MessageDlg('Deseja realmente desvincular esta peça do fornecedor?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Controller := TFornecedorController.Create;
    try
      IdPeca := DataSourceVincular.DataSet.FieldByName('id').AsInteger;
      IdFornecedor := Integer(CmbFornecedor.Items.Objects
        [CmbFornecedor.ItemIndex]);

      Controller.DesvincularPecaAoFornecedor(IdPeca, IdFornecedor);
      ShowMessage('Peça desvinculada com sucesso!');
      ListarPecaPorFornecedor;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormCadastroFornecedores.VincularPecaFornecedor;
var
  Controller: TFornecedorController;
  IdPeca, IdFornecedor: Integer;
begin
  if CmbFornecedor.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor!');
    Exit;
  end;

  if DataSourceVincular.DataSet.IsEmpty then begin
    ShowMessage('Selecione uma peça na grid!');
    Exit;
  end;

  Controller := TFornecedorController.Create;
  try
    IdPeca := DataSourceVincular.DataSet.FieldByName('id').AsInteger;
    IdFornecedor := Integer(CmbFornecedor.Items.Objects
      [CmbFornecedor.ItemIndex]);

    if Controller.VincularPecaAoFornecedor(IdPeca, IdFornecedor) then begin
      ShowMessage('Peça vinculada com sucesso!');
      CarregarGridVincular;
      if CheckBoxPeçasVinculadas.Checked then
        ListarPecaPorFornecedor;
    end
    else begin
      ShowMessage('Esta peça já está vinculada a este fornecedor!');
      CarregarGridVincular;
      Exit;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.ExcluirFornecedores;
var
  FornecedorController: TFornecedorController;
  IdFornecedor: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhum fornecedor selecionado!');
    Exit;
  end;
  IdFornecedor := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar este fornecedor?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    FornecedorController := TFornecedorController.Create;
    FornecedorController.DeletarFornecedor(IdFornecedor);
    CarregarGrid;
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.CarregarGridRestaurar;
var
  FornecedorController: TFornecedorController;
begin
  FornecedorController := TFornecedorController.Create;
  try
    DataSourceRestaurar.DataSet :=
      FornecedorController.ListarFornecedoresRestaurar;
    DBGridRestaurar.DataSource := DataSourceRestaurar;
    if DBGridRestaurar.Columns.Count >= 11 then begin
      for var i := 0 to 11 do begin
        DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
        DBGridRestaurar.Columns[i].Alignment := taCenter;
        DBGridRestaurar.Columns[i].Width := 120;
        DBGridRestaurar.Columns[i].Title.Font.Size := 15;
      end;
      if DBGridRestaurar.Columns.Count >= 11 then begin
        DBGridRestaurar.Columns[0].Title.Caption := 'ID';
        DBGridRestaurar.Columns[1].Title.Caption := 'Nome';
        DBGridRestaurar.Columns[2].Title.Caption := 'Razão Social';
        DBGridRestaurar.Columns[3].Title.Caption := 'CNPJ';
        DBGridRestaurar.Columns[4].Title.Caption := 'Telefone';
        DBGridRestaurar.Columns[5].Title.Caption := 'CEP';
        DBGridRestaurar.Columns[6].Title.Caption := 'Rua';
        DBGridRestaurar.Columns[7].Title.Caption := 'Número';
        DBGridRestaurar.Columns[8].Title.Caption := 'Bairro';
        DBGridRestaurar.Columns[9].Title.Caption := 'Cidade';
        DBGridRestaurar.Columns[10].Title.Caption := 'Estado';
        DBGridRestaurar.Columns[11].Title.Caption := 'Ativo';
      end;
      DBGridRestaurar.Columns[0].Width := 50;
    end;
  finally
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.CadastrarFornecedores;
var
  FornecedorController: TFornecedorController;
  Fornecedor: TFornecedor;
begin
  FornecedorController := TFornecedorController.Create;
  try
    Fornecedor := FornecedorController.CriarObjeto(EdtNome.Text,
      EdtRazaoSocial.Text, EdtCNPJ.Text, EdtTelefone.Text, EdtCEP.Text,
      EdtRua.Text, EdtNumero.Text, EdtBairro.Text, EdtCidade.Text,
      EdtEstado.Text, CmbStatus.ItemIndex = 0);
    FornecedorController.SalvarFornecedor(Fornecedor);
    Fornecedor.Free;
  finally
    FornecedorController.Free;
  end;
end;

procedure TFormCadastroFornecedores.CarregarGridVincular;
var
  ServicePecas: TPecaService;
begin
  try
    ServicePecas := TPecaService.Create;
    DataSourceVincular.DataSet := ServicePecas.ListarPecas;
    DBGridVincular.DataSource := DataSourceVincular;
    if DBGridVincular.Columns.Count >= 8 then begin
      DBGridVincular.Columns[0].Title.Caption := 'ID';
      DBGridVincular.Columns[1].Title.Caption := 'Nome';
      DBGridVincular.Columns[2].Title.Caption := 'Descrição';
      DBGridVincular.Columns[3].Title.Caption := 'Código Interno';
      DBGridVincular.Columns[4].Title.Caption := 'Categoria';
      DBGridVincular.Columns[5].Title.Caption := 'Preço';
      DBGridVincular.Columns[6].Title.Caption := 'Unidade';
      DBGridVincular.Columns[7].Title.Caption := 'Modelo';
      DBGridVincular.Columns[8].Title.Caption := 'Status';
      for var i := 0 to 8 do begin
        DBGridVincular.Columns[i].Title.Alignment := taCenter;
        DBGridVincular.Columns[i].Alignment := taCenter;
        DBGridVincular.Columns[i].Width := 140;
        DBGridVincular.Columns[i].Title.Font.Size := 15;
      end;
      DBGridVincular.Columns[0].Width := 40;
    end;
  finally
    ServicePecas.Free;
  end;
end;

procedure TFormCadastroFornecedores.CheckBoxPeçasVinculadasClick
  (Sender: TObject);
begin
  if CmbFornecedor.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor!');
    Exit;
    CheckBoxPeçasVinculadas.Checked := False;
    CarregarGridVincular
  end else begin
    PnlButtonVincular.Visible := not PnlButtonVincular.Visible;
    PnlButtonDesvincular.Visible := not PnlButtonDesvincular.Visible;
    ListarPecaPorFornecedor;
  end;
  if CheckBoxPeçasVinculadas.Checked = False then begin
    CarregarGridVincular;
  end;
end;

procedure TFormCadastroFornecedores.CmbFornecedorChange(Sender: TObject);
begin
  If CheckBoxPeçasVinculadas.Checked = True then begin
    ListarPecaPorFornecedor;
  end;
end;

procedure TFormCadastroFornecedores.CmbFornecedorPedidoChange(Sender: TObject);
var
  Controller: TFornecedorController;
  ListaPecas: TStringList;
  IdFornecedor: Integer;
  i: Integer;
begin
  CmbPeças.Items.Clear;
  CmbPeças.ItemIndex := -1;

  if CmbFornecedorPedido.ItemIndex = -1 then
    Exit;

  IdFornecedor := Integer(CmbFornecedorPedido.Items.Objects
    [CmbFornecedorPedido.ItemIndex]);

  Controller := TFornecedorController.Create;
  try
    ListaPecas := Controller.CarregarPecasPorFornecedor(IdFornecedor);
    try
      if ListaPecas.Count = 0 then begin
        ShowMessage('Este fornecedor não possui peças vinculadas!');
        Exit;
      end;

      for i := 0 to ListaPecas.Count - 1 do
        CmbPeças.Items.AddObject(ListaPecas[i], ListaPecas.Objects[i]);

      CmbPeças.ItemIndex := -1;
    finally
      ListaPecas.Free;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.CmbPeçasChange(Sender: TObject);
begin
  CalcularValorTotalPedido;
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
    DataSourceMain.DataSet := nil;
    DataSourceMain.DataSet := FornecedorService.PesquisarFornecedores
      (EdtPesquisar.Text);
    if DBGridMain.Columns.Count >= 11 then begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'Razão Social';
      DBGridMain.Columns[3].Title.Caption := 'CNPJ';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'CEP';
      DBGridMain.Columns[6].Title.Caption := 'Rua';
      DBGridMain.Columns[7].Title.Caption := 'Número';
      DBGridMain.Columns[8].Title.Caption := 'Bairro';
      DBGridMain.Columns[9].Title.Caption := 'Cidade';
      DBGridMain.Columns[10].Title.Caption := 'Estado';
      DBGridMain.Columns[11].Title.Caption := 'Ativo';
      for var i := 0 to 11 do begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
      DBGridMain.Columns[0].Width := 50;
    end;
  finally
    FornecedorService.Free;
  end;
end;

procedure TFormCadastroFornecedores.EdtQuantidadeChange(Sender: TObject);
begin
  CalcularValorTotalPedido;
end;

procedure TFormCadastroFornecedores.EdtTelefoneClick(Sender: TObject);
begin
  EdtTelefone.SelStart := 0;
end;

procedure TFormCadastroFornecedores.PegarCamposGridFornecedores;
begin
  EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtRazaoSocial.Text := DBGridMain.DataSource.DataSet.FieldByName
    ('razao_social').AsString;
  EdtCNPJ.Text := DBGridMain.DataSource.DataSet.FieldByName('cnpj').AsString;
  EdtTelefone.Text := DBGridMain.DataSource.DataSet.FieldByName
    ('telefone').AsString;
  EdtCEP.Text := DBGridMain.DataSource.DataSet.FieldByName('cep').AsString;
  EdtRua.Text := DBGridMain.DataSource.DataSet.FieldByName('rua').AsString;
  EdtNumero.Text := DBGridMain.DataSource.DataSet.FieldByName('numero')
    .AsString;
  EdtBairro.Text := DBGridMain.DataSource.DataSet.FieldByName('bairro')
    .AsString;
  EdtCidade.Text := DBGridMain.DataSource.DataSet.FieldByName('cidade')
    .AsString;
  EdtEstado.Text := DBGridMain.DataSource.DataSet.FieldByName('Estado')
    .AsString;
  if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then
    CmbStatus.ItemIndex := 0
  else
    CmbStatus.ItemIndex := 1;
end;

procedure TFormCadastroFornecedores.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridFornecedores;
end;

procedure TFormCadastroFornecedores.BtnExcluirClick(Sender: TObject);
begin
  ExcluirFornecedores;
end;

procedure TFormCadastroFornecedores.Label18Click(Sender: TObject);
begin
  ListBoxPedidos.Clear;
  AtualizarEstadoCombos;
  LimparCampos;
  EdtValorTotal.Text := '0,00';
end;

procedure TFormCadastroFornecedores.AtualizarEstadoCombos;
begin
  if ListBoxPedidos.Items.Count > 0 then begin
    CmbFornecedorPedido.Enabled := False;
    CmbFormaPagamento.Enabled := False;
  end
  else begin
    CmbFornecedorPedido.Enabled := True;
    CmbFormaPagamento.Enabled := True;
  end;
end;

procedure TFormCadastroFornecedores.LblAdicionarClick(Sender: TObject);
var
  Controller: TFornecedorController;
  IdPeca, Quantidade: Integer;
  PrecoUnitario, ValorItem, ValorTotalAtual: Currency;
begin
  if CmbFornecedorPedido.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor primeiro!');
    CmbFornecedorPedido.SetFocus;
    Exit;
  end;

  if CmbFormaPagamento.ItemIndex = -1 then begin
    ShowMessage('Selecione uma forma de pagamento!');
    CmbFormaPagamento.SetFocus;
    Exit;
  end;

  if CmbPeças.ItemIndex = -1 then begin
    ShowMessage('Selecione uma peça!');
    CmbPeças.SetFocus;
    Exit;
  end;

  if Trim(EdtQuantidade.Text) = '' then begin
    ShowMessage('Informe a quantidade!');
    EdtQuantidade.SetFocus;
    Exit;
  end;

  Quantidade := StrToIntDef(EdtQuantidade.Text, 0);
  if Quantidade <= 0 then begin
    ShowMessage('Quantidade deve ser maior que zero!');
    EdtQuantidade.SetFocus;
    Exit;
  end;

  Controller := TFornecedorController.Create;
  try
    IdPeca := Integer(CmbPeças.Items.Objects[CmbPeças.ItemIndex]);
    PrecoUnitario := Controller.ObterPrecoCompraPeca(IdPeca);

    if PrecoUnitario <= 0 then begin
      ShowMessage('Preço da peça não encontrado ou inválido!');
      Exit;
    end;
    ValorItem := PrecoUnitario * Quantidade;
    ListBoxPedidos.AddItem(Format('Peça: %s - Qtd: %d - Subtotal: R$ %.2f',
      [CmbPeças.Text, Quantidade, ValorItem]), TObject(IdPeca));

    ValorTotalAtual := StrToCurrDef(StringReplace(EdtValorTotal.Text, '.', '',
      [rfReplaceAll]), 0);
    ValorTotalAtual := ValorTotalAtual + ValorItem;
    EdtValorTotal.Text := FormatFloat('#,##0.00', ValorTotalAtual);
    EdtQuantidade.Clear;
    CmbPeças.ItemIndex := -1;
    CmbPeças.SetFocus;
    AtualizarEstadoCombos;

  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then begin
    EditarFornecedores;
    CarregarGrid;
  end;
end;

procedure TFormCadastroFornecedores.LblDesvincularClick(Sender: TObject);
begin
  DesvincularPecaFornecedor;
end;

procedure TFormCadastroFornecedores.LblEnviarClick(Sender: TObject);
begin
  if ValidarCampos then begin
    CadastrarFornecedores;
    LimparCampos;
    CarregarGrid;
    ShowMessage('Fornecedor cadastrado com sucesso!');
  end;
end;

procedure TFormCadastroFornecedores.LblFinalizarClick(Sender: TObject);
var
  Controller: TFornecedorController;
  i: Integer;
  Linha, QuantidadeStr: string;
  IdFornecedor: Integer;
  ValorTotal: Currency;
  PecasIDs: TList<Integer>;
  Quantidades: TList<Integer>;
  FormaPagamento: string;
  PosQtd: Integer;
begin
  if CmbFornecedorPedido.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor para o pedido!');
    CmbFornecedorPedido.SetFocus;
    Exit;
  end;

  if CmbFormaPagamento.ItemIndex = -1 then begin
    ShowMessage('Selecione uma forma de pagamento!');
    CmbFormaPagamento.SetFocus;
    Exit;
  end;

  if ListBoxPedidos.Items.Count = 0 then begin
    ShowMessage('Adicione pelo menos uma peça ao pedido!');
    CmbPeças.SetFocus;
    Exit;
  end;

  if MessageDlg('Deseja realmente finalizar este pedido?', mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;

  PecasIDs := TList<Integer>.Create;
  Quantidades := TList<Integer>.Create;
  Controller := TFornecedorController.Create;
  try
    try
      IdFornecedor := Integer(CmbFornecedorPedido.Items.Objects[CmbFornecedorPedido.ItemIndex]);
      FormaPagamento := CmbFormaPagamento.Text;
      for i := 0 to ListBoxPedidos.Items.Count - 1 do begin
        PecasIDs.Add(Integer(ListBoxPedidos.Items.Objects[i]));
          Linha := ListBoxPedidos.Items[i];
        PosQtd := Pos('Qtd: ', Linha);

        if PosQtd > 0 then begin
          Delete(Linha, 1, PosQtd + 4);
          QuantidadeStr := Copy(Linha, 1, Pos(' ', Linha) - 1);
          Quantidades.Add(StrToIntDef(QuantidadeStr, 1));
        end else begin
          Quantidades.Add(1);
        end;
      end;
      ValorTotal := Controller.CalcularValorTotal(PecasIDs, Quantidades);
      if ValorTotal <= 0 then begin
        ShowMessage('O valor total do pedido deve ser maior que zero!');
        Exit;
      end;
      EdtValorTotal.Text := FormatFloat('0.00', ValorTotal);
      if Controller.SalvarPedido(IdFornecedor, FormaPagamento, ValorTotal,
        Trim(EdtObservacao.Text), PecasIDs, Quantidades) then begin

        ShowMessage('Pedido finalizado com sucesso!');
        ListBoxPedidos.Clear;
        CmbFornecedorPedido.ItemIndex := -1;
        CmbFormaPagamento.ItemIndex := -1;
        CmbPeças.ItemIndex := -1;
        EdtValorTotal.Clear;
        EdtObservacao.Clear;
        EdtQuantidade.Clear;
        AtualizarEstadoCombos;
        CarregarGrid;
        Sleep(1000);
        ShowMessage('Pendência Financeira gerada com sucesso !');
        PnlPedido.Visible := False;
      end
      else begin
        ShowMessage('Erro ao salvar o pedido. Tente novamente.');
      end;

    except
      on E: Exception do
        ShowMessage('Erro ao finalizar pedido: ' + E.Message);
    end;
  finally
    PecasIDs.Free;
    Quantidades.Free;
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.LblVincularClick(Sender: TObject);
begin
  VincularPecaFornecedor;
end;

procedure TFormCadastroFornecedores.EditarFornecedores;
var
  FornecedorController: TFornecedorController;
  Fornecedor: TFornecedor;
  IdFornecedor: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
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
  PnlBackgrounEdit.Visible := False;
  PnlVincularPeça.Visible := False;
  EdtPesquisar.Visible := False;
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
  if DataSourceRestaurar.DataSet.IsEmpty then begin
    ShowMessage('Nenhum fornecedor selecionado!');
    Exit;
  end;
  IdFornecedor := DBGridRestaurar.DataSource.DataSet.FieldByName('id')
    .AsInteger;
  if MessageDlg('Deseja realmente restaurar este fornecedor?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
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

procedure TFormCadastroFornecedores.ImageFecharVincularClick(Sender: TObject);
begin
  PnlVincularPeça.Visible := False;
  CmbFornecedor.ItemIndex := -1;
  CarregarGrid;
end;

procedure TFormCadastroFornecedores.ImgFecharVincularClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroFornecedores.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Close;
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  EdtPesquisar.Visible := False;
  PnlVincularPeça.Visible := False;
  PnlPedido.Visible := False;
  ListBoxPedidos.Clear;
end;

procedure TFormCadastroFornecedores.BtnVincularPeçasClick(Sender: TObject);
begin
  PnlVincularPeça.Visible := True;
  PnlBackgrounEdit.Visible := False;
  PnlPedido.Visible := False;
  CarregarGridVincular;
end;

procedure TFormCadastroFornecedores.BuscarCEP;
var
  Rua, Bairro, Cidade, Estado: string;
  FornecedorService: TFornecedorService;
begin
  FornecedorService := TFornecedorService.Create;
  try
    try
      FornecedorService.BuscarCEP(EdtCEP.Text, Rua, Bairro, Cidade, Estado);
      EdtRua.Text := Rua;
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
  EdtNome.Height := 31;
  EdtRazaoSocial.Height := 31;
  EdtCNPJ.Height := 31;
  EdtTelefone.Height := 31;
  EdtCEP.Height := 31;
  EdtRua.Height := 31;
  EdtNumero.Height := 31;
  EdtBairro.Height := 31;
  EdtCidade.Height := 31;
  EdtEstado.Height := 31;
end;

procedure TFormCadastroFornecedores.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarFornecedores;
  CarregarPeças;
  AtualizarEstadoCombos;
end;

function TFormCadastroFornecedores.ValidarCampos: Boolean;
begin
  Result := False;
  if Trim(EdtNome.Text) = '' then begin
    ShowMessage('O campo Nome não pode ficar vazio!');
    EdtNome.SetFocus;
    Exit;
  end;

  if Trim(EdtRazaoSocial.Text) = '' then begin
    ShowMessage('O campo Razão Social não pode ficar vazio!');
    EdtRazaoSocial.SetFocus;
    Exit;
  end;

  if Trim(EdtCNPJ.Text) = '' then begin
    ShowMessage('O campo CNPJ não pode ficar vazio!');
    EdtCNPJ.SetFocus;
    Exit;
  end;

  if Trim(EdtTelefone.Text) = '' then begin
    ShowMessage('O campo Telefone não pode ficar vazio!');
    EdtTelefone.SetFocus;
    Exit;
  end;

  if Trim(EdtCEP.Text) = '' then begin
    ShowMessage('O campo CEP não pode ficar vazio!');
    EdtCEP.SetFocus;
    Exit;
  end;

  if Trim(EdtRua.Text) = '' then begin
    ShowMessage('O campo Rua não pode ficar vazio!');
    EdtRua.SetFocus;
    Exit;
  end;

  if Trim(EdtNumero.Text) = '' then begin
    ShowMessage('O campo Número não pode ficar vazio!');
    EdtNumero.SetFocus;
    Exit;
  end;

  if Trim(EdtBairro.Text) = '' then begin
    ShowMessage('O campo Bairro não pode ficar vazio!');
    EdtBairro.SetFocus;
    Exit;
  end;

  if Trim(EdtCidade.Text) = '' then begin
    ShowMessage('O campo Cidade não pode ficar vazio!');
    EdtCidade.SetFocus;
    Exit;
  end;

  if Trim(EdtEstado.Text) = '' then begin
    ShowMessage('O campo Estado não pode ficar vazio!');
    EdtEstado.SetFocus;
    Exit;
  end;

  if CmbStatus.ItemIndex = -1 then begin
    ShowMessage('Selecione o Status do fornecedor!');
    CmbStatus.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TFormCadastroFornecedores.ValidarCamposPedido: Boolean;
begin
  Result := False;

  if CmbFornecedorPedido.ItemIndex = -1 then begin
    ShowMessage('Selecione um fornecedor para o pedido!');
    CmbFornecedorPedido.SetFocus;
    Exit;
  end;

  if CmbFormaPagamento.ItemIndex = -1 then begin
    ShowMessage('Selecione uma forma de pagamento!');
    CmbFormaPagamento.SetFocus;
    Exit;
  end;

  if ListBoxPedidos.Items.Count = 0 then begin
    ShowMessage('Adicione pelo menos uma peça ao pedido!');
    CmbPeças.SetFocus;
    Exit;
  end;

  if (Trim(EdtValorTotal.Text) = '') or (EdtValorTotal.Text = '0,00') then begin
    ShowMessage('O valor total do pedido deve ser maior que zero!');
    Exit;
  end;

  Result := True;
end;

procedure TFormCadastroFornecedores.LimparCampos;
begin
  EdtNome.Clear;
  EdtRazaoSocial.Clear;
  EdtCNPJ.Clear;
  EdtTelefone.Clear;
  EdtCEP.Clear;
  EdtRua.Clear;
  EdtNumero.Clear;
  EdtBairro.Clear;
  EdtCidade.Clear;
  EdtEstado.Clear;
  EdtObservacao.Clear;
  EdtValorTotal.Clear;
  EdtQuantidade.Clear;
  CmbStatus.ItemIndex := -1;
  CmbFornecedorPedido.ItemIndex := -1;
  CmbFormaPagamento.ItemIndex := -1;
  CmbPeças.ItemIndex := -1;
end;

procedure TFormCadastroFornecedores.ListarPecaPorFornecedor;
var
  Controller: TFornecedorController;
  IdFornecedor: Integer;
begin
  if CmbFornecedor.ItemIndex = -1 then
    Exit;

  IdFornecedor := Integer(CmbFornecedor.Items.Objects[CmbFornecedor.ItemIndex]);

  Controller := TFornecedorController.Create;
  try
    DataSourceVincular.DataSet := Controller.ListarPecasPorFornecedor
      (IdFornecedor);
    DBGridVincular.DataSource := DataSourceVincular;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.BtnPedidoClick(Sender: TObject);
begin
  PnlPedido.Visible := True;
  PnlRestaurar.Visible := False;
  PnlVincularPeça.Visible := False;
  PnlBackgrounEdit.Visible := False;
  CarregarFornecedoresPedido;
  LimparCampos;
end;

procedure TFormCadastroFornecedores.CarregarFornecedoresPedido;
var
  Controller: TFornecedorController;
  ListaFornecedores: TStringList;
  i: Integer;
begin
  CmbFornecedorPedido.Items.Clear;
  Controller := TFornecedorController.Create;
  try
    ListaFornecedores := Controller.CarregarFornecedores;
    try
      for i := 0 to ListaFornecedores.Count - 1 do
        CmbFornecedorPedido.Items.AddObject(ListaFornecedores[i],
          ListaFornecedores.Objects[i]);
      CmbFornecedorPedido.ItemIndex := -1;
    finally
      ListaFornecedores.Free;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.CalcularValorTotalPedido;
var
  Controller: TFornecedorController;
  Quantidade: Integer;
  ValorUnitario: Currency;
begin

  Controller := TFornecedorController.Create;
  try
    Quantidade := StrToIntDef(EdtQuantidade.Text, 0);
    if Quantidade > 0 then begin
      ValorUnitario := Controller.ObterPrecoCompraPeca
        (Integer(CmbPeças.Items.Objects[CmbPeças.ItemIndex]));
      EdtValorTotal.Text := FormatFloat('#,##0.00', Quantidade * ValorUnitario);
    end
    else
      EdtValorTotal.Text := '0,00';
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroFornecedores.ImgFecharPedidoClick(Sender: TObject);
begin
  PnlPedido.Visible := False;
  CarregarGrid;
end;

end.
