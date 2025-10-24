unit uFormCadastroOrdensServiçoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  OrdemServicoCadastroController, OrdemServicoCadastroService, uOrdemServico,
  Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.CheckLst;

type
  TFormOrdensServiço = class(TForm)
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
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
    CmbCliente: TComboBox;
    EdtPecas: TEdit;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    EdtPreco: TEdit;
    PnlPecasUsadas: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    CheckListBoxPecas: TCheckListBox;
    Panel2: TPanel;
    LblConfirmarPeca: TLabel;
    CmbServiço: TComboBox;
    CmbFuncionario: TComboBox;
    CmbVeiculo: TComboBox;
    PnlRestaurar: TPanel;
    Label7: TLabel;
    ImgFecharRestaurar: TImage;
    ImgRestaurar: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    DataSourceRestaurar: TDataSource;

    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure EditarOrdemServico;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridOS;
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarComboBoxes;
    procedure CarregarPecasCheckList;
    function ObterPecasSelecionadas: TList<Integer>;
    procedure MarcarPecasSelecionadas(PecasIDs: TList<Integer>);
    procedure BtnSelecionarPecasClick(Sender: TObject);
    procedure BtnConfirmarPecasClick(Sender: TObject);
    procedure BtnFecharModalClick(Sender: TObject);
    procedure ImgFecharPecasClick(Sender: TObject);
    procedure EdtPecasClick(Sender: TObject);
    procedure CarregarGridRestaurar;
    procedure RestaurarOrdemServico;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure ImgFecharRestaurarClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);

  private
    PecasSelecionadas: TList<Integer>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormOrdensServiço: TFormOrdensServiço;

implementation

{$R *.dfm}

constructor TFormOrdensServiço.Create(AOwner: TComponent);
begin
  inherited;
  PecasSelecionadas := TList<Integer>.Create;
end;

destructor TFormOrdensServiço.Destroy;
begin
  PecasSelecionadas.Free;
  inherited;
end;

procedure TFormOrdensServiço.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := False;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormOrdensServiço.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  EdtPesquisar.Visible := False;
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServiço.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormOrdensServiço.BtnRestaurarClick(Sender: TObject);
begin
    PnlRestaurar.Visible := True;
    CarregarGridRestaurar;
end;

procedure TFormOrdensServiço.BtnSelecionarPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := True;
  CarregarPecasCheckList;
  if PecasSelecionadas.Count > 0 then
    MarcarPecasSelecionadas(PecasSelecionadas);
end;

procedure TFormOrdensServiço.BtnConfirmarPecasClick(Sender: TObject);
var
  i: Integer;
  IDsStr: String;
begin
  PecasSelecionadas.Clear;
  IDsStr := '';

  for i := 0 to CheckListBoxPecas.Items.Count - 1 do
  begin
    if CheckListBoxPecas.Checked[i] then
    begin
      PecasSelecionadas.Add(Integer(CheckListBoxPecas.Items.Objects[i]));
      if IDsStr <> '' then
        IDsStr := IDsStr + ', ';
      IDsStr := IDsStr + IntToStr(Integer(CheckListBoxPecas.Items.Objects[i]));
    end;
  end;
  EdtPecas.Text := IDsStr;
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServiço.BtnFecharModalClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServiço.CarregarGrid;
var
  OSService: TOrdemServicoService;
begin
  OSService := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := OSService.ListarOrdensServico;
    DBGridMain.DataSource := DataSourceMain;
    if DBGridMain.Columns.Count >= 6 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Serviço';
      DBGridMain.Columns[2].Title.Caption := 'Funcionário';
      DBGridMain.Columns[3].Title.Caption := 'Veículo';
      DBGridMain.Columns[4].Title.Caption := 'Cliente';
      DBGridMain.Columns[5].Title.Caption := 'Preço';
      for var i := 0 to 6 do
      begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    OSService.Free;
  end;
end;
procedure TFormOrdensServiço.CarregarGridRestaurar;
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    DataSourceRestaurar.DataSet := Service.ListarOrdensServicoRestaurar;
    DBGridRestaurar.DataSource := DataSourceRestaurar;
    for var i := 0 to 5 do
    begin
      DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[i].Alignment := taCenter;
      DBGridRestaurar.Columns[i].Width := 140;
      DBGridRestaurar.Columns[i].Title.Font.Size := 15;
    end;
    DBGridRestaurar.Columns[0].Width := 40;
  finally
    Service.Free;
  end;
end;


procedure TFormOrdensServiço.CarregarComboBoxes;
var
  Controller: TOrdemServicoController;
  Lista: TStringList;
  i: Integer;
begin
  Controller := TOrdemServicoController.Create;
  try
    CmbServiço.Items.Clear;
    Lista := Controller.CarregarServicos;
    try
      for i := 0 to Lista.Count - 1 do
        CmbServiço.Items.AddObject(Lista[i], Lista.Objects[i]);
    finally
      Lista.Free;
    end;

    CmbFuncionario.Items.Clear;
    Lista := Controller.CarregarFuncionarios;
    try
      for i := 0 to Lista.Count - 1 do
        CmbFuncionario.Items.AddObject(Lista[i], Lista.Objects[i]);
    finally
      Lista.Free;
    end;

    CmbVeiculo.Items.Clear;
    Lista := Controller.CarregarVeiculos;
    try
      for i := 0 to Lista.Count - 1 do
        CmbVeiculo.Items.AddObject(Lista[i], Lista.Objects[i]);
    finally
      Lista.Free;
    end;

    CmbCliente.Items.Clear;
    Lista := Controller.CarregarClientes;
    try
      for i := 0 to Lista.Count - 1 do
        CmbCliente.Items.AddObject(Lista[i], Lista.Objects[i]);
    finally
      Lista.Free;
    end;

    CmbServiço.ItemIndex := -1;
    CmbFuncionario.ItemIndex := -1;
    CmbVeiculo.ItemIndex := -1;
    CmbCliente.ItemIndex := -1;
  finally
    Controller.Free;
  end;
end;

procedure TFormOrdensServiço.CarregarPecasCheckList;
var
  Controller: TOrdemServicoController;
  Lista: TStringList;
  i: Integer;
begin
  CheckListBoxPecas.Items.Clear;
  Controller := TOrdemServicoController.Create;
  try
    Lista := Controller.CarregarPecas;
    try
      for i := 0 to Lista.Count - 1 do
        CheckListBoxPecas.Items.AddObject(Lista[i], Lista.Objects[i]);
    finally
      Lista.Free;
    end;
  finally
    Controller.Free;
  end;
end;


procedure TFormOrdensServiço.RestaurarOrdemServico;
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;
  IdOS := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar esta ordem de serviço?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TOrdemServicoController.Create;
    try
      Controller.RestaurarOrdemServico(IdOS);
      CarregarGridRestaurar;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormOrdensServiço.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarOrdemServico;
  CarregarGridRestaurar;
end;




function TFormOrdensServiço.ObterPecasSelecionadas: TList<Integer>;
begin
  Result := TList<Integer>.Create;
  Result.AddRange(PecasSelecionadas);
end;

procedure TFormOrdensServiço.MarcarPecasSelecionadas(PecasIDs: TList<Integer>);
var
  i, j: Integer;
begin
  for i := 0 to CheckListBoxPecas.Items.Count - 1 do
    CheckListBoxPecas.Checked[i] := False;

  for i := 0 to PecasIDs.Count - 1 do
  begin
    for j := 0 to CheckListBoxPecas.Items.Count - 1 do
    begin
      if Integer(CheckListBoxPecas.Items.Objects[j]) = PecasIDs[i] then
      begin
        CheckListBoxPecas.Checked[j] := True;
        Break;
      end;
    end;
  end;
end;

procedure TFormOrdensServiço.EdtPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := True;
end;

procedure TFormOrdensServiço.EdtPesquisarChange(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := Service.PesquisarOrdensServico(EdtPesquisar.Text);
    for var i := 0 to 5 do
      DBGridMain.Columns[i].Width := 140;
  finally
    Service.Free;
  end;
end;

procedure TFormOrdensServiço.PegarCamposGridOS;
var
  Preco: Currency;
  ServicoNome, FuncionarioNome, VeiculoPlaca, ClienteNome: String;
  i, IdOS: Integer;
  Controller: TOrdemServicoController;
  PecasIDs: TList<Integer>;
  IDsStr: String;
begin
  try
    ServicoNome := DBGridMain.DataSource.DataSet.FieldByName('Serviço').AsString;
    for i := 0 to CmbServiço.Items.Count - 1 do
      if CmbServiço.Items[i] = ServicoNome then begin CmbServiço.ItemIndex := i; Break; end;

    FuncionarioNome := DBGridMain.DataSource.DataSet.FieldByName('Funcionário').AsString;
    for i := 0 to CmbFuncionario.Items.Count - 1 do
      if CmbFuncionario.Items[i] = FuncionarioNome then begin CmbFuncionario.ItemIndex := i; Break; end;

    VeiculoPlaca := DBGridMain.DataSource.DataSet.FieldByName('Veículo').AsString;
    for i := 0 to CmbVeiculo.Items.Count - 1 do
      if CmbVeiculo.Items[i] = VeiculoPlaca then begin CmbVeiculo.ItemIndex := i; Break; end;

    ClienteNome := DBGridMain.DataSource.DataSet.FieldByName('Cliente').AsString;
    for i := 0 to CmbCliente.Items.Count - 1 do
      if CmbCliente.Items[i] = ClienteNome then begin CmbCliente.ItemIndex := i; Break; end;

    Preco := DBGridMain.DataSource.DataSet.FieldByName('Preço').AsCurrency;
    EdtPreco.Text := CurrToStr(Preco);

    IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
    Controller := TOrdemServicoController.Create;
    try
      PecasIDs := Controller.CarregarPecasDaOS(IdOS);
      try
        PecasSelecionadas.Clear;
        PecasSelecionadas.AddRange(PecasIDs);

        IDsStr := '';
        for i := 0 to PecasIDs.Count - 1 do
        begin
          if IDsStr <> '' then
            IDsStr := IDsStr + ', ';
          IDsStr := IDsStr + IntToStr(PecasIDs[i]);
        end;
        EdtPecas.Text := IDsStr;
      finally
        PecasIDs.Free;
      end;
    finally
      Controller.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar dados: ' + E.Message);
  end;
end;

procedure TFormOrdensServiço.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridOS;
end;

procedure TFormOrdensServiço.BtnExcluirClick(Sender: TObject);
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;
  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar esta ordem de serviço?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TOrdemServicoController.Create;
    try
      Controller.DeletarOrdemServico(IdOS);
      CarregarGrid;
    finally
      Controller.Free;
    end;
  end;
end;


procedure TFormOrdensServiço.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarOrdemServico;
    CarregarGrid;
  end;
end;

procedure TFormOrdensServiço.LblEnviarClick(Sender: TObject);
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  Preco: Currency;
  IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  PecasIDs: TList<Integer>;
begin
  if ValidarCampos then
  begin
    Controller := TOrdemServicoController.Create;
    try
      Preco := StrToCurr(EdtPreco.Text);

      IdServico := Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects[CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);

      OrdemServico := Controller.CriarObjeto(IdServico, IdFuncionario, IdVeiculo, IdCliente, Preco, True);
      try
        PecasIDs := ObterPecasSelecionadas;
        try
          Controller.SalvarOrdemServico(OrdemServico, PecasIDs);
          ShowMessage('Ordem de serviço cadastrada com sucesso!');
          LimparCampos;
          CarregarGrid;
        finally
          PecasIDs.Free;
        end;
      finally
        OrdemServico.Free;
      end;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormOrdensServiço.EditarOrdemServico;
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  IdOS, IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  Preco: Currency;
  PecasIDs: TList<Integer>;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;

  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  Controller := TOrdemServicoController.Create;
  try
    OrdemServico := TOrdemServico.Create;
    try
      if not ValidarCampos then Exit;

      Preco := StrToCurr(EdtPreco.Text);
      IdServico := Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects[CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);

      OrdemServico.setIdOrdemServico(IdOS);
      OrdemServico.setIdServico(IdServico);
      OrdemServico.setIdFuncionario(IdFuncionario);
      OrdemServico.setIdVeiculo(IdVeiculo);
      OrdemServico.setIdCliente(IdCliente);
      OrdemServico.setPreco(Preco);
      OrdemServico.setAtivo(True);

      PecasIDs := ObterPecasSelecionadas;
      try
        Controller.EditarOrdemServico(OrdemServico, PecasIDs);
        ShowMessage('Ordem de serviço atualizada com sucesso!');
        CarregarGrid;
        LimparCampos;
        PnlBackgrounEdit.Visible := False;
        PnlEdit.Visible := False;
      finally
        PecasIDs.Free;
      end;
    finally
      OrdemServico.Free;
    end;
  finally
    Controller.Free;
  end;
end;





procedure TFormOrdensServiço.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormOrdensServiço.FormCreate(Sender: TObject);
begin
  CmbServiço.Height := 31;
  CmbFuncionario.Height := 31;
  CmbVeiculo.Height := 31;
  CmbCliente.Height := 31;
  EdtPreco.Height := 31;
  EdtPecas.Height := 31;
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServiço.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarComboBoxes;
  CarregarPecasCheckList;
end;

procedure TFormOrdensServiço.ImgFecharPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServiço.ImgFecharRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

function TFormOrdensServiço.ValidarCampos: Boolean;
begin
  Result := False;
  if CmbServiço.ItemIndex = -1 then begin ShowMessage('Selecione um Serviço válido'); Exit; end;
  if CmbFuncionario.ItemIndex = -1 then begin ShowMessage('Selecione um Funcionário válido'); Exit; end;
  if CmbVeiculo.ItemIndex = -1 then begin ShowMessage('Selecione um Veículo válido'); Exit; end;
  if CmbCliente.ItemIndex = -1 then begin ShowMessage('Selecione um Cliente válido'); Exit; end;
  if EdtPreco.Text = '' then begin ShowMessage('O campo Preço não pode ficar vazio'); Exit; end;
  Result := True;
end;

procedure TFormOrdensServiço.LimparCampos;
begin
  EdtPreco.Clear;
  EdtPecas.Clear;
  CmbServiço.ItemIndex := -1;
  CmbFuncionario.ItemIndex := -1;
  CmbVeiculo.ItemIndex := -1;
  CmbCliente.ItemIndex := -1;
  PecasSelecionadas.Clear;
end;

end.
