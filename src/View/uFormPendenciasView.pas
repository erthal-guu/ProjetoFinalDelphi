unit uFormPendenciasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls,
  Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, PendenciaController, uPendencia;

type
  TFormPendencias = class(TForm)
    PnlMain: TPanel;
    Panel1: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtObservacao: TEdit;
    BtnCancelar: TSpeedButton;
    PnlDetlhamento: TPanel;
    LblDetalhamento: TLabel;
    ImgFecharDetalhamento: TImage;
    PnlDesingDetalhamento: TPanel;
    ListBoxDetalhes: TListBox;
    DataSourceRestaurar: TDataSource;
    DataSourceHistorico: TDataSource;
    DataSourceMain: TDataSource;
    DBGridMain: TDBGrid;
    EdtDataVencimento: TDateTimePicker;
    EdtValorTotal: TEdit;
    CmbFormaPagamento: TComboBox;
    CmbParcelar: TComboBox;
    EdtPedido: TEdit;
    Label2: TLabel;
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    Image2: TImage;
    procedure DBGridMainCellClick(Column: TColumn);
    procedure BtnDetalharClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure BtnHistoricoClick(Sender: TObject);
    procedure ImgFecharHistoricoClick(Sender: TObject);
    procedure ImgFecharDetalhamentoClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgRestaurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LblAtualizarClick(Sender: TObject);
    procedure CarregarGridRestaurar;
    procedure LimparCampos;
    procedure ExibirDetalhes;
    procedure CarregarGrid;
    procedure EdtPesquisarChange(Sender: TObject);
    procedure PreencherCamposPendencia;
    procedure ConcluirPendencia;
    procedure BtnReceberClick(Sender: TObject);
    procedure Parcelar;
    procedure CmbFormaPagamentoChange(Sender: TObject);
    Function ValidarCampos: Boolean;
    procedure CarregarGridHistorico;
  private
    { Private declarations }
    Controller: TPendenciaController;
  public
    { Public declarations }
  end;

var
  FormPendencias: TFormPendencias;

implementation

{$R *.dfm}

procedure TFormPendencias.BtnExcluirClick(Sender: TObject);
var
  IDPendencia: Integer;
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
  begin
    ShowMessage('Selecione uma pendência para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir esta pendência?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    PnlBackgrounEdit.Visible := False;
    IDPendencia := DataSourceMain.DataSet.FieldByName('id').AsInteger;
    Controller.DeletarPendencia(IDPendencia);
    CarregarGrid;
    ShowMessage('Pendência excluída com sucesso!');
  end;
end;

procedure TFormPendencias.BtnDetalharClick(Sender: TObject);
begin
  ExibirDetalhes;
end;

procedure TFormPendencias.BtnReceberClick(Sender: TObject);
begin
  PreencherCamposPendencia;
end;

procedure TFormPendencias.Parcelar;
begin
  if CmbFormaPagamento.ItemIndex = 2 then begin
    CmbParcelar.Visible := True;
    Label7.Visible := True;
    Label5.Left := 621;
  end else begin
    CmbParcelar.Visible := False;
    Label7.Visible := False;
    Label5.Left := 482;
  end;
end;

procedure TFormPendencias.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  PnlDetlhamento.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarGridRestaurar;
end;

procedure TFormPendencias.BtnHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := True;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarGridHistorico;
end;

procedure TFormPendencias.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  EdtPesquisar.SetFocus;
  If PnlRestaurar.Visible  OR PnLHistorico.Visible then begin
    EdtPesquisar.Enabled := False;
  end;

end;

procedure TFormPendencias.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    PnlBackgrounEdit.Visible := False;
    PnlRestaurar.Visible := False;
    EdtPesquisar.Visible := False;
    Close;
  end;
end;

procedure TFormPendencias.BtnCancelarClick(Sender: TObject);
begin
  LimparCampos;
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
  PnLHistorico.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarGrid;
end;

procedure TFormPendencias.CarregarGrid;
var
  i: Integer;
begin
  DataSourceMain.DataSet := Controller.ListarPendencias;
  DBGridMain.DataSource := DataSourceMain;

  for i := 0 to DBGridMain.Columns.Count - 1 do begin
    DBGridMain.Columns[i].Title.Alignment := taCenter;
    DBGridMain.Columns[i].Alignment := taCenter;
    DBGridMain.Columns[i].Width := 160;
    DBGridMain.Columns[i].Title.Font.Size := 15;
  end;
  if DBGridMain.Columns.Count >= 11 then begin
    DBGridMain.Columns[0].Title.Caption := 'ID';
    DBGridMain.Columns[0].Visible := False;
    DBGridMain.Columns[1].Title.Caption := 'Pedido';
    DBGridMain.Columns[2].Title.Caption := 'Fornecedor';
    DBGridMain.Columns[3].Title.Caption := 'Descrição';
    DBGridMain.Columns[4].Title.Caption := 'Valor Total';
    DBGridMain.Columns[5].Title.Caption := 'Vencimento';
    DBGridMain.Columns[6].Title.Caption := 'Criação';
    DBGridMain.Columns[6].Visible := False;
    DBGridMain.Columns[7].Title.Caption := 'Status';
    DBGridMain.Columns[7].Visible := False;
    DBGridMain.Columns[8].Title.Caption := 'Observação';
    DBGridMain.Columns[9].Title.Caption := 'ID Cliente';
    DBGridMain.Columns[9].Visible := False;
    DBGridMain.Columns[10].Title.Caption := 'Ativo';
    DBGridMain.Columns[10].Visible := False;
  end;
end;

procedure TFormPendencias.CarregarGridHistorico;
begin
  DataSourceHistorico.DataSet := Controller.ListarHistoricoPendencias;
  DBGridHistorico.DataSource := DataSourceHistorico;
    for var i := 0 to DBGridHistorico.Columns.Count - 1 do begin
    DBGridHistorico.Columns[i].Title.Alignment := taCenter;
    DBGridHistorico.Columns[i].Alignment := taCenter;
    DBGridHistorico.Columns[i].Width := 160;
    DBGridHistorico.Columns[i].Title.Font.Size := 15;
  end;
    if DBGridHistorico.Columns.Count >= 11 then
      begin
          DBGridHistorico.Columns[0].Title.Caption := 'ID';
          DBGridHistorico.Columns[0].Visible := False;
          DBGridHistorico.Columns[1].Title.Caption := 'Pedido';
          DBGridHistorico.Columns[2].Title.Caption := 'Fornecedor';
          DBGridHistorico.Columns[3].Title.Caption := 'Descrição';
          DBGridHistorico.Columns[4].Title.Caption := 'Valor Total';
          DBGridHistorico.Columns[5].Title.Caption := 'Data vencimento';
          DBGridHistorico.Columns[6].Title.Caption := 'Data criação';
          DBGridHistorico.Columns[7].Title.Caption := 'Status';
          DBGridHistorico.Columns[8].Title.Caption := 'Observação';
          DBGridHistorico.Columns[9].Title.Caption := 'ID Cliente';
          DBGridHistorico.Columns[9].Visible := False;
          DBGridHistorico.Columns[10].Title.Caption := 'Ativo';
      end;
end;

procedure TFormPendencias.CarregarGridRestaurar;
begin
  DataSourceRestaurar.DataSet := Controller.ListarPendenciasRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  for var i := 0 to DBGridRestaurar.Columns.Count - 1 do begin
    DBGridRestaurar.Columns[i].Title.Alignment := taCenter;
    DBGridRestaurar.Columns[i].Alignment := taCenter;
    DBGridRestaurar.Columns[i].Width := 160;
    DBGridRestaurar.Columns[i].Title.Font.Size := 15;
  end;
  if DBGridRestaurar.Columns.Count >= 11 then begin
    DBGridRestaurar.Columns[0].Title.Caption := 'ID';
    DBGridRestaurar.Columns[0].Visible := False;
    DBGridRestaurar.Columns[1].Title.Caption := 'Pedido';
    DBGridRestaurar.Columns[2].Title.Caption := 'Fornecedor';
    DBGridRestaurar.Columns[3].Title.Caption := 'Descrição';
    DBGridRestaurar.Columns[4].Title.Caption := 'Valor Total';
    DBGridRestaurar.Columns[5].Title.Caption := 'Vencimento';
    DBGridRestaurar.Columns[6].Title.Caption := 'Criação';
    DBGridRestaurar.Columns[6].Visible := False;
    DBGridRestaurar.Columns[7].Title.Caption := 'Status';
    DBGridRestaurar.Columns[8].Title.Caption := 'Observação';
    DBGridRestaurar.Columns[9].Title.Caption := 'ID Cliente';
    DBGridRestaurar.Columns[9].Visible := False;
    DBGridRestaurar.Columns[10].Title.Caption := 'Ativo';
  end;
end;

procedure TFormPendencias.CmbFormaPagamentoChange(Sender: TObject);
begin
  Parcelar;
end;

procedure TFormPendencias.ConcluirPendencia;
var
  Pendencia: TPendencia;
begin
  Pendencia := Controller.CriarObjeto(DataSourceMain.DataSet.FieldByName('id')
    .AsInteger, DataSourceMain.DataSet.FieldByName('id_cliente').AsInteger,
    DataSourceMain.DataSet.FieldByName('descricao').AsString,
    DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency,
    DataSourceMain.DataSet.FieldByName('data_vencimento').AsDateTime,
    'CONCLUIDA', EdtObservacao.Text, True);

  try
    Controller.ConcluirPendencia(Pendencia);
    CarregarGrid;
    ShowMessage('Pendência concluída com sucesso!');
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
  finally
    Pendencia.Free;
  end;
end;

procedure TFormPendencias.DBGridMainCellClick(Column: TColumn);
begin
  PreencherCamposPendencia;
end;

procedure TFormPendencias.EdtPesquisarChange(Sender: TObject);
var
  Filtro: String;
begin
  Filtro := EdtPesquisar.Text;
  DataSourceMain.DataSet := Controller.PesquisarPendencias(Filtro);
    for  var i := 0 to DBGridMain.Columns.Count - 1 do begin
    DBGridMain.Columns[i].Title.Alignment := taCenter;
    DBGridMain.Columns[i].Alignment := taCenter;
    DBGridMain.Columns[i].Width := 160;
    DBGridMain.Columns[i].Title.Font.Size := 15;
  end;
  if DBGridMain.Columns.Count >= 11 then begin
    DBGridMain.Columns[0].Title.Caption := 'ID';
    DBGridMain.Columns[0].Visible := False;
    DBGridMain.Columns[1].Title.Caption := 'Pedido';
    DBGridMain.Columns[2].Title.Caption := 'Fornecedor';
    DBGridMain.Columns[3].Title.Caption := 'Descrição';
    DBGridMain.Columns[4].Title.Caption := 'Valor Total';
    DBGridMain.Columns[5].Title.Caption := 'Vencimento';
    DBGridMain.Columns[6].Title.Caption := 'Criação';
    DBGridMain.Columns[6].Visible := False;
    DBGridMain.Columns[7].Title.Caption := 'Status';
    DBGridMain.Columns[7].Visible := False;
    DBGridMain.Columns[8].Title.Caption := 'Observação';
    DBGridMain.Columns[9].Title.Caption := 'ID Cliente';
    DBGridMain.Columns[9].Visible := False;
    DBGridMain.Columns[10].Title.Caption := 'Ativo';
    DBGridMain.Columns[10].Visible := False;
  end;
end;

procedure TFormPendencias.ExibirDetalhes;
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
  begin
    ShowMessage('Selecione uma pendência para detalhar.');
    Exit;
  end;

  ListBoxDetalhes.Items.Clear;
  ListBoxDetalhes.Items.Add('ID: ' + DataSourceMain.DataSet.FieldByName('id')
    .AsString);
  ListBoxDetalhes.Items.Add('Cliente: ' + DataSourceMain.DataSet.FieldByName
    ('cliente_nome').AsString);
  ListBoxDetalhes.Items.Add('Descrição: ' + DataSourceMain.DataSet.FieldByName
    ('descricao').AsString);
  ListBoxDetalhes.Items.Add('Valor: R$ ' + FormatFloat('0.00',
    DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency));
  ListBoxDetalhes.Items.Add('Vencimento: ' +
    DateToStr(DataSourceMain.DataSet.FieldByName('data_vencimento')
    .AsDateTime));
  ListBoxDetalhes.Items.Add('Status: ' + DataSourceMain.DataSet.FieldByName
    ('status').AsString);
  ListBoxDetalhes.Items.Add('Observação: ' + DataSourceMain.DataSet.FieldByName
    ('observacao').AsString);

  PnlDetlhamento.Visible := True;
end;

procedure TFormPendencias.FormCreate(Sender: TObject);
begin
  Controller := TPendenciaController.Create;
  DataSourceMain := TDataSource.Create(Self);
  DataSourceHistorico := TDataSource.Create(Self);
  DataSourceRestaurar := TDataSource.Create(Self);
  Label5.Left := 482;
  EdtObservacao.Left := 482;
end;

procedure TFormPendencias.FormDestroy(Sender: TObject);
begin
  Controller.Free;
end;

procedure TFormPendencias.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

procedure TFormPendencias.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  EdtPesquisar.Enabled := True;
  CarregarGrid;
end;

procedure TFormPendencias.ImgFecharDetalhamentoClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
    If PnlRestaurar.Visible then begin
    CarregarGridRestaurar;
    end else if PnLHistorico.Visible then begin
    CarregarGridHistorico;
    end else begin
      CarregarGrid;
    end;
end;

procedure TFormPendencias.ImgFecharHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := False;
  EdtPesquisar.Enabled := True;
  CarregarGrid;
end;

procedure TFormPendencias.ImgRestaurarClick(Sender: TObject);
var
  IDPendencia: Integer;
begin
  if not Assigned(DataSourceRestaurar.DataSet) or DataSourceRestaurar.DataSet.Eof
  then begin
    ShowMessage('Selecione uma pendência para restaurar.');
    PnlRestaurar.Visible := False;
    Exit;
  end;

  if MessageDlg('Deseja realmente restaurar esta pendência?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    IDPendencia := DataSourceRestaurar.DataSet.FieldByName('id').AsInteger;
    Controller.RestaurarPendencia(IDPendencia);
    CarregarGrid;
    CarregarGridRestaurar;
    ShowMessage('Pendência restaurada com sucesso!');
  end;
end;

procedure TFormPendencias.LblAtualizarClick(Sender: TObject);
begin
  If ValidarCampos then begin
    ConcluirPendencia;
  end;
end;

procedure TFormPendencias.LimparCampos;
begin
  EdtValorTotal.Clear;
  EdtDataVencimento.Date := Now;
  EdtObservacao.Clear;
end;

procedure TFormPendencias.PreencherCamposPendencia;
begin
  if Assigned(DataSourceMain.DataSet) and not DataSourceMain.DataSet.Eof then
  begin
    EdtValorTotal.Text := FormatFloat('0.00',DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency);
    EdtDataVencimento.Date := DataSourceMain.DataSet.FieldByName('data_vencimento').AsDateTime;
    EdtObservacao.Text := DataSourceMain.DataSet.FieldByName('observacao').AsString;
    EdtPedido.Text := DataSourceMain.DataSet.FieldByName('id_pedido').AsString;
    PnlBackgrounEdit.Visible := True;
  end else begin
    ShowMessage('Selecione uma Pendência válida');
    PnlBackgrounEdit.Visible := False;
  end;
end;

function TFormPendencias.ValidarCampos: Boolean;
begin
  Result := False;

  if Trim(EdtPedido.Text) = '' then begin
    ShowMessage('O campo Pedido não pode ficar vazio');
    EdtPedido.SetFocus;
    Exit;
  end;

  if EdtDataVencimento.Date < Date then begin
    ShowMessage('A Data de Vencimento não pode ser anterior à data atual');
    EdtDataVencimento.SetFocus;
    Exit;
  end;

  if Trim(EdtValorTotal.Text) = '' then begin
    ShowMessage('O campo Valor Total não pode ficar vazio');
    EdtValorTotal.SetFocus;
    Exit;
  end;

  if CmbFormaPagamento.ItemIndex = -1 then begin
    ShowMessage('Selecione uma Forma de Pagamento válida');
    CmbFormaPagamento.SetFocus;
    Exit;
  end;

  if (CmbFormaPagamento.ItemIndex = 2) and (CmbParcelar.ItemIndex = -1) then
  begin
    ShowMessage('Selecione a quantidade de parcelas');
    CmbParcelar.SetFocus;
    Exit;
  end;

  if Trim(EdtObservacao.Text) = '' then begin
    ShowMessage('O campo Observação não pode ficar vazio');
    EdtObservacao.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
