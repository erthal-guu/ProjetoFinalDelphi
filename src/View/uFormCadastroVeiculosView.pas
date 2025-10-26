unit uFormCadastroVeiculosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  VeiculoCadastroController, VeiculoCadastroService, uVeiculo,
  Vcl.Imaging.pngimage;

type
  TFormCadastroVeiculos = class(TForm)
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlGrid: TPanel;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlMainEdit: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    DBGridMain: TDBGrid;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    EdtModelo: TEdit;
    EdtCor: TEdit;
    CmbCliente: TComboBox;
    EdtPlaca: TMaskEdit;
    EdtMarca: TEdit;
    EdtChassi: TEdit;
    EdtFabrica��o: TEdit;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    CmbStatus: TComboBox;
    LblStatus: TLabel;
    BtnCancelar: TSpeedButton;

    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure EditarVeiculos;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridVeiculos;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarGridClick(Sender: TObject);
    procedure RestaurarVeiculos;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarClientes;
    procedure BtnCancelarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroVeiculos: TFormCadastroVeiculos;

implementation

{$R *.dfm}

procedure TFormCadastroVeiculos.FormCreate(Sender: TObject);
begin
  EdtModelo.Height := 31;
  EdtMarca.Height := 31;
  EdtChassi.Height := 31;
  EdtPlaca.Height := 31;
  EdtCor.Height := 31;
  EdtFabrica��o.Height := 31;
  CmbCliente.Height := 31;
end;

procedure TFormCadastroVeiculos.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormCadastroVeiculos.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormCadastroVeiculos.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarClientes;
end;

function TFormCadastroVeiculos.ValidarCampos: Boolean;
begin
  if EdtModelo.Text = '' then begin ShowMessage('O campo Modelo n�o pode ficar vazio'); Exit(False); end;
  if EdtMarca.Text = '' then begin ShowMessage('O campo Marca n�o pode ficar vazio'); Exit(False); end;
  if EdtChassi.Text = '' then begin ShowMessage('O campo Chassi n�o pode ficar vazio'); Exit(False); end;
  if EdtPlaca.Text = '' then begin ShowMessage('O campo Placa n�o pode ficar vazio'); Exit(False); end;
  if EdtCor.Text = '' then begin ShowMessage('O campo Cor n�o pode ficar vazio'); Exit(False); end;
  if EdtFabrica��o.Text = '' then begin ShowMessage('O campo Fabrica��o n�o pode ficar vazio'); Exit(False); end;
  if CmbCliente.ItemIndex = -1 then begin ShowMessage('Selecione um Cliente v�lido'); Exit(False); end;
  Result := True;
end;

procedure TFormCadastroVeiculos.LimparCampos;
begin
  EdtModelo.Clear;
  EdtMarca.Clear;
  EdtChassi.Clear;
  EdtPlaca.Clear;
  EdtCor.Clear;
  EdtFabrica��o.Clear;
  CmbCliente.ItemIndex := -1;
end;
procedure TFormCadastroVeiculos.CarregarGrid;
var
  VeiculoController: TVeiculoController;
begin
  VeiculoController := TVeiculoController.Create;
  DataSourceMain.DataSet := VeiculoController.ListarVeiculos;
  DBGridMain.DataSource := DataSourceMain;
  try
    if DBGridMain.Columns.Count >= 8 then
    begin
      DBGridMain.Columns[0].Title.Caption:= 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Modelo';
      DBGridMain.Columns[2].Title.Caption := 'Marca';
      DBGridMain.Columns[3].Title.Caption := 'Chassi';
      DBGridMain.Columns[4].Title.Caption := 'Placa';
      DBGridMain.Columns[5].Title.Caption := 'Cor';
      DBGridMain.Columns[6].Title.Caption := 'Fabrica��o';
      DBGridMain.Columns[7].Title.Caption := 'Cliente';
      DBGridMain.Columns[8].Title.Caption := 'Ativo';
      for var i := 0 to 8 do
      begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.CarregarGridRestaurar;
var
  VeiculoController: TVeiculoController;
begin
  VeiculoController := TVeiculoController.Create;
  DataSourceRestaurar.DataSet := VeiculoController.ListarVeiculosRestaurar;
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
    VeiculoController.Free;
  end;
end;


procedure TFormCadastroVeiculos.CarregarClientes;
var
  VeiculoController: TVeiculoController;
  ListaClientes: TStringList;
  i: Integer;
begin
  CmbCliente.Items.Clear;
  VeiculoController := TVeiculoController.Create;
  try
    ListaClientes := VeiculoController.CarregarClientes;
    try
      for i := 0 to ListaClientes.Count - 1 do
        CmbCliente.Items.AddObject(ListaClientes[i], ListaClientes.Objects[i]);
      CmbCliente.ItemIndex := -1;
    finally
      ListaClientes.Free;
    end;
  finally
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.EdtPesquisarChange(Sender: TObject);
var
  VeiculoController: TVeiculoController;
begin
  VeiculoController := TVeiculoController.Create;
  try
    DataSourceMain.DataSet := VeiculoController.PesquisarVeiculos(EdtPesquisar.Text);
    for var i := 0 to 7 do
    begin
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;
    DBGridRestaurar.Columns[0].Width := 40;
  finally
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.PegarCamposGridVeiculos;
var
  ClienteNome: String;
  i: Integer;
begin
  try
    EdtModelo.Text := DBGridMain.DataSource.DataSet.FieldByName('Modelo').AsString;
    EdtMarca.Text := DBGridMain.DataSource.DataSet.FieldByName('Marca').AsString;
    EdtChassi.Text := DBGridMain.DataSource.DataSet.FieldByName('Chassi').AsString;
    EdtPlaca.Text := DBGridMain.DataSource.DataSet.FieldByName('Placa').AsString;
    EdtCor.Text := DBGridMain.DataSource.DataSet.FieldByName('Cor').AsString;
    EdtFabrica��o.Text := DBGridMain.DataSource.DataSet.FieldByName('Fabricacao').AsString;
    ClienteNome := DBGridMain.DataSource.DataSet.FieldByName('Cliente').AsString;
    for i := 0 to CmbCliente.Items.Count - 1 do
    begin
      if CmbCliente.Items[i] = ClienteNome then
      begin
        CmbCliente.ItemIndex := i;
        Break;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar dados: ' + E.Message);
  end;
end;

procedure TFormCadastroVeiculos.BtnCancelarClick(Sender: TObject);
begin
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
    PnlRestaurar.Visible := False;
    EdtPesquisar.Visible := False;
end;

procedure TFormCadastroVeiculos.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlDesignEdit.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridVeiculos;
end;

procedure TFormCadastroVeiculos.BtnExcluirClick(Sender: TObject);
var
  VeiculoController: TVeiculoController;
  IdVeiculo: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum ve�culo selecionado!');
    Exit;
  end;
  IdVeiculo := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar este ve�culo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    VeiculoController := TVeiculoController.Create;
    VeiculoController.DeletarVeiculo(IdVeiculo);
    CarregarGrid;
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroVeiculos.BtnRestaurarGridClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroVeiculos.RestaurarVeiculos;
var
  VeiculoController: TVeiculoController;
  IdVeiculo: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum ve�culo selecionado!');
    Exit;
  end;
  IdVeiculo := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar este ve�culo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    VeiculoController := TVeiculoController.Create;
    VeiculoController.RestaurarVeiculo(IdVeiculo);
    CarregarGridRestaurar;
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarVeiculos;
  CarregarGridRestaurar;
end;

procedure TFormCadastroVeiculos.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroVeiculos.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formul�rio?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
    PnlRestaurar.Visible := False;
    EdtPesquisar.Visible := False;
end;

procedure TFormCadastroVeiculos.LblEnviarClick(Sender: TObject);
var
  VeiculoController: TVeiculoController;
  IdCategoria, IdCliente: Integer;
begin
  if ValidarCampos then
  begin
    VeiculoController := TVeiculoController.Create;
    try
      if CmbCliente.ItemIndex >= 0 then
        IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex])
      else
      begin
        ShowMessage('Selecione um cliente v�lido!');
        Exit;
      end;

      try
        VeiculoController.CadastrarVeiculo(EdtModelo.Text,EdtMarca.Text,EdtChassi.Text,EdtPlaca.Text,EdtCor.Text,EdtFabrica��o.Text,IdCliente);
        LimparCampos;
        CarregarGrid;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    finally
      VeiculoController.Free;
    end;
  end;
end;
procedure TFormCadastroVeiculos.EditarVeiculos;
var
  VeiculoController: TVeiculoController;
  Veiculo: TVeiculo;
  IdVeiculo, IdCategoria, IdCliente: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum ve�culo selecionado!');
    Exit;
  end;
  IdVeiculo := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  VeiculoController := TVeiculoController.Create;
  try
    Veiculo := TVeiculo.Create;
    try
      if not ValidarCampos then
        Exit;
      if CmbCliente.ItemIndex >= 0 then
        IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex])
      else
      begin
        ShowMessage('Selecione um cliente v�lido!');
        Exit;
      end;

      Veiculo.setIdVeiculo(IdVeiculo);
      Veiculo.setModelo(EdtModelo.Text);
      Veiculo.setMarca(EdtMarca.Text);
      Veiculo.setChassi(EdtChassi.Text);
      Veiculo.setPlaca(EdtPlaca.Text);
      Veiculo.setCor(EdtCor.Text);
      Veiculo.setFabricacao(EdtFabrica��o.Text);
      Veiculo.setCategoria(IdCategoria);
      Veiculo.setCliente(IdCliente);

      if VeiculoController.EditarVeiculo(Veiculo) then
      begin
        ShowMessage('Ve�culo atualizado com sucesso!');
        CarregarGrid;
        LimparCampos;
        PnlBackgrounEdit.Visible := False;
        PnlEdit.Visible := False;
      end;
    finally
      Veiculo.Free;
    end;
  finally
    VeiculoController.Free;
  end;
end;

procedure TFormCadastroVeiculos.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarVeiculos;
    CarregarGrid;
  end;
end;

end.
