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

  end;

var
  FormReceitas: TFormReceitas;

implementation

{$R *.dfm}


end.
