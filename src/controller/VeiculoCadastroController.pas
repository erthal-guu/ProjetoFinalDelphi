unit VeiculoCadastroController;

interface

uses
  uVeiculo, VeiculoCadastroService, System.Classes, Data.DB, System.SysUtils;

type
  TVeiculoController = class
  private
    Service: TVeiculoService;
  public
    constructor Create;
    destructor Destroy; override;
    function CadastrarVeiculo(
      aModelo, aMarca, aChassi, aPlaca, aCor, aFabricacao: String; aCliente: Integer
    ): Boolean;
    function EditarVeiculo(Veiculo: TVeiculo): Boolean;
    function ListarVeiculos: TDataSet;
    function PesquisarVeiculos(const aFiltro: String): TDataSet;
    procedure DeletarVeiculo(const aID: Integer);
    procedure RestaurarVeiculo(const aID: Integer);
    function ListarVeiculosRestaurar: TDataSet;
    function CarregarClientes: TStringList;
  end;

implementation

constructor TVeiculoController.Create;
begin
  Service := TVeiculoService.Create;
end;

destructor TVeiculoController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TVeiculoController.CadastrarVeiculo(
  aModelo, aMarca, aChassi, aPlaca, aCor, aFabricacao: String;
  aCliente: Integer
): Boolean;
var
  Veiculo: TVeiculo;
begin
  Veiculo := Service.CriarObjeto(
    aModelo, aMarca, aChassi, aPlaca, aCor, aFabricacao, aCliente);
  try
    Result := Service.SalvarVeiculo(Veiculo);
  finally
    Veiculo.Free;
  end;
end;

function TVeiculoController.EditarVeiculo(Veiculo: TVeiculo): Boolean;
begin
  try
    Service.EditarVeiculo(Veiculo);
    Result := True;
  except
    Result := False;
  end;
end;

function TVeiculoController.ListarVeiculos: TDataSet;
begin
  Result := Service.ListarVeiculos;
end;

function TVeiculoController.PesquisarVeiculos(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarVeiculos(aFiltro);
end;

procedure TVeiculoController.DeletarVeiculo(const aID: Integer);
begin
  Service.DeletarVeiculo(aID);
end;

procedure TVeiculoController.RestaurarVeiculo(const aID: Integer);
begin
  Service.RestaurarVeiculo(aID);
end;

function TVeiculoController.ListarVeiculosRestaurar: TDataSet;
begin
  Result := Service.ListarVeiculosRestaurar;
end;

function TVeiculoController.CarregarClientes: TStringList;
begin
  Result := Service.CarregarClientes;
end;

end.
