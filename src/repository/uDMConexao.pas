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
    FDQueryEntradas: TFDQuery;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    FDQueryEntradasid: TIntegerField;
    FDQueryEntradasnome: TWideStringField;
    FDQueryEntradascpf: TWideStringField;
    FDQueryEntradassenha: TWideStringField;
    FDQueryEntradasgrupo: TWideStringField;
    FDQueryEntradasativo: TBooleanField;
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
