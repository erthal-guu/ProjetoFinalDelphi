unit ReceitaController;

interface

uses uReceita, ReceitaService, FireDAC.Comp.Client, Vcl.Dialogs, Data.DB, System.Classes;

type
  TReceitaController = class
  private
    Service: TReceitaService;
  public
    constructor Create;

    procedure ReceberReceita(Receita: TReceita);
    procedure DeletarReceita(const aId: Integer);
    procedure RestaurarReceita(const aId: Integer);
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
    function ListarHistoricoReceitas: TDataSet;
    function PesquisarReceitas(const aFiltro: String): TDataSet;
    function CarregarOrdensServico: TDataSet;
    function CriarObjeto(aIdReceita: Integer; aValorRecebido: Currency; aDataRecebimento: TDateTime;
                         aValorTotal: Currency; aFormaPagamento: String;
                         aObservacao: String; aAtivo: Boolean): TReceita;
  end;

implementation

{ TReceitaController }

constructor TReceitaController.Create;
begin
  Self.Service := TReceitaService.Create;
end;

function TReceitaController.CriarObjeto(aIdReceita: Integer; aValorRecebido: Currency; aDataRecebimento: TDateTime;
                                       aValorTotal: Currency; aFormaPagamento: String;
                                       aObservacao: String; aAtivo: Boolean): TReceita;
begin
  Result := Service.CriarObjeto(aIdReceita, aValorRecebido, aDataRecebimento,
                               aValorTotal, aFormaPagamento, aObservacao, aAtivo);
end;


procedure TReceitaController.ReceberReceita(Receita: TReceita);
begin
  Service.ReceberReceita(Receita);
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

function TReceitaController.ListarHistoricoReceitas: TDataSet;
begin
  Result := Service.ListarHistoricoReceitas;
end;

function TReceitaController.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarReceitas(aFiltro);
end;

function TReceitaController.CarregarOrdensServico: TDataSet;
begin
  Result := Service.CarregarOrdensServico;
end;

end.
