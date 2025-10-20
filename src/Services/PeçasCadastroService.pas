unit PeçasCadastroService;

interface

uses
  uPeças, PeçasCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, System.Classes;

type
  TPecaService = class
  private
    Repository: TPecaRepository;
  public
    constructor Create;
    function SalvarPeca(Peca: TPeca): Boolean;
    function CriarObjeto(aNome, aDescricao, aCodigoInterno: String;
      aCategoria: Integer; aUnidade, aModelo: String; aPreco: Currency;
      aAtivo: Boolean): TPeca;
    procedure EditarPeca(Peca: TPeca);
    function ValidarPeca(PecaValida: TPeca): Boolean;
    function ListarPecas: TDataSet;
    function ListarPecasRestaurar: TDataSet;
    procedure DeletarPeca(const aId: Integer);
    procedure RestaurarPeca(const aId: Integer);
    function PesquisarPecas(const aFiltro: String): TDataSet;
    function CarregarCategorias: TStringList;
  end;

implementation

constructor TPecaService.Create;
begin
  Repository := TPecaRepository.Create(DataModule1.FDQuery);
end;

function TPecaService.CriarObjeto(
  aNome, aDescricao, aCodigoInterno: String;
  aCategoria: Integer;
  aUnidade, aModelo: String; aPreco: Currency; aAtivo: Boolean): TPeca;
var
  PecaDTO: TPeca;
begin
  PecaDTO := TPeca.Create;
  try
    PecaDTO.setNome(aNome);
    PecaDTO.setDescricao(aDescricao);
    PecaDTO.setCodigoInterno(aCodigoInterno);
    PecaDTO.setCategoria(aCategoria);
    PecaDTO.setUnidade(aUnidade);
    PecaDTO.setModelo(aModelo);
    PecaDTO.setAtivo(aAtivo);
    PecaDTO.setPreço(aPreco);
    Result := PecaDTO;
  except
    PecaDTO.Free;
    raise;
  end;
end;

procedure TPecaService.DeletarPeca(const aId: Integer);
begin
  Repository.DeletarPeca(aId);
end;

procedure TPecaService.EditarPeca(Peca: TPeca);
begin
  Repository.EditarPeca(Peca);
end;

function TPecaService.ListarPecas: TDataSet;
begin
  Result := Repository.ListarPecas;
end;

function TPecaService.CarregarCategorias: TStringList;
begin
  Result := Repository.CarregarCategorias;
end;

function TPecaService.ListarPecasRestaurar: TDataSet;
begin
  Result := Repository.ListarPecasRestaurar;
end;

function TPecaService.PesquisarPecas(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarPecas(aFiltro);
end;

procedure TPecaService.RestaurarPeca(const aId: Integer);
begin
  Repository.RestaurarPeca(aId);
end;

function TPecaService.SalvarPeca(Peca: TPeca): Boolean;
begin
  Result := False;
  if ValidarPeca(Peca) then
  begin
    if not Repository.ExisteCodigoInterno(Peca) then
    begin
      Repository.InserirPeca(Peca);
      Result := True;
    end;
  end;
end;

function TPecaService.ValidarPeca(PecaValida: TPeca): Boolean;
begin
  Result :=
    (PecaValida.getNome <> '') and
    (PecaValida.getDescricao <> '') and
    (PecaValida.getCodigoInterno <> '') and
    (PecaValida.getCategoria > 0) and
    (PecaValida.getUnidade <> '') and
    (PecaValida.getModelo <> '') and
    ((PecaValida.getAtivo = True) or (PecaValida.getAtivo = False)) and
    (PecaValida.getPreço > 0);
end;

end.
