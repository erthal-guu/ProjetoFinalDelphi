unit uFormReceitasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, ReceitaController, uReceita;

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
    DataSourceRestaurar: TDataSource;
    DataSourceMain: TDataSource;
    DataSourceHistorico: TDataSource;
    DBGridMain: TDBGrid;
    EdtReceita: TEdit;
    Label7: TLabel;
    procedure DBGridMainCellClick(Column: TColumn);
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
    procedure FormShow(Sender: TObject);
    procedure LblAtualizarClick(Sender: TObject);
    procedure CarregarReceitasRestaurar;
    procedure LimparCampos;
    procedure ExibirDetalhes;
    procedure CarregarGrid;
    procedure EdtPesquisarChange(Sender: TObject);
    procedure PreencherCamposReceita;
    procedure ReceberReceita;
  public

  end;

var
  FormReceitas: TFormReceitas;

implementation

{$R *.dfm}

var
  Controller: TReceitaController;

procedure TFormReceitas.FormCreate(Sender: TObject);
begin
  Controller := TReceitaController.Create;
  CmbFormaPagamento.Items.Add('Dinheiro');
  CmbFormaPagamento.Items.Add('Cartão de Crédito');
  CmbFormaPagamento.Items.Add('Cartão de Débito');
  CmbFormaPagamento.Items.Add('PIX');
  CmbFormaPagamento.Items.Add('Transferência Bancária');
  CmbFormaPagamento.Items.Add('Cheque');
  CmbFormaPagamento.Items.Add('Boleto');

  CmbStatusReceita.Items.Add('Pendente');
  CmbStatusReceita.Items.Add('Recebido');
  CmbStatusReceita.Items.Add('Parcial');
end;

procedure TFormReceitas.FormDestroy(Sender: TObject);
begin
  if Assigned(Controller) then
    Controller.Free;
end;

procedure TFormReceitas.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

procedure TFormReceitas.ReceberReceita;
var
  Receita: TReceita;
  ValorRecebido: Currency;
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
  begin
    ShowMessage('Selecione uma receita para receber.');
    Exit;
  end;

  if Trim(EdtValorRecebido.Text) = '' then
  begin
    ShowMessage('Informe o valor a ser recebido.');
    Exit;
  end;

  if not TryStrToCurr(EdtValorRecebido.Text, ValorRecebido) then
  begin
    ShowMessage('Valor recebido inválido.');
    Exit;
  end;

  if CmbFormaPagamento.Text = '' then
  begin
    ShowMessage('Selecione a forma de pagamento.');
    CmbFormaPagamento.SetFocus;
    Exit;
  end;

  if CmbStatusReceita.Text = '' then
  begin
    ShowMessage('Selecione o status da receita.');
    CmbStatusReceita.SetFocus;
    Exit;
  end;

  try
    Receita := Controller.CriarObjeto(
      DataSourceMain.DataSet.FieldByName('id').AsInteger,
      ValorRecebido,
      EdtDataRecebimento.Date,
      DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency,
      CmbFormaPagamento.Text,
      EdtObservacao.Text,
      CmbStatusReceita.Text,
      True
    );

    Controller.ReceberReceita(Receita);
    ShowMessage('Receita recebida com sucesso!');

    PnlBackgrounEdit.Visible := False;
    CarregarGrid;
    LimparCampos;
  finally
    Receita.Free;
  end;
end;

procedure TFormReceitas.DBGridMainCellClick(Column: TColumn);
begin
  PreencherCamposReceita;
end;

procedure TFormReceitas.CarregarGrid;
begin
  if Assigned(Controller) then
    Controller.Free;

  Controller := TReceitaController.Create;
  DataSourceMain.DataSet := Controller.ListarReceitas;
  DBGridMain.DataSource := DataSourceMain;

  try
    if DBGridMain.Columns.Count >= 12 then
    begin

      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[0].Width := 50;
      DBGridMain.Columns[0].Title.Alignment := taCenter;
      DBGridMain.Columns[0].Alignment := taCenter;


      DBGridMain.Columns[1].Title.Caption := 'OS';
      DBGridMain.Columns[1].Width := 60;
      DBGridMain.Columns[1].Title.Alignment := taCenter;
      DBGridMain.Columns[1].Alignment := taCenter;


      DBGridMain.Columns[2].Title.Caption := 'Cliente ID';
      DBGridMain.Columns[2].Width := 80;
      DBGridMain.Columns[2].Title.Alignment := taCenter;
      DBGridMain.Columns[2].Alignment := taCenter;
      DBGridMain.Columns[2].FieldName := 'id_cliente';


      DBGridMain.Columns[3].Title.Caption := 'Cliente';
      DBGridMain.Columns[3].Width := 200;
      DBGridMain.Columns[3].Title.Alignment := taCenter;
      DBGridMain.Columns[3].Alignment := taCenter;
      DBGridMain.Columns[3].FieldName := 'cliente_nome';


      DBGridMain.Columns[4].Title.Caption := 'Valor Total';
      DBGridMain.Columns[4].Width := 120;
      DBGridMain.Columns[4].Title.Alignment := taCenter;
      DBGridMain.Columns[4].Alignment := taCenter;

      DBGridMain.Columns[5].Title.Caption := 'Valor Recebido';
      DBGridMain.Columns[5].Width := 120;
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;


      DBGridMain.Columns[6].Title.Caption := 'Status';
      DBGridMain.Columns[6].Width := 100;
      DBGridMain.Columns[6].Title.Alignment := taCenter;
      DBGridMain.Columns[6].Alignment := taCenter;


      DBGridMain.Columns[7].Title.Caption := 'Data Emissão';
      DBGridMain.Columns[7].Width := 140;
      DBGridMain.Columns[7].Title.Alignment := taCenter;
      DBGridMain.Columns[7].Alignment := taCenter;


      DBGridMain.Columns[8].Title.Caption := 'Vencimento';
      DBGridMain.Columns[8].Width := 110;
      DBGridMain.Columns[8].Title.Alignment := taCenter;
      DBGridMain.Columns[8].Alignment := taCenter;


      DBGridMain.Columns[9].Title.Caption := 'Recebimento';
      DBGridMain.Columns[9].Width := 110;
      DBGridMain.Columns[9].Title.Alignment := taCenter;
      DBGridMain.Columns[9].Alignment := taCenter;

      DBGridMain.Columns[10].Title.Caption := 'Forma Pagamento';
      DBGridMain.Columns[10].Width := 150;
      DBGridMain.Columns[10].Title.Alignment := taCenter;
      DBGridMain.Columns[10].Alignment := taCenter;


      DBGridMain.Columns[11].Title.Caption := 'Observação';
      DBGridMain.Columns[11].Width := 250;
      DBGridMain.Columns[11].Title.Alignment := taCenter;
      DBGridMain.Columns[11].Alignment := taCenter;


      DBGridMain.Columns[12].Title.Caption := 'Ativo';
      DBGridMain.Columns[12].Width := 60;
      DBGridMain.Columns[12].Title.Alignment := taCenter;
      DBGridMain.Columns[12].Alignment := taCenter;

      for var i := 0 to 12 do
      begin
        DBGridMain.Columns[i].Title.Font.Size := 12;
        DBGridMain.Columns[i].Title.Font.Style := [fsBold];
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar grid: ' + E.Message);
  end;
end;
procedure TFormReceitas.PreencherCamposReceita;
var
  i: Integer;
  IdOrdem: Integer;
begin
  if Assigned(DataSourceMain.DataSet) and not DataSourceMain.DataSet.Eof then
  begin
    EdtValorTotal.Text := CurrToStr(DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency);
    EdtValorRecebido.Text := CurrToStr(DataSourceMain.DataSet.FieldByName('valor_recebido').AsCurrency);
    EdtReceita.Text := intToStr(DataSourceMain.DataSet.FieldByName('id_ordem_servico').AsInteger);

    try
      EdtDataRecebimento.Date := DataSourceMain.DataSet.FieldByName('data_recebimento').AsDateTime;
    except
      EdtDataRecebimento.Date := Date;
    end;

    CmbFormaPagamento.Text := DataSourceMain.DataSet.FieldByName('forma_pagamento').AsString;
    EdtObservacao.Text := DataSourceMain.DataSet.FieldByName('observacao').AsString;
    CmbStatusReceita.Text := DataSourceMain.DataSet.FieldByName('status').AsString;
  end;
end;

procedure TFormReceitas.CarregarReceitasRestaurar;
begin
  if Assigned(Controller) then
    Controller.Free;

  Controller := TReceitaController.Create;
  DataSourceRestaurar.DataSet := Controller.ListarReceitasRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
end;

procedure TFormReceitas.LimparCampos;
begin
  EdtReceita.Text  := '';
  EdtValorTotal.Text := '';
  EdtValorRecebido.Text := '';
  EdtObservacao.Text := '';
  CmbFormaPagamento.ItemIndex := -1;
  CmbStatusReceita.ItemIndex := -1;
  EdtDataRecebimento.Date := Date;
end;

procedure TFormReceitas.ExibirDetalhes;
var
  IDReceita: Integer;
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
    Exit;

  IDReceita := DataSourceMain.DataSet.FieldByName('id').AsInteger;

  ListBoxDetalhes.Items.Clear;
  ListBoxDetalhes.Items.Add(Format('ID: %d', [IDReceita]));
  ListBoxDetalhes.Items.Add(Format('Ordem de Serviço: %d', [
    DataSourceMain.DataSet.FieldByName('id_ordem_servico').AsInteger]));
  ListBoxDetalhes.Items.Add(Format('Cliente ID: %d - %s', [
    DataSourceMain.DataSet.FieldByName('id_cliente').AsInteger,
    DataSourceMain.DataSet.FieldByName('cliente_nome').AsString]));
  ListBoxDetalhes.Items.Add('');
  ListBoxDetalhes.Items.Add(Format('Valor Total: R$ %.2f', [
    DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency]));
  ListBoxDetalhes.Items.Add(Format('Valor Recebido: R$ %.2f', [
    DataSourceMain.DataSet.FieldByName('valor_recebido').AsCurrency]));
  ListBoxDetalhes.Items.Add(Format('Data Emissão: %s', [
    FormatDateTime('dd/mm/yyyy', DataSourceMain.DataSet.FieldByName('data_emissao').AsDateTime)]));
  ListBoxDetalhes.Items.Add(Format('Data Vencimento: %s', [
    FormatDateTime('dd/mm/yyyy', DataSourceMain.DataSet.FieldByName('data_vencimento').AsDateTime)]));
  ListBoxDetalhes.Items.Add(Format('Data Recebimento: %s', [
    FormatDateTime('dd/mm/yyyy', DataSourceMain.DataSet.FieldByName('data_recebimento').AsDateTime)]));
  ListBoxDetalhes.Items.Add('');
  ListBoxDetalhes.Items.Add(Format('Forma Pagamento: %s', [
    DataSourceMain.DataSet.FieldByName('forma_pagamento').AsString]));
  ListBoxDetalhes.Items.Add(Format('Status: %s', [
    DataSourceMain.DataSet.FieldByName('status').AsString]));
  ListBoxDetalhes.Items.Add(Format('Observação: %s', [
    DataSourceMain.DataSet.FieldByName('observacao').AsString]));
  ListBoxDetalhes.Items.Add(Format('Ativo: %s', [
    IfThen(DataSourceMain.DataSet.FieldByName('ativo').AsBoolean, 'Sim', 'Não')]));

  PnlDetlhamento.Visible := True;
end;

procedure TFormReceitas.BtnReceberClick(Sender: TObject);
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
  begin
    ShowMessage('Selecione uma receita para receber.');
    Exit;
  end;
  PreencherCamposReceita;
  EdtDataRecebimento.Date := Date;
  PnlBackgrounEdit.Visible := True;
  PnlEdit.Visible := True;
end;

procedure TFormReceitas.BtnExcluirClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if not Assigned(DataSourceMain.DataSet) or DataSourceMain.DataSet.Eof then
  begin
    ShowMessage('Selecione uma receita para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir esta receita?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    IDReceita := DataSourceMain.DataSet.FieldByName('id').AsInteger;
    Controller.DeletarReceita(IDReceita);
    ShowMessage('Receita excluída com sucesso!');
    CarregarGrid;
  end;
end;

procedure TFormReceitas.BtnDetalharClick(Sender: TObject);
begin
  ExibirDetalhes;
  PnlRestaurar.Visible := False;
  PnLHistorico.Visible := False;
end;

procedure TFormReceitas.BtnRestaurarClick(Sender: TObject);
begin
  CarregarReceitasRestaurar;
  PnlRestaurar.Visible := True;
  PnlDetlhamento.Visible := False;
  PnLHistorico.Visible := False;
end;

procedure TFormReceitas.BtnHistoricoClick(Sender: TObject);
begin
  if Assigned(Controller) then
    Controller.Free;
  Controller := TReceitaController.Create;
  DataSourceHistorico.DataSet := Controller.ListarHistoricoReceitas;
  DBGridHistorico.DataSource := DataSourceHistorico;
  PnLHistorico.Visible := True;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
end;

procedure TFormReceitas.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  if EdtPesquisar.Text <> '' then
  begin
    DataSourceMain.DataSet := Controller.PesquisarReceitas(EdtPesquisar.Text);
  end
  else
  begin
    CarregarGrid;
  end;
end;

procedure TFormReceitas.EdtPesquisarChange(Sender: TObject);
begin
  if Trim(EdtPesquisar.Text) <> '' then
    DataSourceMain.DataSet := Controller.PesquisarReceitas(EdtPesquisar.Text)
  else
    CarregarGrid;
end;

procedure TFormReceitas.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormReceitas.ImgFecharHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := False;
  CarregarGrid;
end;

procedure TFormReceitas.ImgFecharDetalhamentoClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
end;

procedure TFormReceitas.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
    PnlRestaurar.Visible := False;
    EdtPesquisar.Visible := False;
    Close;
  end;
end;

procedure TFormReceitas.BtnCancelarClick(Sender: TObject);
begin
  LimparCampos;
  PnlBackgrounEdit.Visible := False;
  PnlEdit.Visible := False;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
  PnLHistorico.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormReceitas.ImgRestaurarClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if not Assigned(DataSourceRestaurar.DataSet) or DataSourceRestaurar.DataSet.Eof then
  begin
    ShowMessage('Selecione uma receita para restaurar.');
    Exit;
  end;

  if MessageDlg('Deseja realmente restaurar esta receita?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    IDReceita := DataSourceRestaurar.DataSet.FieldByName('id').AsInteger;
    Controller.RestaurarReceita(IDReceita);
    ShowMessage('Receita restaurada com sucesso!');
    CarregarReceitasRestaurar;
    CarregarGrid;
  end;
end;

procedure TFormReceitas.LblAtualizarClick(Sender: TObject);
begin
  ReceberReceita;
end;


end.
