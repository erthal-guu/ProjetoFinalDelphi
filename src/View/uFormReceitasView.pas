unit uFormReceitasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls,ReceitaController,ReceitaService,uReceita;

type
  TFormReceitas = class(TForm)
    PnlMain: TPanel;
    Panel1: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnReceber: TSpeedButton;
    BtnDetalhar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnHistorico: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlGrid: TPanel;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    ImgRestaurar: TImage;
    PnLHistorico: TPanel;
    LblHistorico: TLabel;
    ImgFecharHistorico: TImage;
    PnlDesingGrid: TPanel;
    PnlBackgroundGrid: TPanel;
    DBGridHistorico: TDBGrid;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlEdit: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtObservacao: TEdit;
    CmbFormaPagamento: TComboBox;
    EdtValorTotal: TEdit;
    CmbStatusReceita: TComboBox;
    LblStatus: TLabel;
    EdtValorRecebido: TEdit;
    Label5: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    PnlDetlhamento: TPanel;
    LblDetalhamento: TLabel;
    PnlDesingDetalhamento: TPanel;
    ListBoxDetalhes: TListBox;
    ImgFecharDetalhamento: TImage;
    Label6: TLabel;
    EdtDataRecebimento: TDateTimePicker;
    BtnCancelar: TSpeedButton;
    CmbReceita: TComboBox;
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    DataSourceHistorico: TDataSource;
    DBGridMain: TDBGrid;
    procedure BtnDetalharClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure BtnHistoricoClick(Sender: TObject);
    procedure ImgFecharHistoricoClick(Sender: TObject);
    procedure ImgFecharDetalhamentoClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnReceberClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure ImgRestaurarClick(Sender: TObject);
    procedure EdtPesquisarInvokeSearch(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LblAtualizarClick(Sender: TObject);
    procedure CarregarReceitasRestaurar;
    procedure CarregarOrdensServico;
    procedure LimparCampos;
    procedure ExibirDetalhes;
    procedure CarregarGrid;
  public
    Controller: TReceitaController;
  end;

var
  FormReceitas: TFormReceitas;

implementation

{$R *.dfm}

procedure TFormReceitas.FormCreate(Sender: TObject);
begin
  EdtObservacao.Height := 31;
  EdtValorTotal.Height := 31;
  EdtValorRecebido.Height := 31;
  EdtDataRecebimento.Height := 31;
  CmbStatusReceita.Font.Size := 13;
  CmbFormaPagamento.Font.Size := 13;


  Controller := TReceitaController.Create;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlDetlhamento.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.FormDestroy(Sender: TObject);
begin
  Controller.Free;
end;

procedure TFormReceitas.FormShow(Sender: TObject);
begin
  CarregarGrid;
  CarregarOrdensServico;
end;

procedure TFormReceitas.CarregarReceitasRestaurar;
begin
  try
    DataSourceRestaurar.DataSet := Controller.ListarReceitasRestaurar;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar receitas deletadas: ' + E.Message);
  end;
end;

procedure TFormReceitas.CarregarGrid;
var
  ReceitaController: TReceitaController;
begin
  ReceitaController := TReceitaController.Create;
  try
    DataSourceMain.DataSet := ReceitaController.ListarReceitas;
    DBGridMain.DataSource := DataSourceMain;

    if DBGridMain.Columns.Count = 0 then
      DBGridMain.Columns.RebuildColumns;

    if DBGridMain.Columns.Count >= 7 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Descrição';
      DBGridMain.Columns[2].Title.Caption := 'Cliente';
      DBGridMain.Columns[3].Title.Caption := 'Valor Total';
      DBGridMain.Columns[4].Title.Caption := 'Status';
      DBGridMain.Columns[5].Title.Caption := 'Data Recebimento';
      DBGridMain.Columns[6].Title.Caption := 'Forma de Pagamento';

      for var i := 0 to DBGridMain.Columns.Count - 1 do
      begin
        DBGridMain.Columns[i].Title.Alignment := taCenter;
        DBGridMain.Columns[i].Alignment := taCenter;
        DBGridMain.Columns[i].Width := 140;
        DBGridMain.Columns[i].Title.Font.Size := 15;
      end;
    end;
  finally
    ReceitaController.Free;
  end;
end;

procedure TFormReceitas.CarregarOrdensServico;
var
  Lista: TStringList;
  i: Integer;
begin
  try
    Lista := Controller.CarregarOrdensServico;
    try
      CmbReceita.Items.Clear;
      for i := 0 to Lista.Count - 1 do
        CmbReceita.Items.AddObject(Lista[i], Lista.Objects[i]);

      if CmbReceita.Items.Count > 0 then
        CmbReceita.ItemIndex := 0;
    finally
      Lista.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar ordens de serviço: ' + E.Message);
  end;
end;

procedure TFormReceitas.LblAtualizarClick(Sender: TObject);
var
  IDReceita: Integer;
  ValorRecebido: Currency;
begin
  if DBGridMain.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione uma receita para receber!');
    Exit;
  end;

  if Trim(EdtValorRecebido.Text) = '' then
  begin
    ShowMessage('Informe o valor recebido!');
    EdtValorRecebido.SetFocus;
    Exit;
  end;

  try
    ValorRecebido := StrToCurr(EdtValorRecebido.Text);
    IDReceita := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

    if Controller.ReceberReceita(IDReceita, ValorRecebido,
       EdtDataRecebimento.DateTime, CmbFormaPagamento.Text) then
    begin
      ShowMessage('Receita recebida com sucesso!');
      CarregarGrid;
      LimparCampos;
      PnlBackgrounEdit.Visible := False;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao receber receita: ' + E.Message);
  end;
end;

procedure TFormReceitas.LimparCampos;
begin
  EdtValorRecebido.Clear;
  EdtValorTotal.Clear;
  EdtObservacao.Clear;
  EdtDataRecebimento.DateTime := Now;
  CmbFormaPagamento.ItemIndex := 0;
  CmbStatusReceita.ItemIndex := 0;
  if CmbReceita.Items.Count > 0 then
    CmbReceita.ItemIndex := 0;
end;

procedure TFormReceitas.BtnHistoricoClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if DBGridMain.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione uma receita para ver o histórico!');
    Exit;
  end;

  try
    IDReceita := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
    DataSourceHistorico.DataSet := Controller.ObterHistoricoReceita(IDReceita);

    PnLHistorico.Visible := True;
    PnlRestaurar.Visible := False;
    PnlDetlhamento.Visible := False;
    PnlBackgrounEdit.Visible := False;
    EdtPesquisar.Visible := False;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar histórico: ' + E.Message);
  end;
end;

procedure TFormReceitas.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDetlhamento.Visible := False;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.SetFocus;
end;

procedure TFormReceitas.EdtPesquisarInvokeSearch(Sender: TObject);
begin
  try
    if Trim(EdtPesquisar.Text) = '' then
        CarregarGrid
    else
      DataSourceMain.DataSet := Controller.PesquisarReceitas(EdtPesquisar.Text);
  except
    on E: Exception do
      ShowMessage('Erro ao pesquisar: ' + E.Message);
  end;
end;

procedure TFormReceitas.BtnReceberClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlDetlhamento.Visible := False;
  EdtPesquisar.Visible := False;
  LimparCampos;
end;


procedure TFormReceitas.BtnExcluirClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if DBGridMain.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione uma receita para excluir!');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir esta receita?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      IDReceita := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
      Controller.DeletarReceita(IDReceita);
      ShowMessage('Receita excluída com sucesso!');
      CarregarGrid;
    except
      on E: Exception do
        ShowMessage('Erro ao excluir receita: ' + E.Message);
    end;
  end;
end;

procedure TFormReceitas.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  PnlHistorico.Visible := False;
  PnlDetlhamento.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarReceitasRestaurar;
end;

procedure TFormReceitas.ImgRestaurarClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if DBGridRestaurar.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione uma receita para restaurar!');
    Exit;
  end;

  if MessageDlg('Deseja realmente restaurar esta receita?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      IDReceita := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;
      Controller.RestaurarReceita(IDReceita);
      ShowMessage('Receita restaurada com sucesso!');
      CarregarReceitasRestaurar;
      CarregarGrid;
    except
      on E: Exception do
        ShowMessage('Erro ao restaurar receita: ' + E.Message);
    end;
  end;
end;

procedure TFormReceitas.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormReceitas.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
end;

procedure TFormReceitas.ImgFecharDetalhamentoClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
end;

procedure TFormReceitas.ImgFecharHistoricoClick(Sender: TObject);
begin
  PnlHistorico.Visible := False;
end;

procedure TFormReceitas.BtnCancelarClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  LimparCampos;
end;

procedure TFormReceitas.BtnDetalharClick(Sender: TObject);
begin
  if DBGridMain.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione uma receita para detalhar!');
    Exit;
  end;

  ExibirDetalhes;
  PnlDetlhamento.Visible := True;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.ExibirDetalhes;
var
  IDReceita: Integer;
  Receita: TReceita;
begin
  try
    IDReceita := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;
    Receita := Controller.ObterDetalhesReceita(IDReceita);

    if Assigned(Receita) then
    begin
      try
        ListBoxDetalhes.Items.Clear;
        ListBoxDetalhes.Items.Add('ID: ' + IntToStr(Receita.getIdReceita));
        ListBoxDetalhes.Items.Add('Valor Total: R$ ' + FormatFloat('#,##0.00', Receita.getValorTotal));
        ListBoxDetalhes.Items.Add('Valor Recebido: R$ ' + FormatFloat('#,##0.00', Receita.getValorRecebido));
        ListBoxDetalhes.Items.Add('Data Recebimento: ' + DateToStr(Receita.getDataRecebimento));
        ListBoxDetalhes.Items.Add('Forma Pagamento: ' + Receita.getFormaPagamento);
        ListBoxDetalhes.Items.Add('Status: ' + Receita.getStatus);
        ListBoxDetalhes.Items.Add('Observação: ' + Receita.getObservacao);
      finally
        Receita.Free;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar detalhes: ' + E.Message);
  end;
end;

end.
