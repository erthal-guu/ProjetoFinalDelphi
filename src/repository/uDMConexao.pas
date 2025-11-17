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
    FDQueryPendentescliente: TWideStringField;
    FDQueryPendentesquantidade_pendentes: TIntegerField;
    FDQueryPendentesvalor_total_pendente: TBCDField;
    FDQueryPendentesvalor_recebido_pendente: TBCDField;
    FDQueryPendentesvalor_a_receber: TFMTBCDField;
    FDQueryPendentespercentual_pendente: TFMTBCDField;
    FDQueryPendentesvalor_medio_pendente: TBCDField;
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

end.
