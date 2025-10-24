unit uFormCadastroOrdensServi�oView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  OrdemServicoCadastroController, OrdemServicoCadastroService, uOrdemServico,
  Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.CheckLst;

type
  TFormOrdensServi�o = class(TForm)
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
    CmbServi�o: TComboBox;
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
  FormOrdensServi�o: TFormOrdensServi�o;

implementation

{$R *.dfm}

constructor TFormOrdensServi�o.Create(AOwner: TComponent);
begin
  inherited;
  PecasSelecionadas := TList<Integer>.Create;
end;

destructor TFormOrdensServi�o.Destroy;
begin
  PecasSelecionadas.Free;
  inherited;
end;

procedure TFormOrdensServi�o.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := False;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;

procedure TFormOrdensServi�o.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  EdtPesquisar.Visible := False;
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServi�o.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormOrdensServi�o.BtnRestaurarClick(Sender: TObject);
begin
    PnlRestaurar.Visible := True;
    CarregarGridRestaurar;
end;

procedure TFormOrdensServi�o.BtnSelecionarPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := True;
  CarregarPecasCheckList;
  if PecasSelecionadas.Count > 0 then
    MarcarPecasSelecionadas(PecasSelecionadas);
end;

procedure TFormOrdensServi�o.BtnConfirmarPecasClick(Sender: TObject);
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

procedure TFormOrdensServi�o.BtnFecharModalClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServi�o.CarregarGrid;
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
      DBGridMain.Columns[1].Title.Caption := 'Servi�o';
      DBGridMain.Columns[2].Title.Caption := 'Funcion�rio';
      DBGridMain.Columns[3].Title.Caption := 'Ve�culo';
      DBGridMain.Columns[4].Title.Caption := 'Cliente';
      DBGridMain.Columns[5].Title.Caption := 'Pre�o';
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
procedure TFormOrdensServi�o.CarregarGridRestaurar;
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


procedure TFormOrdensServi�o.CarregarComboBoxes;
var
  Controller: TOrdemServicoController;
  Lista: TStringList;
  i: Integer;
begin
  Controller := TOrdemServicoController.Create;
  try
    CmbServi�o.Items.Clear;
    Lista := Controller.CarregarServicos;
    try
      for i := 0 to Lista.Count - 1 do
        CmbServi�o.Items.AddObject(Lista[i], Lista.Objects[i]);
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

    CmbServi�o.ItemIndex := -1;
    CmbFuncionario.ItemIndex := -1;
    CmbVeiculo.ItemIndex := -1;
    CmbCliente.ItemIndex := -1;
  finally
    Controller.Free;
  end;
end;

procedure TFormOrdensServi�o.CarregarPecasCheckList;
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


procedure TFormOrdensServi�o.RestaurarOrdemServico;
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de servi�o selecionada!');
    Exit;
  end;
  IdOS := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar esta ordem de servi�o?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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

procedure TFormOrdensServi�o.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarOrdemServico;
  CarregarGridRestaurar;
end;




function TFormOrdensServi�o.ObterPecasSelecionadas: TList<Integer>;
begin
  Result := TList<Integer>.Create;
  Result.AddRange(PecasSelecionadas);
end;

procedure TFormOrdensServi�o.MarcarPecasSelecionadas(PecasIDs: TList<Integer>);
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

procedure TFormOrdensServi�o.EdtPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := True;
end;

procedure TFormOrdensServi�o.EdtPesquisarChange(Sender: TObject);
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

procedure TFormOrdensServi�o.PegarCamposGridOS;
var
  Preco: Currency;
  ServicoNome, FuncionarioNome, VeiculoPlaca, ClienteNome: String;
  i, IdOS: Integer;
  Controller: TOrdemServicoController;
  PecasIDs: TList<Integer>;
  IDsStr: String;
begin
  try
    ServicoNome := DBGridMain.DataSource.DataSet.FieldByName('Servi�o').AsString;
    for i := 0 to CmbServi�o.Items.Count - 1 do
      if CmbServi�o.Items[i] = ServicoNome then begin CmbServi�o.ItemIndex := i; Break; end;

    FuncionarioNome := DBGridMain.DataSource.DataSet.FieldByName('Funcion�rio').AsString;
    for i := 0 to CmbFuncionario.Items.Count - 1 do
      if CmbFuncionario.Items[i] = FuncionarioNome then begin CmbFuncionario.ItemIndex := i; Break; end;

    VeiculoPlaca := DBGridMain.DataSource.DataSet.FieldByName('Ve�culo').AsString;
    for i := 0 to CmbVeiculo.Items.Count - 1 do
      if CmbVeiculo.Items[i] = VeiculoPlaca then begin CmbVeiculo.ItemIndex := i; Break; end;

    ClienteNome := DBGridMain.DataSource.DataSet.FieldByName('Cliente').AsString;
    for i := 0 to CmbCliente.Items.Count - 1 do
      if CmbCliente.Items[i] = ClienteNome then begin CmbCliente.ItemIndex := i; Break; end;

    Preco := DBGridMain.DataSource.DataSet.FieldByName('Pre�o').AsCurrency;
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

procedure TFormOrdensServi�o.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridOS;
end;

procedure TFormOrdensServi�o.BtnExcluirClick(Sender: TObject);
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de servi�o selecionada!');
    Exit;
  end;
  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar esta ordem de servi�o?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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


procedure TFormOrdensServi�o.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    EditarOrdemServico;
    CarregarGrid;
  end;
end;

procedure TFormOrdensServi�o.LblEnviarClick(Sender: TObject);
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

      IdServico := Integer(CmbServi�o.Items.Objects[CmbServi�o.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects[CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);

      OrdemServico := Controller.CriarObjeto(IdServico, IdFuncionario, IdVeiculo, IdCliente, Preco, True);
      try
        PecasIDs := ObterPecasSelecionadas;
        try
          Controller.SalvarOrdemServico(OrdemServico, PecasIDs);
          ShowMessage('Ordem de servi�o cadastrada com sucesso!');
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

procedure TFormOrdensServi�o.EditarOrdemServico;
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  IdOS, IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  Preco: Currency;
  PecasIDs: TList<Integer>;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhuma ordem de servi�o selecionada!');
    Exit;
  end;

  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  Controller := TOrdemServicoController.Create;
  try
    OrdemServico := TOrdemServico.Create;
    try
      if not ValidarCampos then Exit;

      Preco := StrToCurr(EdtPreco.Text);
      IdServico := Integer(CmbServi�o.Items.Objects[CmbServi�o.ItemIndex]);
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
        ShowMessage('Ordem de servi�o atualizada com sucesso!');
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





procedure TFormOrdensServi�o.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formul�rio?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormOrdensServi�o.FormCreate(Sender: TObject);
begin
  CmbServi�o.Height := 31;
  CmbFuncionario.Height := 31;
  CmbVeiculo.Height := 31;
  CmbCliente.Height := 31;
  EdtPreco.Height := 31;
  EdtPecas.Height := 31;
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServi�o.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarComboBoxes;
  CarregarPecasCheckList;
end;

procedure TFormOrdensServi�o.ImgFecharPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := False;
end;

procedure TFormOrdensServi�o.ImgFecharRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

function TFormOrdensServi�o.ValidarCampos: Boolean;
begin
  Result := False;
  if CmbServi�o.ItemIndex = -1 then begin ShowMessage('Selecione um Servi�o v�lido'); Exit; end;
  if CmbFuncionario.ItemIndex = -1 then begin ShowMessage('Selecione um Funcion�rio v�lido'); Exit; end;
  if CmbVeiculo.ItemIndex = -1 then begin ShowMessage('Selecione um Ve�culo v�lido'); Exit; end;
  if CmbCliente.ItemIndex = -1 then begin ShowMessage('Selecione um Cliente v�lido'); Exit; end;
  if EdtPreco.Text = '' then begin ShowMessage('O campo Pre�o n�o pode ficar vazio'); Exit; end;
  Result := True;
end;

procedure TFormOrdensServi�o.LimparCampos;
begin
  EdtPreco.Clear;
  EdtPecas.Clear;
  CmbServi�o.ItemIndex := -1;
  CmbFuncionario.ItemIndex := -1;
  CmbVeiculo.ItemIndex := -1;
  CmbCliente.ItemIndex := -1;
  PecasSelecionadas.Clear;
end;

end.
