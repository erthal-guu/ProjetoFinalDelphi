unit ServicoCadastroController;

interface

uses
  uServico, ServicoCadastroService, System.Classes, Data.DB, System.SysUtils;

type
  TServicoController = class
  private
    Service: TServicoService;
  public
    constructor Create;
    destructor Destroy; override;
    function CadastrarServico(
      aNome: String; aCategoria: Integer; aPreco: Currency;
      aObservacao: String; aPecas: Integer; aProfissional: Integer
    ): Boolean;
    function EditarServico(Servico: TServico): Boolean;
    function ListarServicos: TDataSet;
    function PesquisarServicos(const aFiltro: String): TDataSet;
    procedure DeletarServico(const aId: Integer);
    procedure RestaurarServico(const aId: Integer);
    function ListarServicosRestaurar: TDataSet;
    function CarregarCategorias: TStringList;
    function CarregarPecas: TStringList;
    function CarregarProfissionais: TStringList;
  end;

implementation

constructor TServicoController.Create;
begin
  Service := TServicoService.Create;
end;

destructor TServicoController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TServicoController.CadastrarServico(
  aNome: String; aCategoria: Integer; aPreco: Currency;
  aObservacao: String; aPecas: Integer; aProfissional: Integer
): Boolean;
var
  Servico: TServico;
begin
  Servico := Service.CriarObjeto(
    aNome, aCategoria, aPreco, aObservacao, aPecas, aProfissional);
  try
    Result := Service.SalvarServico(Servico);
  finally
    Servico.Free;
  end;
end;

function TServicoController.EditarServico(Servico: TServico): Boolean;
begin
  try
    Service.EditarServico(Servico);
    Result := True;
  except
    Result := False;
  end;
end;

function TServicoController.ListarServicos: TDataSet;
begin
  Result := Service.ListarServicos;
end;

function TServicoController.PesquisarServicos(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarServicos(aFiltro);
end;

procedure TServicoController.DeletarServico(const aId: Integer);
begin
  Service.DeletarServico(aId);
end;

procedure TServicoController.RestaurarServico(const aId: Integer);
begin
  Service.RestaurarServico(aId);
end;

function TServicoController.ListarServicosRestaurar: TDataSet;
begin
  Result := Service.ListarServicosRestaurar;
end;

function TServicoController.CarregarCategorias: TStringList;
begin
  Result := Service.CarregarCategorias;
end;

function TServicoController.CarregarPecas: TStringList;
begin
  Result := Service.CarregarPecas;
end;

function TServicoController.CarregarProfissionais: TStringList;
begin
  Result := Service.CarregarProfissionais;
end;

end.
