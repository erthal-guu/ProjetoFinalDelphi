unit ServiçoCadastroService;

interface

uses
  uServiço, ServiçoCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes, Logs, uSession;

type
  TServicoService = class
  private
    Repository: TServicoRepository;
  public
    constructor Create;
    function SalvarServico(Servico: TServico): Boolean;
    function CriarObjeto(aNome: String; aCategoria: Integer; aPreco: Currency;
      aObservacao: String; aPecas: Integer; aProfissional: Integer): TServico;
    procedure EditarServico(Servico: TServico);
    function ValidarServico(ServicoValido: TServico): Boolean;
    function ListarServicos: TDataSet;
    function ListarServicosRestaurar: TDataSet;
    procedure DeletarServico(const aId: Integer);
    procedure RestaurarServico(const aId: Integer);
    function PesquisarServicos(const aFiltro: String): TDataSet;
    function CarregarCategorias: TStringList;
    function CarregarPecas: TStringList;
    function CarregarProfissionais: TStringList;
  end;

implementation

constructor TServicoService.Create;
begin
  Repository := TServicoRepository.Create(DataModule1.FDQuery);
end;

function TServicoService.CriarObjeto(
  aNome: String; aCategoria: Integer; aPreco: Currency;
  aObservacao: String; aPecas: Integer; aProfissional: Integer): TServico;
var
  ServicoDTO: TServico;
begin
  ServicoDTO := TServico.Create;
  try
    ServicoDTO.SetNome(aNome);
    ServicoDTO.SetCategoria(aCategoria);
    ServicoDTO.SetPreco(aPreco);
    ServicoDTO.SetObservacao(aObservacao);
    ServicoDTO.SetPecas(aPecas);
    ServicoDTO.SetProfissional(aProfissional);
    Result := ServicoDTO;
  except
    ServicoDTO.Free;
    raise;
  end;
end;

function TServicoService.SalvarServico(Servico: TServico): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarServico(Servico) then
  begin
    Repository.InserirServico(Servico);
    SalvarLog(Format('CADASTRO - ID: %d cadastrou serviço: %s (Categoria: %d)',
      [IDUsuarioLogado, Servico.GetNome, Servico.GetCategoria]));
    Result := True;
  end;
end;

procedure TServicoService.EditarServico(Servico: TServico);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.EditarServico(Servico);
  SalvarLog(Format('EDITAR - ID: %d editou serviço: %s (Categoria: %d)',
    [IDUsuarioLogado, Servico.GetNome, Servico.GetCategoria]));
end;

procedure TServicoService.DeletarServico(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarServico(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou serviço ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TServicoService.RestaurarServico(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarServico(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou serviço ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TServicoService.ListarServicos: TDataSet;
begin
  Result := Repository.ListarServicos;
end;

function TServicoService.ListarServicosRestaurar: TDataSet;
begin
  Result := Repository.ListarServicosRestaurar;
end;

function TServicoService.PesquisarServicos(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarServicos(aFiltro);
end;

function TServicoService.CarregarCategorias: TStringList;
begin
  Result := Repository.CarregarCategorias;
end;

function TServicoService.CarregarPecas: TStringList;
begin
  Result := Repository.CarregarPecas;
end;

function TServicoService.CarregarProfissionais: TStringList;
begin
  Result := Repository.CarregarProfissionais;
end;

function TServicoService.ValidarServico(ServicoValido: TServico): Boolean;
begin
  Result :=
    (ServicoValido.GetNome <> '') and
    (ServicoValido.GetCategoria > 0) and
    (ServicoValido.GetPreco > 0) and
    (ServicoValido.GetProfissional > 0);
end;

end.

