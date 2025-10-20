unit VeiculoCadastroService;

interface
uses
  uVeiculo, VeiculoCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes;

type
  TVeiculoService = class
  private
    Repository: TVeiculoRepository;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarVeiculo(Veiculo: TVeiculo): Boolean;
    function CriarObjeto(aModelo, aMarca, aChassi, aPlaca, aCor, aFabricacao: String;
     aCliente: Integer): TVeiculo;
    procedure EditarVeiculo(Veiculo: TVeiculo);
    function ValidarVeiculo(VeiculoValido: TVeiculo): Boolean;
    function ListarVeiculos: TDataSet;
    function ListarVeiculosRestaurar: TDataSet;
    procedure DeletarVeiculo(const aId: Integer);
    procedure RestaurarVeiculo(const aId: Integer);
    function PesquisarVeiculos(const aFiltro: String): TDataSet;
    function CarregarClientes: TStringList;
  end;

implementation

constructor TVeiculoService.Create;
begin
  Repository := TVeiculoRepository.Create(DataModule1.FDQuery);
end;

destructor TVeiculoService.Destroy;
begin
  Repository.Free;
  inherited;
end;

function TVeiculoService.CriarObjeto(
  aModelo, aMarca, aChassi, aPlaca, aCor, aFabricacao: String;
  aCliente: Integer): TVeiculo;
var
  Veiculo: TVeiculo;
begin
  Veiculo := TVeiculo.Create;
  try
    Veiculo.setModelo(aModelo);
    Veiculo.setMarca(aMarca);
    Veiculo.setChassi(aChassi);
    Veiculo.setPlaca(aPlaca);
    Veiculo.setCor(aCor);
    Veiculo.setFabricacao(aFabricacao);
    Veiculo.setCliente(aCliente);
    Result := Veiculo;
  except
    Veiculo.Free;
    raise;
  end;
end;

procedure TVeiculoService.DeletarVeiculo(const aId: Integer);
begin
  Repository.DeletarVeiculo(aId);
end;

procedure TVeiculoService.EditarVeiculo(Veiculo: TVeiculo);
begin
  Repository.EditarVeiculo(Veiculo);
end;

function TVeiculoService.ListarVeiculos: TDataSet;
begin
  Result := Repository.ListarVeiculos;
end;

function TVeiculoService.ListarVeiculosRestaurar: TDataSet;
begin
  Result := Repository.ListarVeiculosRestaurar;
end;

function TVeiculoService.PesquisarVeiculos(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarVeiculos(aFiltro);
end;

procedure TVeiculoService.RestaurarVeiculo(const aId: Integer);
begin
  Repository.RestaurarVeiculo(aId);
end;

function TVeiculoService.SalvarVeiculo(Veiculo: TVeiculo): Boolean;
begin
  Result := False;

  if not ValidarVeiculo(Veiculo) then
  begin
    raise Exception.Create('Dados do veículo inválidos!');
  end;

  if Repository.ExistePlaca(Veiculo) then
  begin
    raise Exception.Create('Já existe um veículo cadastrado com esta placa!');
  end;

  if Repository.ExisteChassi(Veiculo) then
  begin
    raise Exception.Create('Já existe um veículo cadastrado com este chassi!');
  end;

  Repository.InserirVeiculo(Veiculo);
  Result := True;
end;

function TVeiculoService.ValidarVeiculo(VeiculoValido: TVeiculo): Boolean;
begin
  Result :=
    (VeiculoValido.getModelo <> '') and
    (VeiculoValido.getMarca <> '') and
    (VeiculoValido.getChassi <> '') and
    (VeiculoValido.getPlaca <> '') and
    (VeiculoValido.getCor <> '') and
    (VeiculoValido.getFabricacao <> '') and
    (VeiculoValido.getCliente > 0);
end;

function TVeiculoService.CarregarClientes: TStringList;
begin
  Result := Repository.CarregarClientes;
end;

end.
