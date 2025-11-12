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
    FDQueryValorTotalPendentes: TFDQuery;
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
    FDQueryValorTotalreceitas_recebidas: TLargeintField;
    FDQueryValorTotalreceitas_pendentes: TLargeintField;
    FDQueryValorTotalreceitas_parciais: TLargeintField;
    FDQueryValorTotalvalor_pendente: TFMTBCDField;
    FDQueryValorTotalPendentescliente: TWideStringField;
    FDQueryValorTotalPendentestotal_cancelado: TFMTBCDField;
    FDQueryValorTotalPendentesquantidade_cancelada: TLargeintField;
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
