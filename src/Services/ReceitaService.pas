unit ReceitaService;

interface

uses
  uReceita, ReceitaRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, Vcl.Dialogs,
  System.Classes, Logs, uSession;

type
  TReceitaService = class
  private
    Repository: TReceitaRepository;
  public
    constructor Create;
    procedure ReceberReceita(aReceita: TReceita);
    procedure DeletarReceita(const aId: Integer);
    procedure RestaurarReceita(const aId: Integer);
    function ValidarReceita(aReceita: TReceita): Boolean;
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
    function ListarHistoricoReceitas: TDataSet;
    function PesquisarReceitas(const aFiltro: String): TDataSet;
    function CarregarOrdensServico: TDataSet;
    function CriarObjeto(aIdReceita: Integer; aValorRecebido: Currency; aDataRecebimento: TDateTime;
                         aValorTotal: Currency; aFormaPagamento: String;
                         aObservacao: String; aStatus: String; aAtivo: Boolean): TReceita;
  end;

implementation

{ TReceitaService }

constructor TReceitaService.Create;
begin

  Repository := TReceitaRepository.Create(DataModule1.FDQuery);
end;

function TReceitaService.CriarObjeto(aIdReceita: Integer; aValorRecebido: Currency; aDataRecebimento: TDateTime;
                                     aValorTotal: Currency; aFormaPagamento: String;
                                     aObservacao: String; aStatus: String; aAtivo: Boolean): TReceita;
var
  Receita: TReceita;
begin
  Receita := TReceita.Create;
  Receita.setIdReceita(aIdReceita);
  Receita.setValorRecebido(aValorRecebido);
  Receita.setDataRecebimento(aDataRecebimento);
  Receita.setValorTotal(aValorTotal);
  Receita.setFormaPagamento(aFormaPagamento);
  Receita.setObservacao(aObservacao);
  Receita.setStatus(aStatus);
  Receita.setAtivo(aAtivo);
  Result := Receita;
end;

function TReceitaService.ValidarReceita(aReceita: TReceita): Boolean;
begin
  Result := (aReceita.getIdReceita > 0) and
            (aReceita.getValorRecebido >= 0) and
            (aReceita.getDataRecebimento > 0) and
            (aReceita.getFormaPagamento <> '') and
            (aReceita.getStatus <> '');
end;


procedure TReceitaService.ReceberReceita(aReceita: TReceita);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarReceita(aReceita) then
  begin
    Repository.ReceberReceita(aReceita);
    SalvarLog(Format('RECEBER - ID: %d registrou recebimento da receita ID: %d - Valor: %.2f',
      [IDUsuarioLogado, aReceita.getIdReceita, aReceita.getValorRecebido]));
  end
  else
  begin
    ShowMessage('Dados da receita inválidos. Verifique as informações.');
    SalvarLog(Format('ERRO - ID: %d tentou registrar recebimento inválido da receita ID: %d',
      [IDUsuarioLogado, aReceita.getIdReceita]));
  end;
end;


procedure TReceitaService.DeletarReceita(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarReceita(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou a receita ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TReceitaService.RestaurarReceita(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarReceita(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou a receita ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TReceitaService.ListarReceitas: TDataSet;
begin
  Result := Repository.ListarReceitas;
end;

function TReceitaService.ListarReceitasRestaurar: TDataSet;
begin
  Result := Repository.ListarReceitasRestaurar;
end;

function TReceitaService.ListarHistoricoReceitas: TDataSet;
begin
  Result := Repository.ListarHistoricoReceitas;
end;

function TReceitaService.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarReceitas(aFiltro);
end;

function TReceitaService.CarregarOrdensServico: TDataSet;
begin
  Result := Repository.CarregarOrdensServico;
end;

end.
