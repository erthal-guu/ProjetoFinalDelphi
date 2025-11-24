unit uFormCadastroOrdensServiçoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  OrdemServicoCadastroController, OrdemServicoCadastroService, uOrdemServico,
  Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.CheckLst,
  Vcl.ComCtrls, uSession, uFormReceitasView;

type
  TFormCadastroOrdensServiço = class(TForm)
    DataSourceMain: TDataSource;
    DataSourceRestaurar: TDataSource;
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
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlPecasUsadas: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    CheckListBoxPecas: TCheckListBox;
    Panel2: TPanel;
    LblConfirmarPeca: TLabel;
    PnlRestaurar: TPanel;
    Label7: TLabel;
    ImgFecharRestaurar: TImage;
    ImgRestaurar: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    CmbCliente: TComboBox;
    EdtPecas: TEdit;
    CmbServiço: TComboBox;
    CmbFuncionario: TComboBox;
    CmbVeiculo: TComboBox;
    DtimeIncio: TDateTimePicker;
    EdtPreco: TEdit;
    EdtObservacao: TEdit;
    DTimeConclusao: TDateTimePicker;
    Image1: TImage;
    Label11: TLabel;
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    Image6: TImage;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    Image2: TImage;

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
    procedure BtnConfirmarPecasClick(Sender: TObject);
    procedure BtnFecharModalClick(Sender: TObject);
    procedure ImgFecharPecasClick(Sender: TObject);
    procedure EdtPecasClick(Sender: TObject);
    procedure CarregarGridRestaurar;
    procedure RestaurarOrdemServico;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure ImgFecharRestaurarClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure RecalcularPreco;
    procedure CmbServiçoChange(Sender: TObject);
    procedure CmbFuncionarioChange(Sender: TObject);
    procedure CmbVeiculoChange(Sender: TObject);
    procedure EdtPrecoClick(Sender: TObject);
    procedure EdtObservacaoClick(Sender: TObject);
    procedure DtimeIncioClick(Sender: TObject);
    procedure DTimeConclusaoClick(Sender: TObject);
    procedure CmbClienteChange(Sender: TObject);
    procedure configurarGrid;
    procedure AplicarPermissoes(const Grupo: string);
    procedure ExcluirOrdemServico;
    procedure CadastrarOrdemServico;

  private
    PecasSelecionadas: TList<Integer>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormCadastroOrdensServiço: TFormCadastroOrdensServiço;

implementation

{$R *.dfm}

constructor TFormCadastroOrdensServiço.Create(AOwner: TComponent);
begin
  inherited;
  PecasSelecionadas := TList<Integer>.Create;
end;

destructor TFormCadastroOrdensServiço.Destroy;
begin
  PecasSelecionadas.Free;
  inherited;
end;

procedure TFormCadastroOrdensServiço.DTimeConclusaoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.DtimeIncioClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.AplicarPermissoes(const Grupo: string);
begin
  if LowerCase(Trim(Grupo)) = 'mecânico' then begin
    if DBGridMain.Columns.Count > 5 then
      DBGridMain.Columns[5].Visible := false;
  end;
end;

procedure TFormCadastroOrdensServiço.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  EdtPesquisar.Visible := false;
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := false;
end;

procedure TFormCadastroOrdensServiço.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := false;
  PnlEdit.Visible := false;
  EdtPesquisar.Visible := false;
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlBackgrounEdit.Visible := false;
end;

procedure TFormCadastroOrdensServiço.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroOrdensServiço.BtnConfirmarPecasClick(Sender: TObject);
var
  i: Integer;
  IDsStr: String;
begin
  PecasSelecionadas.Clear;
  IDsStr := '';

  for i := 0 to CheckListBoxPecas.Items.Count - 1 do begin
    if CheckListBoxPecas.Checked[i] then begin
      PecasSelecionadas.Add(Integer(CheckListBoxPecas.Items.Objects[i]));
      if IDsStr <> '' then
        IDsStr := IDsStr + ', ';
      IDsStr := IDsStr + IntToStr(Integer(CheckListBoxPecas.Items.Objects[i]));
    end;
  end;

  EdtPecas.Text := IDsStr;
  PnlPecasUsadas.Visible := false;
  RecalcularPreco;
  CheckListBoxPecas.Clear;
  CarregarPecasCheckList;
end;

procedure TFormCadastroOrdensServiço.BtnFecharModalClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.CarregarGrid;
var
  OSService: TOrdemServicoService;
begin
  OSService := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := OSService.ListarOrdensServico;
    DBGridMain.DataSource := DataSourceMain;
    configurarGrid;
  finally
    OSService.Free;
  end;
end;

procedure TFormCadastroOrdensServiço.CarregarGridRestaurar;
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    DataSourceRestaurar.DataSet := Service.ListarOrdensServicoRestaurar;
    DBGridRestaurar.DataSource := DataSourceRestaurar;
    configurarGrid;
  finally
    Service.Free;
  end;
end;

procedure TFormCadastroOrdensServiço.CadastrarOrdemServico;
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  Preco: Currency;
  IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  PecasIDs: TList<Integer>;
  OrdensServicoID: Integer;
begin
  if ValidarCampos then begin
    Controller := TOrdemServicoController.Create;
    try
      IdServico := Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects[CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);
      try
        var ControllerCalcular := TOrdemServicoController.Create;
        try
          Preco := ControllerCalcular.CalcularPrecoTotal
            (Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]),
            PecasSelecionadas,
            Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]));
        finally
          ControllerCalcular.Free;
        end;
      except
        Preco := 0;
      end;

      OrdemServico := Controller.CriarObjeto(IdServico, IdFuncionario,
        IdVeiculo, IdCliente, Preco, True, EdtObservacao.Text, DtimeIncio.Date,DTimeConclusao.Date);
      try
        PecasIDs := ObterPecasSelecionadas;
        try
          Controller.SalvarOrdemServico(OrdemServico, PecasIDs);
          CarregarGrid;
          LimparCampos;
          PnlBackgrounEdit.Visible := false;
          PnlEdit.Visible := false;
          ShowMessage('Ordem de serviço cadastrada com sucesso!');
          Sleep(1000);
          ShowMessage('Receita Financeira gerada com sucesso!');
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

procedure TFormCadastroOrdensServiço.CarregarComboBoxes;
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

procedure TFormCadastroOrdensServiço.CarregarPecasCheckList;
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

procedure TFormCadastroOrdensServiço.CmbClienteChange(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.CmbFuncionarioChange(Sender: TObject);
begin
  RecalcularPreco;
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.CmbServiçoChange(Sender: TObject);
begin
  RecalcularPreco;
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.CmbVeiculoChange(Sender: TObject);
var
  Controller: TOrdemServicoController;
  IdVeiculo, IdCliente: Integer;
  i: Integer;
begin
  RecalcularPreco;
  if CmbVeiculo.ItemIndex >= 0 then begin
    IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);

    Controller := TOrdemServicoController.Create;
    try
      IdCliente := Controller.ObterClienteDoVeiculo(IdVeiculo);
      if IdCliente > 0 then begin
        for i := 0 to CmbCliente.Items.Count - 1 do begin
          if Integer(CmbCliente.Items.Objects[i]) = IdCliente then begin
            CmbCliente.ItemIndex := i;
            Break;
          end;
        end;
      end;
    finally
      Controller.Free;
    end;
  end;
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.configurarGrid;
begin
  if DBGridMain.Columns.Count >= 9 then begin
    DBGridMain.Columns[0].Title.Caption := 'Id';
    DBGridMain.Columns[1].Title.Caption := 'Serviço';
    DBGridMain.Columns[2].Title.Caption := 'Funcionário';
    DBGridMain.Columns[3].Title.Caption := 'Veículo';
    DBGridMain.Columns[4].Title.Caption := 'Cliente';
    DBGridMain.Columns[5].Title.Caption := 'Preço';
    DBGridMain.Columns[6].Title.Caption := 'Observação';
    DBGridMain.Columns[7].Title.Caption := 'Data Início';
    DBGridMain.Columns[8].Title.Caption := 'Data Conclusão';
    DBGridMain.Columns[9].Title.Caption := 'Ativo';

    for var i := 0 to 9 do begin
      DBGridMain.Columns[i].Title.Alignment := taCenter;
      DBGridMain.Columns[i].Alignment := taCenter;
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;
    DBGridMain.Columns[0].Width := 50;
    DBGridMain.Columns[1].Width := 200;
    DBGridMain.Columns[6].Width := 200;
  end;
  if LowerCase(Trim(uSession.UsuarioLogadoGrupo)) = 'mecânico' then begin
    if DBGridMain.Columns.Count > 5 then
      DBGridMain.Columns[5].Visible := false;
  end;
end;

procedure TFormCadastroOrdensServiço.RecalcularPreco;
var
  Controller: TOrdemServicoController;
  PrecoCalculado: Currency;
begin
  if (CmbServiço.ItemIndex >= 0) and (CmbVeiculo.ItemIndex >= 0) then begin
    Controller := TOrdemServicoController.Create;
    try
      PrecoCalculado := Controller.CalcularPrecoTotal
        (Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]),
        PecasSelecionadas,
        Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]));
      EdtPreco.Text := StringReplace(FormatFloat('0.00', PrecoCalculado),
        '.', ',', []);
    finally
      Controller.Free;
    end;
  end
  else begin
    EdtPreco.Text := '0,00';
  end;
end;

procedure TFormCadastroOrdensServiço.RestaurarOrdemServico;
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;
  IdOS := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente restaurar esta ordem de serviço?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Controller := TOrdemServicoController.Create;
    try
      Controller.RestaurarOrdemServico(IdOS);
      CarregarGridRestaurar;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormCadastroOrdensServiço.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarOrdemServico;
  CarregarGridRestaurar;
end;

function TFormCadastroOrdensServiço.ObterPecasSelecionadas: TList<Integer>;
begin
  Result := TList<Integer>.Create;
  Result.AddRange(PecasSelecionadas);
end;

procedure TFormCadastroOrdensServiço.MarcarPecasSelecionadas(PecasIDs: TList<Integer>);
var
  i, j: Integer;
begin
  for i := 0 to CheckListBoxPecas.Items.Count - 1 do
    CheckListBoxPecas.Checked[i] := false;
  for i := 0 to PecasIDs.Count - 1 do begin
    for j := 0 to CheckListBoxPecas.Items.Count - 1 do begin
      if Integer(CheckListBoxPecas.Items.Objects[j]) = PecasIDs[i] then begin
        CheckListBoxPecas.Checked[j] := True;
        Break;
      end;
    end;
  end;
end;

procedure TFormCadastroOrdensServiço.EdtObservacaoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.EdtPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := True;
  CarregarPecasCheckList;
  if PecasSelecionadas.Count > 0 then
    MarcarPecasSelecionadas(PecasSelecionadas);
end;

procedure TFormCadastroOrdensServiço.EdtPesquisarChange(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := Service.PesquisarOrdensServico(EdtPesquisar.Text);
    if DBGridMain.Columns.Count >= 9 then begin
    DBGridMain.Columns[0].Title.Caption := 'Id';
    DBGridMain.Columns[1].Title.Caption := 'Serviço';
    DBGridMain.Columns[2].Title.Caption := 'Funcionário';
    DBGridMain.Columns[3].Title.Caption := 'Veículo';
    DBGridMain.Columns[4].Title.Caption := 'Cliente';
    DBGridMain.Columns[5].Title.Caption := 'Preço';
    DBGridMain.Columns[6].Title.Caption := 'Observação';
    DBGridMain.Columns[7].Title.Caption := 'Data Início';
    DBGridMain.Columns[8].Title.Caption := 'Data Conclusão';
    DBGridMain.Columns[9].Title.Caption := 'Ativo';

    for var i := 0 to 9 do begin
      DBGridMain.Columns[i].Title.Alignment := taCenter;
      DBGridMain.Columns[i].Alignment := taCenter;
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;

    DBGridMain.Columns[0].Width := 50;
    DBGridMain.Columns[1].Width := 200;
    DBGridMain.Columns[6].Width := 200;
  end;
  finally
    Service.Free;
  end;
end;

procedure TFormCadastroOrdensServiço.EdtPrecoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServiço.ExcluirOrdemServico;
var
  Controller: TOrdemServicoController;
  IdOS: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;
  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  if MessageDlg('Deseja realmente deletar esta ordem de serviço?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Controller := TOrdemServicoController.Create;
    try
      Controller.DeletarOrdemServico(IdOS);
      CarregarGrid;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormCadastroOrdensServiço.PegarCamposGridOS;
var
  Preco: Currency;
  ServicoNome, FuncionarioNome, VeiculoPlaca, ClienteNome: String;
  i, IdOS: Integer;
  Controller: TOrdemServicoController;
  PecasIDs: TList<Integer>;
  IDsStr: String;
begin
  try
    ServicoNome := DBGridMain.DataSource.DataSet.FieldByName('servico_nome')
      .AsString;
    for i := 0 to CmbServiço.Items.Count - 1 do
      if CmbServiço.Items[i] = ServicoNome then begin
        CmbServiço.ItemIndex := i;
        Break;
      end;

    FuncionarioNome := DBGridMain.DataSource.DataSet.FieldByName
      ('funcionario_nome').AsString;
    for i := 0 to CmbFuncionario.Items.Count - 1 do
      if CmbFuncionario.Items[i] = FuncionarioNome then begin
        CmbFuncionario.ItemIndex := i;
        Break;
      end;

    VeiculoPlaca := DBGridMain.DataSource.DataSet.FieldByName
      ('veiculo_placa').AsString;
    for i := 0 to CmbVeiculo.Items.Count - 1 do
      if CmbVeiculo.Items[i] = VeiculoPlaca then begin
        CmbVeiculo.ItemIndex := i;
        Break;
      end;

    ClienteNome := DBGridMain.DataSource.DataSet.FieldByName('cliente_nome')
      .AsString;
    for i := 0 to CmbCliente.Items.Count - 1 do
      if CmbCliente.Items[i] = ClienteNome then begin
        CmbCliente.ItemIndex := i;
        Break;
      end;

    Preco := DBGridMain.DataSource.DataSet.FieldByName('preco').AsCurrency;
    EdtPreco.Text := CurrToStr(Preco);

    EdtObservacao.Text := DBGridMain.DataSource.DataSet.FieldByName
      ('Observacao').AsString;
    DtimeIncio.Date := DBGridMain.DataSource.DataSet.FieldByName('data_inicio')
      .AsDateTime;
    DTimeConclusao.Date := DBGridMain.DataSource.DataSet.FieldByName
      ('data_conclusao').AsDateTime;

    IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
    Controller := TOrdemServicoController.Create;
    try
      PecasIDs := Controller.CarregarPecasDaOS(IdOS);
      try
        PecasSelecionadas.Clear;
        PecasSelecionadas.AddRange(PecasIDs);
        IDsStr := '';
        for i := 0 to PecasIDs.Count - 1 do begin
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

procedure TFormCadastroOrdensServiço.BtnEditarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := false;
  PegarCamposGridOS;
end;

procedure TFormCadastroOrdensServiço.BtnExcluirClick(Sender: TObject);
begin
  ExcluirOrdemServico;
end;

procedure TFormCadastroOrdensServiço.LblAtualizarClick(Sender: TObject);
begin
  if ValidarCampos then begin
    EditarOrdemServico;
    CarregarGrid;
    FormReceitas.CarregarGrid;
  end;
end;

procedure TFormCadastroOrdensServiço.LblEnviarClick(Sender: TObject);
begin
  CadastrarOrdemServico;
end;

procedure TFormCadastroOrdensServiço.EditarOrdemServico;
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  IdOS, IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  Preco: Currency;
  PecasIDs: TList<Integer>;
begin
  if DataSourceMain.DataSet.IsEmpty then begin
    ShowMessage('Nenhuma ordem de serviço selecionada!');
    Exit;
  end;

  IdOS := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
  Controller := TOrdemServicoController.Create;
  try
    OrdemServico := TOrdemServico.Create;
    try
      if not ValidarCampos then
        Exit;

      IdServico := Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects
        [CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);
      try
        var ControllerCalc := TOrdemServicoController.Create;
        try
          Preco := ControllerCalc.CalcularPrecoTotal
            (Integer(CmbServiço.Items.Objects[CmbServiço.ItemIndex]),
            PecasSelecionadas,
            Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]));
        finally
          ControllerCalc.Free;
        end;
      except
        Preco := 0;
      end;

      OrdemServico.setIdOrdemServico(IdOS);
      OrdemServico.setIdServico(IdServico);
      OrdemServico.setIdFuncionario(IdFuncionario);
      OrdemServico.setIdVeiculo(IdVeiculo);
      OrdemServico.setIdCliente(IdCliente);
      OrdemServico.setPreco(Preco);
      OrdemServico.setAtivo(True);
      OrdemServico.setObservacao(EdtObservacao.Text);
      OrdemServico.setDataInicio(DtimeIncio.Date);
      OrdemServico.setDataConclusao(DTimeConclusao.Date);

      PecasIDs := ObterPecasSelecionadas;
      try
        Controller.EditarOrdemServico(OrdemServico, PecasIDs);
        ShowMessage('Ordem de serviço Recasdatrada com sucesso!');
        CarregarGrid;
        LimparCampos;
        Sleep(1000);
        ShowMessage('Receita Financeira gerada novamente com sucesso !');
        PnlBackgrounEdit.Visible := false;
        PnlEdit.Visible := false;
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

procedure TFormCadastroOrdensServiço.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    PnlBackgrounEdit.Visible := false;
  PnlEdit.Visible := false;
  EdtPesquisar.Visible := false;
  PnlPecasUsadas.Visible := false;
  Close;
end;

procedure TFormCadastroOrdensServiço.FormCreate(Sender: TObject);
begin
  CmbServiço.Height := 31;
  CmbFuncionario.Height := 31;
  CmbVeiculo.Height := 31;
  CmbCliente.Height := 31;
  EdtPreco.Height := 31;
  EdtPecas.Height := 31;
  EdtObservacao.Height := 31;
  DtimeIncio.Height := 31;
  DTimeConclusao.Height := 31;
  PnlPecasUsadas.Visible := false;
  PnlButtonAtualizar.Height := 31;
  PnlButtonEnviar.Height := 31;
end;

procedure TFormCadastroOrdensServiço.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarComboBoxes;
  CarregarPecasCheckList;
  configurarGrid;
end;

procedure TFormCadastroOrdensServiço.ImgFecharPecasClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
  CheckListBoxPecas.ClearSelection;
end;

procedure TFormCadastroOrdensServiço.ImgFecharRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := false;
  CarregarGrid;
end;

function TFormCadastroOrdensServiço.ValidarCampos: Boolean;
begin
  Result := false;
  if CmbServiço.ItemIndex = -1 then begin
    ShowMessage('Selecione um Serviço válido');
    Exit;
  end;
  if CmbFuncionario.ItemIndex = -1 then begin
    ShowMessage('Selecione um Funcionário válido');
    Exit;
  end;
  if CmbVeiculo.ItemIndex = -1 then begin
    ShowMessage('Selecione um Veículo válido');
    Exit;
  end;
  if CmbCliente.ItemIndex = -1 then begin
    ShowMessage('Selecione um Cliente válido');
    Exit;
  end;
  if EdtPreco.Text = '' then begin
    ShowMessage('O campo Preço não pode ficar vazio');
    Exit;
  end;
  Result := True;
end;

procedure TFormCadastroOrdensServiço.LimparCampos;
begin
  EdtPreco.Clear;
  EdtPecas.Clear;
  EdtObservacao.Clear;
  CmbServiço.ItemIndex := -1;
  CmbFuncionario.ItemIndex := -1;
  CmbVeiculo.ItemIndex := -1;
  CmbCliente.ItemIndex := -1;
  DtimeIncio.Date := Now;
  DTimeConclusao.Date := Now;
  PecasSelecionadas.Clear;
end;

end.
