unit PendenciaController;

interface

uses
  PendenciaService, uPendencia, Data.DB, Vcl.Dialogs, System.SysUtils, System.Classes;

type
  TPendenciaController = class
  private
    Service: TPendenciaService;
  public
    constructor Create;
    destructor Destroy; override;

    procedure PagarPendencia(aPendencia: TPendencia);
    procedure EditarPendencia(aPendencia: TPendencia);
    procedure DeletarPendencia(const aId: Integer);
    procedure ConcluirPendencia(aPendencia: TPendencia);

    function ListarPendencias: TDataSet;
    function ListarPendenciasRestaurar: TDataSet;
    function ListarHistoricoPendencias: TDataSet;
    function PesquisarPendencias(const aFiltro: String): TDataSet;
    function CarregarClientes: TDataSet;
    function CriarObjeto(aId: Integer; aIdCliente: Integer; aDescricao: String;
                        aValorTotal: Currency;
                        aDataVencimento: TDateTime;
                         aStatus: String;
                        aObservacao: String; aAtivo: Boolean): TPendencia;

    procedure RestaurarPendencia(const aId: Integer);
  end;

implementation

constructor TPendenciaController.Create;
begin
  inherited Create;
  Service := TPendenciaService.Create;
end;

destructor TPendenciaController.Destroy;
begin
  Service.Free;
  inherited;
end;

procedure TPendenciaController.PagarPendencia(aPendencia: TPendencia);
begin
  Service.PagarPendencia(aPendencia);
end;

procedure TPendenciaController.EditarPendencia(aPendencia: TPendencia);
begin
  Service.EditarPendencia(aPendencia);
end;

procedure TPendenciaController.DeletarPendencia(const aId: Integer);
begin
  Service.DeletarPendencia(aId);
end;

procedure TPendenciaController.ConcluirPendencia(aPendencia: TPendencia);
begin
  Service.ConcluirPendencia(aPendencia);
end;

function TPendenciaController.ListarPendencias: TDataSet;
begin
  Result := Service.ListarPendencias;
end;

function TPendenciaController.ListarPendenciasRestaurar: TDataSet;
begin
  Result := Service.ListarPendenciasRestaurar;
end;

function TPendenciaController.ListarHistoricoPendencias: TDataSet;
begin
  Result := Service.ListarHistoricoPendencias;
end;

function TPendenciaController.PesquisarPendencias(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarPendencias(aFiltro);
end;

function TPendenciaController.CarregarClientes: TDataSet;
begin
  Result := Service.CarregarClientes;
end;

function TPendenciaController.CriarObjeto(aId: Integer; aIdCliente: Integer; aDescricao: String;
  aValorTotal: Currency;
  aDataVencimento: TDateTime;
  aStatus: String;
  aObservacao: String; aAtivo: Boolean): TPendencia;
begin
  Result := Service.CriarObjeto(aId, aIdCliente, aDescricao, aValorTotal,
  aDataVencimento,aStatus,
  aObservacao, aAtivo);
end;

procedure TPendenciaController.RestaurarPendencia(const aId: Integer);
begin
  Service.RestaurarPendencia(aId);
end;

end.
