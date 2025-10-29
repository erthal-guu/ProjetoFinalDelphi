unit ReceitaController;

interface

uses
  uReceita, ReceitaService, FireDAC.Comp.Client, Data.DB,
  System.Classes, System.SysUtils;

type
  TReceitaController = class
  private
    Service: TReceitaService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarReceita(Receita: TReceita): Boolean;
    procedure EditarReceita(Receita: TReceita);
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
    function CriarObjeto(aValorRecebido, aValorTotal: Currency;
      aDataRecebimento: TDateTime; aFormaPagamento, aObservacao,
      aStatus: String; aAtivo: Boolean): TReceita;
    procedure DeletarReceita(const aId: Integer);
    procedure RestaurarReceita(const aId: Integer);
    function PesquisarReceitas(const aFiltro: String): TDataSet;
    function CarregarOrdensServico: TStringList;
    function ReceberReceita(const aId: Integer; aValorRecebido: Currency;
      aDataRecebimento: TDateTime; aFormaPagamento: String): Boolean;
    function ObterHistoricoReceita(const aId: Integer): TDataSet;
    function ObterDetalhesReceita(const aId: Integer): TReceita;
  end;

implementation

constructor TReceitaController.Create;
begin
  inherited Create;
  Service := TReceitaService.Create;
end;

destructor TReceitaController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TReceitaController.CriarObjeto(aValorRecebido, aValorTotal: Currency;
  aDataRecebimento: TDateTime; aFormaPagamento, aObservacao,
  aStatus: String; aAtivo: Boolean): TReceita;
begin
  Result := TReceita.Create;
  Result.setValorRecebido(aValorRecebido);
  Result.setValorTotal(aValorTotal);
  Result.setDataRecebimento(aDataRecebimento);
  Result.setFormaPagamento(aFormaPagamento);
  Result.setObservacao(aObservacao);
  Result.setStatus(aStatus);
  Result.setAtivo(aAtivo);
end;

function TReceitaController.SalvarReceita(Receita: TReceita): Boolean;
begin
  Result := Service.SalvarReceita(Receita);
end;

procedure TReceitaController.EditarReceita(Receita: TReceita);
begin
  Service.EditarReceita(Receita);
end;

procedure TReceitaController.DeletarReceita(const aId: Integer);
begin
  Service.DeletarReceita(aId);
end;

procedure TReceitaController.RestaurarReceita(const aId: Integer);
begin
  Service.RestaurarReceita(aId);
end;

function TReceitaController.ListarReceitas: TDataSet;
begin
  Result := Service.ListarReceitas;
end;

function TReceitaController.ListarReceitasRestaurar: TDataSet;
begin
  Result := Service.ListarReceitasRestaurar;
end;

function TReceitaController.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarReceitas(aFiltro);
end;

function TReceitaController.CarregarOrdensServico: TStringList;
begin
  Result := Service.CarregarOrdensServico;
end;

function TReceitaController.ReceberReceita(const aId: Integer;
  aValorRecebido: Currency; aDataRecebimento: TDateTime;
  aFormaPagamento: String): Boolean;
begin
  Result := Service.ReceberReceita(aId, aValorRecebido, aDataRecebimento, aFormaPagamento);
end;

function TReceitaController.ObterHistoricoReceita(const aId: Integer): TDataSet;
begin
  Result := Service.ObterHistoricoReceita(aId);
end;

function TReceitaController.ObterDetalhesReceita(const aId: Integer): TReceita;
begin
  Result := Service.ObterDetalhesReceita(aId);
end;

end.
