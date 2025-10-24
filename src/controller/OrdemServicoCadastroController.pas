unit OrdemServicoCadastroController;

interface

uses
  uOrdemServico, OrdemServicoCadastroService, FireDAC.Comp.Client, Data.DB,
  System.Classes, System.Generics.Collections;

type
  TOrdemServicoController = class
  private
    Service: TOrdemServicoService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarOrdemServico(OS: TOrdemServico; PecasIDs: TList<Integer>): Boolean;
    procedure EditarOrdemServico(OS: TOrdemServico; PecasIDs: TList<Integer>);
    function ListarOrdensServico: TDataSet;
    function CriarObjeto(aIdServico, aIdFuncionario, aIdVeiculo, aIdCliente: Integer;
      aPreco: Currency; aAtivo: Boolean): TOrdemServico;
    procedure DeletarOrdemServico(const aId: Integer);
    procedure RestaurarOrdemServico(const aId: Integer);
    function PesquisarOrdensServico(const aFiltro: String): TDataSet;
    function CarregarServicos: TStringList;
    function CarregarFuncionarios: TStringList;
    function CarregarVeiculos: TStringList;
    function CarregarClientes: TStringList;
    function CarregarPecas: TStringList;
    function CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
  end;

implementation

constructor TOrdemServicoController.Create;
begin
  inherited Create;
  Service := TOrdemServicoService.Create;
end;

destructor TOrdemServicoController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TOrdemServicoController.CriarObjeto(aIdServico, aIdFuncionario, aIdVeiculo,
  aIdCliente: Integer; aPreco: Currency; aAtivo: Boolean): TOrdemServico;
begin
  Result := TOrdemServico.Create;
  Result.setIdServico(aIdServico);
  Result.setIdFuncionario(aIdFuncionario);
  Result.setIdVeiculo(aIdVeiculo);
  Result.setIdCliente(aIdCliente);
  Result.setPreco(aPreco);
  Result.setAtivo(aAtivo);
end;

function TOrdemServicoController.SalvarOrdemServico(OS: TOrdemServico;
  PecasIDs: TList<Integer>): Boolean;
begin
  Result := Service.SalvarOrdemServico(OS, PecasIDs);
end;

procedure TOrdemServicoController.EditarOrdemServico(OS: TOrdemServico;
  PecasIDs: TList<Integer>);
begin
  Service.EditarOrdemServico(OS, PecasIDs);
end;

procedure TOrdemServicoController.DeletarOrdemServico(const aId: Integer);
begin
  Service.DeletarOrdemServico(aId);
end;

procedure TOrdemServicoController.RestaurarOrdemServico(const aId: Integer);
begin
  Service.RestaurarOrdemServico(aId);
end;

function TOrdemServicoController.ListarOrdensServico: TDataSet;
begin
  Result := Service.ListarOrdensServico;
end;

function TOrdemServicoController.PesquisarOrdensServico(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarOrdensServico(aFiltro);
end;

function TOrdemServicoController.CarregarServicos: TStringList;
begin
  Result := Service.CarregarServicos;
end;

function TOrdemServicoController.CarregarFuncionarios: TStringList;
begin
  Result := Service.CarregarFuncionarios;
end;

function TOrdemServicoController.CarregarVeiculos: TStringList;
begin
  Result := Service.CarregarVeiculos;
end;

function TOrdemServicoController.CarregarClientes: TStringList;
begin
  Result := Service.CarregarClientes;
end;

function TOrdemServicoController.CarregarPecas: TStringList;
begin
  Result := Service.CarregarPecas;
end;

function TOrdemServicoController.CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
begin
  Result := Service.CarregarPecasDaOS(aIDOS);
end;

end.
