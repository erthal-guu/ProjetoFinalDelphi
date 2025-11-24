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
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    Image2: TImage;
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
    procedure CarregarGridRestaurar;
    procedure LimparCampos;
    procedure ExibirDetalhes;
    procedure CarregarGrid;
    procedure EdtPesquisarChange(Sender: TObject);
    procedure PreencherCamposReceita;
    procedure ReceberReceita;
    procedure CarregarGridHistorico;
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

  CmbStatusReceita.Style := csSimple;
  CmbStatusReceita.Style := csDropDown;
  CmbStatusReceita.Enabled := False;
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
  if ValorRecebido > DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency then
  begin
    ShowMessage(Format(' O valor recebido (R$ %.2f) não pode ser maior que o valor total (R$ %.2f).',
      [ValorRecebido, DataSourceMain.DataSet.FieldByName('valor_total').AsCurrency]));
    EdtValorRecebido.SetFocus;
    Exit;
  end;

  if CmbFormaPagamento.Text = '' then
  begin
    ShowMessage('Selecione a forma de pagamento.');
    CmbFormaPagamento.SetFocus;
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

procedure TFormReceitas.CarregarGrid;
begin
  if Assigned(Controller) then
    Controller.Free;

  Controller := TReceitaController.Create;
  DataSourceMain.DataSet := Controller.ListarReceitas;
  DBGridMain.DataSource := DataSourceMain;
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
      DBGridMain.Columns[2].Width := 100;
      DBGridMain.Columns[2].Title.Alignment := taCenter;
      DBGridMain.Columns[2].Alignment := taCenter;
      DBGridMain.Columns[2].FieldName := 'id_cliente';


      DBGridMain.Columns[3].Title.Caption := 'Cliente';
      DBGridMain.Columns[3].Width := 250;
      DBGridMain.Columns[3].Title.Alignment := taCenter;
      DBGridMain.Columns[3].Alignment := taCenter;
      DBGridMain.Columns[3].FieldName := 'cliente_nome';


      DBGridMain.Columns[4].Title.Caption := 'Valor Total';
      DBGridMain.Columns[4].Width := 160;
      DBGridMain.Columns[4].Title.Alignment := taCenter;
      DBGridMain.Columns[4].Alignment := taCenter;

      DBGridMain.Columns[5].Title.Caption := 'Valor Recebido';
      DBGridMain.Columns[5].Width := 160;
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;


      DBGridMain.Columns[6].Title.Caption := 'Status';
      DBGridMain.Columns[6].Width := 140;
      DBGridMain.Columns[6].Title.Alignment := taCenter;
      DBGridMain.Columns[6].Alignment := taCenter;


      DBGridMain.Columns[7].Title.Caption := 'Data Emissão';
      DBGridMain.Columns[7].Width := 160;
      DBGridMain.Columns[7].Title.Alignment := taCenter;
      DBGridMain.Columns[7].Alignment := taCenter;


      DBGridMain.Columns[8].Title.Caption := 'Vencimento';
      DBGridMain.Columns[8].Width := 130;
      DBGridMain.Columns[8].Title.Alignment := taCenter;
      DBGridMain.Columns[8].Alignment := taCenter;


      DBGridMain.Columns[9].Title.Caption := 'Recebimento';
      DBGridMain.Columns[9].Width := 130;
      DBGridMain.Columns[9].Title.Alignment := taCenter;
      DBGridMain.Columns[9].Alignment := taCenter;

      DBGridMain.Columns[10].Title.Caption := 'Forma Pagamento';
      DBGridMain.Columns[10].Width := 170;
      DBGridMain.Columns[10].Title.Alignment := taCenter;
      DBGridMain.Columns[10].Alignment := taCenter;


      DBGridMain.Columns[11].Title.Caption := 'Observação';
      DBGridMain.Columns[11].Width := 260;
      DBGridMain.Columns[11].Title.Alignment := taCenter;
      DBGridMain.Columns[11].Alignment := taCenter;


      DBGridMain.Columns[12].Title.Caption := 'Ativo';
      DBGridMain.Columns[12].Width := 60;
      DBGridMain.Columns[12].Title.Alignment := taCenter;
      DBGridMain.Columns[12].Alignment := taCenter;
    end;
  end;

procedure TFormReceitas.CarregarGridHistorico;
begin
    DataSourceHistorico.DataSet := Controller.ListarHistoricoReceitas;
  DBGridHistorico.DataSource := DataSourceHistorico;
    for var i := 0 to DBGridHistorico.Columns.Count - 1 do begin
    DBGridHistorico.Columns[i].Title.Alignment := taCenter;
    DBGridHistorico.Columns[i].Alignment := taCenter;
    DBGridHistorico.Columns[i].Width := 160;
    DBGridHistorico.Columns[i].Title.Font.Size := 15;
  end;
    if DBGridHistorico.Columns.Count >= 12 then
    begin
      DBGridHistorico.Columns[0].Title.Caption := 'ID';
      DBGridHistorico.Columns[0].Width := 50;
      DBGridHistorico.Columns[0].Title.Alignment := taCenter;
      DBGridHistorico.Columns[0].Alignment := taCenter;


      DBGridHistorico.Columns[1].Title.Caption := 'OS';
      DBGridHistorico.Columns[1].Width := 60;
      DBGridHistorico.Columns[1].Title.Alignment := taCenter;
      DBGridHistorico.Columns[1].Alignment := taCenter;


      DBGridHistorico.Columns[2].Title.Caption := 'Cliente ID';
      DBGridHistorico.Columns[2].Width := 100;
      DBGridHistorico.Columns[2].Title.Alignment := taCenter;
      DBGridHistorico.Columns[2].Alignment := taCenter;
      DBGridHistorico.Columns[2].FieldName := 'id_cliente';


      DBGridHistorico.Columns[3].Title.Caption := 'Cliente';
      DBGridHistorico.Columns[3].Width := 200;
      DBGridHistorico.Columns[3].Title.Alignment := taCenter;
      DBGridHistorico.Columns[3].Alignment := taCenter;
      DBGridHistorico.Columns[3].FieldName := 'cliente_nome';


      DBGridHistorico.Columns[4].Title.Caption := 'Valor Total';
      DBGridHistorico.Columns[4].Width := 120;
      DBGridHistorico.Columns[4].Title.Alignment := taCenter;
      DBGridHistorico.Columns[4].Alignment := taCenter;

      DBGridHistorico.Columns[5].Title.Caption := 'Valor Recebido';
      DBGridHistorico.Columns[5].Width := 120;
      DBGridHistorico.Columns[5].Title.Alignment := taCenter;
      DBGridHistorico.Columns[5].Alignment := taCenter;


      DBGridHistorico.Columns[6].Title.Caption := 'Status';
      DBGridHistorico.Columns[6].Width := 100;
      DBGridHistorico.Columns[6].Title.Alignment := taCenter;
      DBGridHistorico.Columns[6].Alignment := taCenter;


      DBGridHistorico.Columns[7].Title.Caption := 'Data Emissão';
      DBGridHistorico.Columns[7].Width := 140;
      DBGridHistorico.Columns[7].Title.Alignment := taCenter;
      DBGridHistorico.Columns[7].Alignment := taCenter;


      DBGridHistorico.Columns[8].Title.Caption := 'Vencimento';
      DBGridHistorico.Columns[8].Width := 110;
      DBGridHistorico.Columns[8].Title.Alignment := taCenter;
      DBGridHistorico.Columns[8].Alignment := taCenter;


      DBGridHistorico.Columns[9].Title.Caption := 'Recebimento';
      DBGridHistorico.Columns[9].Width := 110;
      DBGridHistorico.Columns[9].Title.Alignment := taCenter;
      DBGridHistorico.Columns[9].Alignment := taCenter;
      DBGridHistorico.Columns[9].Visible := False;

      DBGridHistorico.Columns[10].Title.Caption := 'Forma Pagamento';
      DBGridHistorico.Columns[10].Width := 150;
      DBGridHistorico.Columns[10].Title.Alignment := taCenter;
      DBGridHistorico.Columns[10].Alignment := taCenter;


      DBGridHistorico.Columns[11].Title.Caption := 'Observação';
      DBGridHistorico.Columns[11].Width := 250;
      DBGridHistorico.Columns[11].Title.Alignment := taCenter;
      DBGridHistorico.Columns[11].Alignment := taCenter;


      DBGridHistorico.Columns[12].Title.Caption := 'Ativo';
      DBGridHistorico.Columns[12].Width := 60;
      DBGridHistorico.Columns[12].Title.Alignment := taCenter;
      DBGridHistorico.Columns[12].Alignment := taCenter;
      end;
end;

procedure TFormReceitas.PreencherCamposReceita;
var
  i: Integer;
  IdOrdem: Integer;
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
    CmbStatusReceita.Enabled := False;
  end;

procedure TFormReceitas.CarregarGridRestaurar;
begin
  if Assigned(Controller) then
    Controller.Free;

  Controller := TReceitaController.Create;
  DataSourceRestaurar.DataSet := Controller.ListarReceitasRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  if DBGridRestaurar .Columns.Count >= 12 then
    begin
      DBGridRestaurar.Columns[0].Title.Caption := 'ID';
      DBGridRestaurar.Columns[0].Width := 50;
      DBGridRestaurar.Columns[0].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[0].Alignment := taCenter;


      DBGridRestaurar.Columns[1].Title.Caption := 'OS';
      DBGridRestaurar.Columns[1].Width := 60;
      DBGridRestaurar.Columns[1].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[1].Alignment := taCenter;


      DBGridRestaurar.Columns[2].Title.Caption := 'Cliente ID';
      DBGridRestaurar.Columns[2].Width := 100;
      DBGridRestaurar.Columns[2].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[2].Alignment := taCenter;
      DBGridRestaurar.Columns[2].FieldName := 'id_cliente';


      DBGridRestaurar.Columns[3].Title.Caption := 'Cliente';
      DBGridRestaurar.Columns[3].Width := 250;
      DBGridRestaurar.Columns[3].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[3].Alignment := taCenter;
      DBGridRestaurar.Columns[3].FieldName := 'cliente_nome';


      DBGridRestaurar.Columns[4].Title.Caption := 'Valor Total';
      DBGridRestaurar.Columns[4].Width := 160;
      DBGridRestaurar.Columns[4].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[4].Alignment := taCenter;

      DBGridMain.Columns[5].Title.Caption := 'Valor Recebido';
      DBGridMain.Columns[5].Width := 160;
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;


      DBGridRestaurar.Columns[6].Title.Caption := 'Status';
      DBGridRestaurar.Columns[6].Width := 140;
      DBGridRestaurar.Columns[6].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[6].Alignment := taCenter;


      DBGridRestaurar.Columns[7].Title.Caption := 'Data Emissão';
      DBGridRestaurar.Columns[7].Width := 160;
      DBGridRestaurar.Columns[7].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[7].Alignment := taCenter;


      DBGridRestaurar.Columns[8].Title.Caption := 'Vencimento';
      DBGridRestaurar.Columns[8].Width := 130;
      DBGridRestaurar.Columns[8].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[8].Alignment := taCenter;


      DBGridRestaurar.Columns[9].Title.Caption := 'Recebimento';
      DBGridRestaurar.Columns[9].Width := 130;
      DBGridRestaurar.Columns[9].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[9].Alignment := taCenter;

      DBGridRestaurar.Columns[10].Title.Caption := 'Forma Pagamento';
      DBGridRestaurar.Columns[10].Width := 170;
      DBGridRestaurar.Columns[10].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[10].Alignment := taCenter;


      DBGridRestaurar.Columns[11].Title.Caption := 'Observação';
      DBGridRestaurar.Columns[11].Width := 260;
      DBGridRestaurar.Columns[11].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[11].Alignment := taCenter;


      DBGridRestaurar.Columns[12].Title.Caption := 'Ativo';
      DBGridRestaurar.Columns[12].Width := 60;
      DBGridRestaurar.Columns[12].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[12].Alignment := taCenter;
    end;
end;

procedure TFormReceitas.LimparCampos;
begin
  EdtReceita.Clear;
  EdtValorTotal.Clear;
  EdtValorRecebido.Clear;
  EdtObservacao.Clear;
  CmbFormaPagamento.ItemIndex := -1;
  CmbStatusReceita.ItemIndex := -1;
  EdtDataRecebimento.Date := Date;
end;

procedure TFormReceitas.ExibirDetalhes;
var
  IDReceita: Integer;
  DataSourceAtivo: TDataSource;
begin
  if PnLHistorico.Visible then
    DataSourceAtivo := DataSourceHistorico
  else if PnlRestaurar.Visible then
    DataSourceAtivo := DataSourceRestaurar
  else
    DataSourceAtivo := DataSourceMain;

  if not Assigned(DataSourceAtivo.DataSet) or DataSourceAtivo.DataSet.Eof then
    Exit;

  IDReceita := DataSourceAtivo.DataSet.FieldByName('id').AsInteger;

  ListBoxDetalhes.Items.Clear;
  ListBoxDetalhes.Items.Add(Format('ID: %d', [IDReceita]));
  if DataSourceAtivo.DataSet.FindField('id_ordem_servico') <> nil then
    ListBoxDetalhes.Items.Add(Format('Ordem de Serviço: %d', [
      DataSourceAtivo.DataSet.FieldByName('id_ordem_servico').AsInteger]));
  if (DataSourceAtivo.DataSet.FindField('id_cliente') <> nil) and
     (DataSourceAtivo.DataSet.FindField('cliente_nome') <> nil) then
    ListBoxDetalhes.Items.Add(Format('Cliente ID: %d - %s', [
      DataSourceAtivo.DataSet.FieldByName('id_cliente').AsInteger,
      DataSourceAtivo.DataSet.FieldByName('cliente_nome').AsString]));

  ListBoxDetalhes.Items.Add('');
  ListBoxDetalhes.Items.Add(Format('Valor Total: R$ %.2f', [
    DataSourceAtivo.DataSet.FieldByName('valor_total').AsCurrency]));
  ListBoxDetalhes.Items.Add(Format('Valor Recebido: R$ %.2f', [
    DataSourceAtivo.DataSet.FieldByName('valor_recebido').AsCurrency]));
  ListBoxDetalhes.Items.Add(Format('Data Emissão: %s', [
    FormatDateTime('dd/mm/yyyy', DataSourceAtivo.DataSet.FieldByName('data_emissao').AsDateTime)]));
  ListBoxDetalhes.Items.Add(Format('Data Vencimento: %s', [
    FormatDateTime('dd/mm/yyyy', DataSourceAtivo.DataSet.FieldByName('data_vencimento').AsDateTime)]));
  if not DataSourceAtivo.DataSet.FieldByName('data_recebimento').IsNull then begin
    ListBoxDetalhes.Items.Add(Format('Data Recebimento: %s', [
      FormatDateTime('dd/mm/yyyy', DataSourceAtivo.DataSet.FieldByName('data_recebimento').AsDateTime)]))
   end else begin
    ListBoxDetalhes.Items.Add('Data Recebimento: -');

  ListBoxDetalhes.Items.Add('');
  ListBoxDetalhes.Items.Add(Format('Forma Pagamento: %s', [
    DataSourceAtivo.DataSet.FieldByName('forma_pagamento').AsString]));
  ListBoxDetalhes.Items.Add(Format('Status: %s', [
    DataSourceAtivo.DataSet.FieldByName('status').AsString]));
  ListBoxDetalhes.Items.Add(Format('Observação: %s', [
    DataSourceAtivo.DataSet.FieldByName('observacao').AsString]));
  ListBoxDetalhes.Items.Add(Format('Ativo: %s', [
    IfThen(DataSourceAtivo.DataSet.FieldByName('ativo').AsBoolean, 'Sim', 'Não')]));

  PnlDetlhamento.Visible := True;
end;
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
  EdtValorTotal.Enabled := False;
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
    PnlBackgrounEdit.Visible := False;
    IDReceita := DataSourceMain.DataSet.FieldByName('id').AsInteger;
    Controller.DeletarReceita(IDReceita);
    ShowMessage('Receita excluída com sucesso!');
    CarregarGrid;
  end;
end;

procedure TFormReceitas.BtnDetalharClick(Sender: TObject);
begin
  ExibirDetalhes;
end;

procedure TFormReceitas.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  PnlDetlhamento.Visible := False;
  PnLHistorico.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarGridRestaurar;
end;

procedure TFormReceitas.BtnHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := True;
  PnlRestaurar.Visible := False;
  PnlDetlhamento.Visible := False;
  PnlBackgrounEdit.Visible := False;
  EdtPesquisar.Visible := False;
  CarregarGridHistorico;
end;

procedure TFormReceitas.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  EdtPesquisar.SetFocus;
  If PnlRestaurar.Visible  OR PnLHistorico.Visible then begin
    EdtPesquisar.Enabled := False;
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
  EdtPesquisar.Enabled := True;
  CarregarGrid;
end;

procedure TFormReceitas.ImgFecharHistoricoClick(Sender: TObject);
begin
  PnLHistorico.Visible := False;
  EdtPesquisar.Enabled := True;
  CarregarGrid;
end;

procedure TFormReceitas.ImgFecharDetalhamentoClick(Sender: TObject);
begin
  PnlDetlhamento.Visible := False;
  CarregarGrid;
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
  CarregarGrid;
end;

procedure TFormReceitas.ImgRestaurarClick(Sender: TObject);
var
  IDReceita: Integer;
begin
  if not Assigned(DataSourceRestaurar.DataSet) or DataSourceRestaurar.DataSet.Eof then
  begin
    ShowMessage('Selecione uma receita para restaurar.');
    PnlRestaurar.Visible := False;
    Exit;
  end;

  if MessageDlg('Deseja realmente restaurar esta receita?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    IDReceita := DataSourceRestaurar.DataSet.FieldByName('id').AsInteger;
    Controller.RestaurarReceita(IDReceita);
    ShowMessage('Receita restaurada com sucesso!');
    PnlRestaurar.Visible := False;
    CarregarGridRestaurar;
    CarregarGrid;
  end;
end;

procedure TFormReceitas.LblAtualizarClick(Sender: TObject);
begin
  ReceberReceita;
end;


end.
