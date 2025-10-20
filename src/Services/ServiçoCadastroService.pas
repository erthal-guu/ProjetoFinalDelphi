unit ServiçoCadastroService;

interface

uses
  uServiço, ServiçoCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes;

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

procedure TServicoService.EditarServico(Servico: TServico);
begin
  Repository.EditarServico(Servico);
end;

function TServicoService.SalvarServico(Servico: TServico): Boolean;
begin
  Result := False;
  if ValidarServico(Servico) then
  begin
    Repository.InserirServico(Servico);
    Result := True;
  end;
end;

function TServicoService.ValidarServico(ServicoValido: TServico): Boolean;
begin
  Result :=
    (ServicoValido.GetNome <> '') and
    (ServicoValido.GetCategoria > 0) and
    (ServicoValido.GetPreco > 0) and
    (ServicoValido.GetProfissional > 0);
end;

function TServicoService.ListarServicos: TDataSet;
begin
  Result := Repository.ListarServicos;
end;

function TServicoService.ListarServicosRestaurar: TDataSet;
begin
  Result := Repository.ListarServicosRestaurar;
end;

procedure TServicoService.DeletarServico(const aId: Integer);
begin
  Repository.DeletarServico(aId);
end;

procedure TServicoService.RestaurarServico(const aId: Integer);
begin
  Repository.RestaurarServico(aId);
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

end.
