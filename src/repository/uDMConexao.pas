unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client,
  Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, frxSmartMemo, frxClass,
  frxDBSet, frCoreClasses;
type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDQuery: TFDQuery;
    FDQueryValorTotal: TFDQuery;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    FDQueryValorTotalCanceladas: TFDQuery;
    frxReport2: TfrxReport;
    frxDBDataset2: TfrxDBDataset;
    FDQueryValorTotalcodigo_cliente: TIntegerField;
    FDQueryValorTotalnome_cliente: TWideStringField;
    FDQueryValorTotalvalor_total_receitas: TFMTBCDField;
    FDQueryValorTotalvalor_total_recebido: TFMTBCDField;
    FDQueryValorTotalquantidade_ordens: TLargeintField;
    FDQueryValorTotalticket_medio_cliente: TFMTBCDField;
    FDQueryValorTotalprimeira_receita: TSQLTimeStampField;
    FDQueryValorTotalultima_receita: TSQLTimeStampField;
    FDQueryValorTotalreceitas_concluidas: TLargeintField;
    FDQueryValorTotalvalor_pendente: TFMTBCDField;
    FDQueryValorTotalCanceladascliente: TWideStringField;
    FDQueryValorTotalCanceladasquantidade_canceladas: TLargeintField;
    FDQueryValorTotalCanceladastotal_cancelado: TFMTBCDField;
    FDQueryValorTotalCanceladastotal_recebido: TFMTBCDField;
    FDQueryValorTotalCanceladastotal_perdido: TFMTBCDField;
    FDQueryValorTotalCanceladaspercentual_recuperado: TFMTBCDField;
    FDQueryValorTotalCanceladaspercentual_perda: TFMTBCDField;
    FDQueryPendentes: TFDQuery;
    frxReport3: TfrxReport;
    frxDBDataset3: TfrxDBDataset;
    FDQueryPendenciasConcluidas: TFDQuery;
    frxReport4: TfrxReport;
    frxDBDataset4: TfrxDBDataset;
    FDQueryPendenciasPendentes: TFDQuery;
    frxReport5: TfrxReport;
    frxDBDataset5: TfrxDBDataset;
    FDQueryPendenciasConcluidascodigo_fornecedor: TIntegerField;
    FDQueryPendenciasConcluidasnome_fornecedor: TWideStringField;
    FDQueryPendenciasConcluidasquantidade_pendencias_concluidas: TLargeintField;
    FDQueryPendenciasConcluidasvalor_total_concluido: TFMTBCDField;
    FDQueryPendenciasConcluidasticket_medio_concluido: TFMTBCDField;
    FDQueryPendenciasConcluidasprimeira_pendencia: TDateField;
    FDQueryPendenciasConcluidasultima_conclusao: TDateField;
    FDQueryPendenciasConcluidasmenor_prazo: TDateField;
    FDQueryPendenciasConcluidasmaior_prazo: TDateField;
    FDQueryPendenciasConcluidastempo_medio_conclusao_dias: TIntegerField;
    FDQueryPendenciasPendentescodigo_fornecedor: TIntegerField;
    FDQueryPendenciasPendentesnome_fornecedor: TWideStringField;
    FDQueryPendenciasPendentesquantidade_pendentes: TLargeintField;
    FDQueryPendenciasPendentesvalor_total_pendente: TFMTBCDField;
    FDQueryPendenciasPendentesvalor_medio_pendente: TFMTBCDField;
    FDQueryPendenciasPendentesprimeira_pendencia: TDateField;
    FDQueryPendenciasPendentesprazo_mais_tarde: TDateField;
    FDQueryPendenciasPendentesprazo_mais_cedo: TDateField;
    FDQueryPendenciasPendentesquantidade_vencidas: TLargeintField;
    FDQueryPendenciasPendentesvalor_vencido: TFMTBCDField;
    FDQueryPendenciasPendentesquantidade_a_vencer: TLargeintField;
    FDQueryPendenciasPendentesvalor_a_vencer: TFMTBCDField;
    FDQueryPendenciasPendentespercentual_vencidas: TFMTBCDField;
    FDQueryValorTotalvalor_total_geral_todas_receitas: TFMTBCDField;
    FDQueryValorTotalCanceladasvalor_total_geral: TFMTBCDField;
    FDQueryPendentescodigo_cliente: TIntegerField;
    FDQueryPendentescliente: TWideStringField;
    FDQueryPendentesquantidade_pendentes: TLargeintField;
    FDQueryPendentesvalor_total_pendente: TFMTBCDField;
    FDQueryPendentesvalor_recebido_pendente: TFMTBCDField;
    FDQueryPendentesvalor_a_receber: TFMTBCDField;
    FDQueryPendentespercentual_pendente: TFMTBCDField;
    FDQueryPendentesvalor_medio_pendente: TFMTBCDField;
    FDQueryPendentesvalor_total_geral: TFMTBCDField;
    FDQueryPendenciasConcluidasvalor_total_geral: TFMTBCDField;
    FDQueryPendenciasPendentesvalor_total_geral: TFMTBCDField;
    procedure FDQueryPendentesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TDataModule1.FDQueryPendentesAfterOpen(DataSet: TDataSet);
begin
    if DataSet.FindField('valor_a_receber') <> nil then
      TFloatField(DataSet.FieldByName('valor_a_receber')).DisplayFormat := '#,##0.00';

    if DataSet.FindField('quantidade_pendentes') <> nil then
      TIntegerField(DataSet.FieldByName('quantidade_pendentes')).DisplayFormat := '#,##0';
  end;

end.

