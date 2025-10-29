  unit uFormCadastroOrdensServi�oView;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
    Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
    OrdemServicoCadastroController, OrdemServicoCadastroService, uOrdemServico,
    Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.CheckLst,
  Vcl.ComCtrls,uSession,uFormReceitasView;

  type
    TFormCadastroOrdensServi�o = class(TForm)
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
    Image1: TImage;
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
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    CmbCliente: TComboBox;
    EdtPecas: TEdit;
    CmbServi�o: TComboBox;
    CmbFuncionario: TComboBox;
    CmbVeiculo: TComboBox;
    DtimeIncio: TDateTimePicker;
    EdtPreco: TEdit;
    EdtObservacao: TEdit;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    DTimeConclusao: TDateTimePicker;

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
      procedure RecalcularPreco;
      procedure CmbServi�oChange(Sender: TObject);
      procedure CmbFuncionarioChange(Sender: TObject);
      procedure CmbVeiculoChange(Sender: TObject);
      function ConverterPrecoParaCurrency(const ATexto: String): Currency;
      procedure EdtPrecoClick(Sender: TObject);
      procedure EdtObservacaoClick(Sender: TObject);
      procedure DtimeIncioClick(Sender: TObject);
      procedure DTimeConclusaoClick(Sender: TObject);
      procedure CmbClienteChange(Sender: TObject);
      procedure configurarGrid;

    private
      PecasSelecionadas: TList<Integer>;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure AplicarPermissoes(const Grupo: string);
    end;

  var
    FormCadastroOrdensServi�o: TFormCadastroOrdensServi�o;

  implementation

  {$R *.dfm}

  constructor TFormCadastroOrdensServi�o.Create(AOwner: TComponent);
  begin
    inherited;
    PecasSelecionadas := TList<Integer>.Create;
  end;

  destructor TFormCadastroOrdensServi�o.Destroy;
  begin
    PecasSelecionadas.Free;
    inherited;
  end;

  procedure TFormCadastroOrdensServi�o.DTimeConclusaoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServi�o.DtimeIncioClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServi�o.AplicarPermissoes(const Grupo: string);
begin
  if LowerCase(Trim(Grupo)) = 'mec�nico' then
  begin
    if DBGridMain.Columns.Count > 5 then
      DBGridMain.Columns[5].Visible := False;
  end;
end;

procedure TFormCadastroOrdensServi�o.BtnAdicionarClick(Sender: TObject);
  begin
    PnlBackgrounEdit.Visible := True;
    PnlEdit.Visible := True;
    EdtPesquisar.Visible := False;
    LimparCampos;
    PnlButtonEnviar.Visible := True;
    PnlButtonAtualizar.Visible := False;
  end;

  procedure TFormCadastroOrdensServi�o.BtnCancelarClick(Sender: TObject);
  begin
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
    EdtPesquisar.Visible := False;
    PnlPecasUsadas.Visible := False;
  end;

  procedure TFormCadastroOrdensServi�o.BtnPesquisarClick(Sender: TObject);
  begin
    EdtPesquisar.Visible := True;
    PnlBackgrounEdit.Visible := False;
  end;

  procedure TFormCadastroOrdensServi�o.BtnRestaurarClick(Sender: TObject);
  begin
      PnlRestaurar.Visible := True;
      CarregarGridRestaurar;
  end;

  procedure TFormCadastroOrdensServi�o.BtnSelecionarPecasClick(Sender: TObject);
  begin
    PnlPecasUsadas.Visible := True;
    CarregarPecasCheckList;
    if PecasSelecionadas.Count > 0 then
      MarcarPecasSelecionadas(PecasSelecionadas);
  end;

procedure TFormCadastroOrdensServi�o.BtnConfirmarPecasClick(Sender: TObject);
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
  RecalcularPreco;
end;

  procedure TFormCadastroOrdensServi�o.BtnFecharModalClick(Sender: TObject);
  begin
    PnlPecasUsadas.Visible := False;
  end;

  procedure TFormCadastroOrdensServi�o.CarregarGrid;
var
  OSService: TOrdemServicoService;
begin
  OSService := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := OSService.ListarOrdensServico;
    DBGridMain.DataSource := DataSourceMain;
    ConfigurarGrid;
  finally
    OSService.Free;
  end;
end;
  procedure TFormCadastroOrdensServi�o.CarregarGridRestaurar;
  var
    Service: TOrdemServicoService;
  begin
    Service := TOrdemServicoService.Create;
    try
      DataSourceRestaurar.DataSet := Service.ListarOrdensServicoRestaurar;
      DBGridRestaurar.DataSource := DataSourceRestaurar;
      ConfigurarGrid;
    finally
      Service.Free;
    end;
  end;


  procedure TFormCadastroOrdensServi�o.CarregarComboBoxes;
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

  procedure TFormCadastroOrdensServi�o.CarregarPecasCheckList;
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


  procedure TFormCadastroOrdensServi�o.CmbClienteChange(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;


procedure TFormCadastroOrdensServi�o.CmbFuncionarioChange(Sender: TObject);
  begin
    RecalcularPreco;
    PnlPecasUsadas.Visible := false;
  end;


procedure TFormCadastroOrdensServi�o.CmbServi�oChange(Sender: TObject);
  begin
    RecalcularPreco;
    PnlPecasUsadas.Visible := false;
  end;


procedure TFormCadastroOrdensServi�o.CmbVeiculoChange(Sender: TObject);
var
  Controller: TOrdemServicoController;
  IdVeiculo, IdCliente: Integer;
  i: Integer;
begin
  RecalcularPreco;
  if CmbVeiculo.ItemIndex >= 0 then
  begin
    IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);

    Controller := TOrdemServicoController.Create;
    try
      IdCliente := Controller.ObterClienteDoVeiculo(IdVeiculo);
      if IdCliente > 0 then
      begin
        for i := 0 to CmbCliente.Items.Count - 1 do
        begin
          if Integer(CmbCliente.Items.Objects[i]) = IdCliente then
          begin
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


procedure TFormCadastroOrdensServi�o.ConfigurarGrid;
begin
  if DBGridMain.Columns.Count >= 9 then
  begin
    DBGridMain.Columns[0].Title.Caption := 'Id';
    DBGridMain.Columns[1].Title.Caption := 'Servi�o';
    DBGridMain.Columns[2].Title.Caption := 'Funcion�rio';
    DBGridMain.Columns[3].Title.Caption := 'Ve�culo';
    DBGridMain.Columns[4].Title.Caption := 'Cliente';
    DBGridMain.Columns[5].Title.Caption := 'Pre�o';
    DBGridMain.Columns[6].Title.Caption := 'Observa��o';
    DBGridMain.Columns[7].Title.Caption := 'Data In�cio';
    DBGridMain.Columns[8].Title.Caption := 'Data Conclus�o';
    DBGridMain.Columns[9].Title.Caption := 'Ativo';

    for var i := 0 to 9 do
    begin
      DBGridMain.Columns[i].Title.Alignment := taCenter;
      DBGridMain.Columns[i].Alignment := taCenter;
      DBGridMain.Columns[i].Width := 140;
      DBGridMain.Columns[i].Title.Font.Size := 15;
    end;

    DBGridMain.Columns[0].Width := 50;
    DBGridMain.Columns[6].Width := 200;
  end;

  if LowerCase(Trim(uSession.UsuarioLogadoGrupo)) = 'mec�nico' then
  begin
    if DBGridMain.Columns.Count > 5 then
      DBGridMain.Columns[5].Visible := False;
  end;
end;

function TFormCadastroOrdensServi�o.ConverterPrecoParaCurrency(const ATexto: String): Currency;
var
  PrecoLimpo: String;
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';

  PrecoLimpo := StringReplace(ATexto, '.', '', [rfReplaceAll]);
  PrecoLimpo := Trim(PrecoLimpo);
  PrecoLimpo := StringReplace(PrecoLimpo, ',', '.', [rfReplaceAll]);

  try
    Result := StrToFloat(PrecoLimpo, FormatSettings);
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao converter pre�o: ' + ATexto + ' - ' + E.Message);
    end;
  end;
end;

  procedure TFormCadastroOrdensServi�o.RecalcularPreco;
  var
    Controller: TOrdemServicoController;
    PrecoCalculado: Currency;
  begin
    if (CmbServi�o.ItemIndex >= 0) and (CmbVeiculo.ItemIndex >= 0) then
    begin
      Controller := TOrdemServicoController.Create;
      try
        PrecoCalculado := Controller.CalcularPrecoTotal(
          Integer(CmbServi�o.Items.Objects[CmbServi�o.ItemIndex]),
          PecasSelecionadas,
          Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex])
        );
        EdtPreco.Text := StringReplace(
          FormatFloat('0.00', PrecoCalculado),
          '.',
          ',',
          []
        );
      finally
        Controller.Free;
      end;
    end
    else
    begin
      EdtPreco.Text := '0,00';
    end;
  end;

  procedure TFormCadastroOrdensServi�o.RestaurarOrdemServico;
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

  procedure TFormCadastroOrdensServi�o.ImgRestaurarClick(Sender: TObject);
  begin
    RestaurarOrdemServico;
    CarregarGridRestaurar;
  end;




  function TFormCadastroOrdensServi�o.ObterPecasSelecionadas: TList<Integer>;
  begin
    Result := TList<Integer>.Create;
    Result.AddRange(PecasSelecionadas);
  end;

  procedure TFormCadastroOrdensServi�o.MarcarPecasSelecionadas(PecasIDs: TList<Integer>);
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

  procedure TFormCadastroOrdensServi�o.EdtObservacaoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServi�o.EdtPecasClick(Sender: TObject);
  begin
    PnlPecasUsadas.Visible := True;
  end;

procedure TFormCadastroOrdensServi�o.EdtPesquisarChange(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    DataSourceMain.DataSet := Service.PesquisarOrdensServico(EdtPesquisar.Text);

  finally
    Service.Free;
  end;
end;

 procedure TFormCadastroOrdensServi�o.EdtPrecoClick(Sender: TObject);
begin
  PnlPecasUsadas.Visible := false;
end;

procedure TFormCadastroOrdensServi�o.PegarCamposGridOS;
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

    EdtObservacao.Text := DBGridMain.DataSource.DataSet.FieldByName('Observa��o').AsString;
    DTimeIncio.Date := DBGridMain.DataSource.DataSet.FieldByName('Data In�cio').AsDateTime;
    DTimeConclusao.Date := DBGridMain.DataSource.DataSet.FieldByName('Data Conclus�o').AsDateTime;

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

  procedure TFormCadastroOrdensServi�o.BtnEditarClick(Sender: TObject);
  begin
    PnlBackgrounEdit.Visible := True;
    PnlEdit.Visible := True;
    PnlButtonAtualizar.Visible := True;
    PnlButtonEnviar.Visible := False;
    PegarCamposGridOS;
  end;

  procedure TFormCadastroOrdensServi�o.BtnExcluirClick(Sender: TObject);
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


  procedure TFormCadastroOrdensServi�o.LblAtualizarClick(Sender: TObject);
  begin
    if ValidarCampos then
    begin
      EditarOrdemServico;
      CarregarGrid;
      FormReceitas.CarregarGrid;
    end;
  end;

procedure TFormCadastroOrdensServi�o.LblEnviarClick(Sender: TObject);
var
  Controller: TOrdemServicoController;
  OrdemServico: TOrdemServico;
  Preco: Currency;
  IdServico, IdFuncionario, IdVeiculo, IdCliente: Integer;
  PecasIDs: TList<Integer>;
  OrdensServicoID : Integer;
begin
  if ValidarCampos then
  begin
    Controller := TOrdemServicoController.Create;
    try
      try
        Preco := ConverterPrecoParaCurrency(EdtPreco.Text);
      except
        on E: Exception do
        begin
          ShowMessage('Erro ao converter o pre�o: ' + E.Message);
          Exit;
        end;
      end;

      IdServico := Integer(CmbServi�o.Items.Objects[CmbServi�o.ItemIndex]);
      IdFuncionario := Integer(CmbFuncionario.Items.Objects[CmbFuncionario.ItemIndex]);
      IdVeiculo := Integer(CmbVeiculo.Items.Objects[CmbVeiculo.ItemIndex]);
      IdCliente := Integer(CmbCliente.Items.Objects[CmbCliente.ItemIndex]);

      OrdemServico := Controller.CriarObjeto(IdServico, IdFuncionario, IdVeiculo, IdCliente,
        Preco, True, edtObservacao.Text, DtimeIncio.Date, DTimeConclusao.Date);
      try
        PecasIDs := ObterPecasSelecionadas;
        try
          Controller.SalvarOrdemServico(OrdemServico, PecasIDs);
          CarregarGrid;
          ShowMessage('Ordem de servi�o cadastrada com sucesso!');
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
end;

 procedure TFormCadastroOrdensServi�o.EditarOrdemServico;
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
      try
        Preco := ConverterPrecoParaCurrency(EdtPreco.Text);
      except
        on E: Exception do
        begin
          ShowMessage('Erro ao converter o pre�o: ' + E.Message);
          Exit;
        end;
      end;

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
      OrdemServico.setObservacao(EdtObservacao.Text);
      OrdemServico.setDataInicio(DtimeIncio.Date);
      OrdemServico.setDataConclusao(DtimeConclusao.Date);

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

  procedure TFormCadastroOrdensServi�o.BtnSairClick(Sender: TObject);
  begin
    if MessageDlg('Deseja realmente fechar este formul�rio?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      PnlBackgrounEdit.Visible := False;
      PnlEdit.Visible := False;
      EdtPesquisar.Visible := False;
      PnlPecasUsadas.Visible := False;
      Close;
  end;

  procedure TFormCadastroOrdensServi�o.FormCreate(Sender: TObject);
  begin
    CmbServi�o.Height := 31;
    CmbFuncionario.Height := 31;
    CmbVeiculo.Height := 31;
    CmbCliente.Height := 31;
    EdtPreco.Height := 31;
    EdtPecas.Height := 31;
    EdtObservacao.Height := 31;
    DtimeIncio.Height := 31;
    DtimeConclusao.Height := 31;
    PnlPecasUsadas.Visible := False;
    PnlButtonAtualizar.Height := 31;
    PnlButtonEnviar.Height := 31;
  end;

procedure TFormCadastroOrdensServi�o.FormShow(Sender: TObject);
begin
   CarregarGrid;
   CarregarComboBoxes;
   CarregarPecasCheckList;
   ConfigurarGrid;
end;


  procedure TFormCadastroOrdensServi�o.ImgFecharPecasClick(Sender: TObject);
  begin
    PnlPecasUsadas.Visible := False;
  end;

  procedure TFormCadastroOrdensServi�o.ImgFecharRestaurarClick(Sender: TObject);
  begin
    PnlRestaurar.Visible := False;
    CarregarGrid;
  end;

  function TFormCadastroOrdensServi�o.ValidarCampos: Boolean;
  begin
    Result := False;
    if CmbServi�o.ItemIndex = -1 then begin ShowMessage('Selecione um Servi�o v�lido'); Exit; end;
    if CmbFuncionario.ItemIndex = -1 then begin ShowMessage('Selecione um Funcion�rio v�lido'); Exit; end;
    if CmbVeiculo.ItemIndex = -1 then begin ShowMessage('Selecione um Ve�culo v�lido'); Exit; end;
    if CmbCliente.ItemIndex = -1 then begin ShowMessage('Selecione um Cliente v�lido'); Exit; end;
    if EdtPreco.Text = '' then begin ShowMessage('O campo Pre�o n�o pode ficar vazio'); Exit; end;
    Result := True;
  end;

procedure TFormCadastroOrdensServi�o.LimparCampos;
begin
  EdtPreco.Clear;
  EdtPecas.Clear;
  EdtObservacao.Clear;
  CmbServi�o.ItemIndex := -1;
  CmbFuncionario.ItemIndex := -1;
  CmbVeiculo.ItemIndex := -1;
  CmbCliente.ItemIndex := -1;
  DtimeIncio.Date := Now;
  DTimeConclusao.Date := Now;
  PecasSelecionadas.Clear;
end;

  end.
