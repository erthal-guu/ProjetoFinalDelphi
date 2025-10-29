unit ReceitaService;

interface

uses
  uReceita, ReceitaRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes, Logs, uSession;

type
  TReceitaService = class
  private
    Repository: TReceitaRepository;
  public
    constructor Create;
    function SalvarReceita(Receita: TReceita): Boolean;
    function CriarObjeto(aValorRecebido, aValorTotal: Currency;
      aDataRecebimento: TDateTime; aFormaPagamento, aObservacao,
      aStatus: String; aAtivo: Boolean): TReceita;
    procedure EditarReceita(Receita: TReceita);
    function ValidarReceita(ReceitaValida: TReceita): Boolean;
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
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

constructor TReceitaService.Create;
begin
  Repository := TReceitaRepository.Create(DataModule1.FDQuery);
end;

function TReceitaService.CriarObjeto(aValorRecebido, aValorTotal: Currency;
  aDataRecebimento: TDateTime; aFormaPagamento, aObservacao,
  aStatus: String; aAtivo: Boolean): TReceita;
var
  ReceitaDTO: TReceita;
begin
  ReceitaDTO := TReceita.Create;
  try
    ReceitaDTO.setValorRecebido(aValorRecebido);
    ReceitaDTO.setValorTotal(aValorTotal);
    ReceitaDTO.setDataRecebimento(aDataRecebimento);
    ReceitaDTO.setFormaPagamento(aFormaPagamento);
    ReceitaDTO.setObservacao(aObservacao);
    ReceitaDTO.setStatus(aStatus);
    ReceitaDTO.setAtivo(aAtivo);
    Result := ReceitaDTO;
  except
    ReceitaDTO.Free;
    raise;
  end;
end;

function TReceitaService.SalvarReceita(Receita: TReceita): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarReceita(Receita) then
  begin
    Repository.InserirReceita(Receita);
    SalvarLog(Format('CADASTRO - ID: %d cadastrou receita no valor de R$ %.2f',
      [IDUsuarioLogado, Receita.getValorTotal]));
    Result := True;
  end;
end;

procedure TReceitaService.EditarReceita(Receita: TReceita);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.EditarReceita(Receita);
  SalvarLog(Format('EDITAR - ID: %d editou receita ID: %d',
    [IDUsuarioLogado, Receita.getIdReceita]));
end;

procedure TReceitaService.DeletarReceita(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarReceita(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou receita ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TReceitaService.RestaurarReceita(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarReceita(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou receita ID: %d',
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

function TReceitaService.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarReceitas(aFiltro);
end;

function TReceitaService.CarregarOrdensServico: TStringList;
begin
  Result := Repository.CarregarOrdensServico;
end;

function TReceitaService.ValidarReceita(ReceitaValida: TReceita): Boolean;
begin
  Result :=
    (ReceitaValida.getValorTotal > 0) and
    (ReceitaValida.getDataRecebimento > 0) and
    (ReceitaValida.getFormaPagamento <> '') and
    (ReceitaValida.getStatus <> '');
end;

function TReceitaService.ReceberReceita(const aId: Integer;
  aValorRecebido: Currency; aDataRecebimento: TDateTime;
  aFormaPagamento: String): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  try
    Repository.ReceberReceita(aId, aValorRecebido, aDataRecebimento, aFormaPagamento);
    SalvarLog(Format('RECEBER - ID: %d recebeu receita ID: %d no valor de R$ %.2f',
      [IDUsuarioLogado, aId, aValorRecebido]));
    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao receber receita: ' + E.Message);
    end;
  end;
end;

function TReceitaService.ObterHistoricoReceita(const aId: Integer): TDataSet;
begin
  Result := Repository.ObterHistoricoReceita(aId);
end;

function TReceitaService.ObterDetalhesReceita(const aId: Integer): TReceita;
begin
  Result := Repository.ObterDetalhesReceita(aId);
end;

end.
