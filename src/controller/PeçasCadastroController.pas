unit PeçasCadastroController;

interface

uses
  uPeças, PeçasCadastroService, FireDAC.Comp.Client, Data.DB;

type
  TPecaController = class
  private
    Service: TPecaService;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarPeca(Peca: TPeca): Boolean;
    procedure EditarPeca(Peca: TPeca);
    function ListarPecas: TDataSet;
    function CriarObjeto(
      aNome, aDescricao, aCodigoInterno, aCategoria, aUnidade, aModelo: String;aAtivo:Boolean): TPeca;
    procedure DeletarPeca(const aId: Integer);
    procedure RestaurarPeca(const aId: Integer);
    function PesquisarPecas(const aFiltro: String): TDataSet;
  end;

implementation

constructor TPecaController.Create;
begin
  inherited Create;
  Service := TPecaService.Create;
end;

destructor TPecaController.Destroy;
begin
  Service.Free;
  inherited;
end;

function TPecaController.CriarObjeto(
  aNome, aDescricao, aCodigoInterno, aCategoria, aUnidade, aModelo: String;aAtivo:Boolean): TPeca;
begin
  Result := TPeca.Create;
  Result.setNome(aNome);
  Result.setDescricao(aDescricao);
  Result.setCodigoInterno(aCodigoInterno);
  Result.setCategoria(aCategoria);
  Result.setUnidade(aUnidade);
  Result.setModelo(aModelo);
  Result.setAtivo(aAtivo);
end;

procedure TPecaController.DeletarPeca(const aId: Integer);
begin
  Service.DeletarPeca(aId);
end;

procedure TPecaController.EditarPeca(Peca: TPeca);
begin
  Service.EditarPeca(Peca);
end;

function TPecaController.ListarPecas: TDataSet;
begin
  Result := Service.ListarPecas;
end;

function TPecaController.PesquisarPecas(const aFiltro: String): TDataSet;
begin
  Result := Service.PesquisarPecas(aFiltro);
end;

procedure TPecaController.RestaurarPeca(const aId: Integer);
begin
  Service.RestaurarPeca(aId);
end;

function TPecaController.SalvarPeca(Peca: TPeca): Boolean;
begin
  Result := Service.SalvarPeca(Peca);
end;

end.
