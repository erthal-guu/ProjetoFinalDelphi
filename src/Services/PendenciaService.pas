unit PendenciaService;

interface

uses
  uPendencia, PendenciaRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, Vcl.Dialogs,
  System.Classes, Logs, uSession, RelatoriosRepository;

type
  TPendenciaService = class
  private
    Repository: TPendenciaRepository;
  public
    constructor Create;
    procedure PagarPendencia(aPendencia: TPendencia);
    procedure EditarPendencia(aPendencia: TPendencia);
    procedure DeletarPendencia(const aId: Integer);
    procedure ConcluirPendencia(aPendencia: TPendencia);
    function ValidarPendencia(aPendencia: TPendencia): Boolean;
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

{ TPendenciaService }

constructor TPendenciaService.Create;
begin
  Repository := TPendenciaRepository.Create(DataModule1.FDQuery);
end;

function TPendenciaService.CriarObjeto(aId: Integer; aIdCliente: Integer; aDescricao: String;
  aValorTotal: Currency;
  aDataVencimento: TDateTime;
  aStatus: String;
  aObservacao: String; aAtivo: Boolean): TPendencia;
var
  Pendencia: TPendencia;
begin
  Pendencia := TPendencia.Create;
  Pendencia.setId(aId);
  Pendencia.setIdCliente(aIdCliente);
  Pendencia.setDescricao(aDescricao);
  Pendencia.setValorTotal(aValorTotal);
  Pendencia.setDataVencimento(aDataVencimento);
  Pendencia.setStatus(aStatus);
  Pendencia.setObservacao(aObservacao);
  Pendencia.setAtivo(aAtivo);
  Result := Pendencia;
end;

function TPendenciaService.ValidarPendencia(aPendencia: TPendencia): Boolean;
begin
  Result := (aPendencia.getIdCliente > 0) and
            (Trim(aPendencia.getDescricao) <> '') and
            (Trim(aPendencia.getStatus) <> '');
end;

procedure TPendenciaService.PagarPendencia(aPendencia: TPendencia);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarPendencia(aPendencia) then
  begin
    if not Repository.ExistePendencia(aPendencia) then
    begin
      Repository.PagarPendencia(aPendencia);
      SalvarLog(Format('CADASTRO - ID: %d cadastrou pendência para cliente ID: %d - Descrição: %s',
        [IDUsuarioLogado, aPendencia.getIdCliente, aPendencia.getDescricao]));
    end
    else
    begin
      ShowMessage('Já existe uma pendência com esta descrição para este cliente.');
      SalvarLog(Format('ERRO - ID: %d tentou cadastrar pendência duplicada para cliente ID: %d - Descrição: %s',
        [IDUsuarioLogado, aPendencia.getIdCliente, aPendencia.getDescricao]));
    end;
  end
  else
  begin
    ShowMessage('Dados Inválidos, verifique todos os campos obrigatórios.');
    SalvarLog(Format('ERRO - ID: %d tentou cadastrar pendência inválida - Cliente: %d - Descrição: %s - Status: %s',
      [IDUsuarioLogado, aPendencia.getIdCliente, aPendencia.getDescricao, aPendencia.getStatus]));
  end;
end;

procedure TPendenciaService.EditarPendencia(aPendencia: TPendencia);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarPendencia(aPendencia) then
  begin
    if Repository.EditarPendencia(aPendencia) then
    begin
      SalvarLog(Format('EDIÇÃO - ID: %d editou pendência ID: %d - Cliente: %d - Descrição: %s',
        [IDUsuarioLogado, aPendencia.getId, aPendencia.getIdCliente, aPendencia.getDescricao]));
    end
    else
    begin
      ShowMessage('Não foi possível editar a pendência. Verifique os dados e tente novamente.');
    end;
  end
  else
  begin
    ShowMessage('Dados Inválidos, verifique todos os campos obrigatórios.');
    SalvarLog(Format('ERRO - ID: %d tentou editar pendência inválida ID: %d',
      [IDUsuarioLogado, aPendencia.getId]));
  end;
end;

procedure TPendenciaService.DeletarPendencia(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarPendencia(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou a pendência ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TPendenciaService.ConcluirPendencia(aPendencia: TPendencia);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if aPendencia.getId > 0 then
  begin
    aPendencia.setStatus('CONCLUIDA');
    Repository.ConcluirPendencia(aPendencia);
    SalvarLog(Format('CONCLUSÃO - ID: %d concluiu pendência ID: %d - Cliente: %d - Descrição: %s',
      [IDUsuarioLogado, aPendencia.getId, aPendencia.getIdCliente, aPendencia.getDescricao]));
  end
  else
  begin
    ShowMessage('Selecione uma pendência válida para concluir.');
    SalvarLog(Format('ERRO - ID: %d tentou concluir pendência inválida',[IDUsuarioLogado]));
  end;
end;

function TPendenciaService.ListarPendencias: TDataSet;
begin
  Result := Repository.ListarPendencias;
end;

function TPendenciaService.ListarPendenciasRestaurar: TDataSet;
begin
  Result := Repository.ListarPendenciasRestaurar;
end;

function TPendenciaService.ListarHistoricoPendencias: TDataSet;
begin
  Result := Repository.ListarHistoricoPendencias;
end;

function TPendenciaService.PesquisarPendencias(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarPendencias(aFiltro);
end;

function TPendenciaService.CarregarClientes: TDataSet;
begin
  Result := Repository.CarregarClientes;
end;

procedure TPendenciaService.RestaurarPendencia(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarPendencia(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou a pendência ID: %d',
    [IDUsuarioLogado, aId]));
end;

end.
