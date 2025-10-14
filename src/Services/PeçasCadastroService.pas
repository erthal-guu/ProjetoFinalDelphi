unit PeçasCadastroService;

interface

uses
  uPeçasDTO, PeçasCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB;

type
  TPecaService = class
  private
    Repository: TPecaRepository;
  public
    constructor Create;
    function SalvarPeca(PecaDTO: TPecaDTO): Boolean;
    function CriarObjeto(aNome, aDescricao, aCodigoInterno, aCategoria, aUnidade, aModelo:String;aAtivo : Boolean): TPecaDTO;
    procedure EditarPeca(PecaDTO: TPecaDTO);
    function ValidarPeca(PecaValida: TPecaDTO): Boolean;
    function ListarPecas: TDataSet;
    function ListarPecasRestaurar: TDataSet;
    procedure DeletarPeca(const aId: Integer);
    procedure RestaurarPeca(const aId: Integer);
    function PesquisarPecas(const aFiltro: String): TDataSet;
  end;

implementation

constructor TPecaService.Create;
begin
  Repository := TPecaRepository.Create(DataModule1.FDQuery);
end;

function TPecaService.CriarObjeto(
  aNome, aDescricao, aCodigoInterno, aCategoria, aUnidade, aModelo:String;aAtivo : Boolean): TPecaDTO;
var
  PecaDTO: TPecaDTO;
begin
  PecaDTO := TPecaDTO.Create;
  try
    PecaDTO.setNome(aNome);
    PecaDTO.setDescricao(aDescricao);
    PecaDTO.setCodigoInterno(aCodigoInterno);
    PecaDTO.setCategoria(aCategoria);
    PecaDTO.setUnidade(aUnidade);
    PecaDTO.setModelo(aModelo);
    PecaDTO.setAtivo(aAtivo);
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

procedure TPecaService.EditarPeca(PecaDTO: TPecaDTO);
begin
  Repository.EditarPeca(PecaDTO);
end;

function TPecaService.ListarPecas: TDataSet;
begin
  Result := Repository.ListarPecas;
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

function TPecaService.SalvarPeca(PecaDTO: TPecaDTO): Boolean;
begin
  Result := False;
  if ValidarPeca(PecaDTO) then
  begin
    if not Repository.ExisteCodigoInterno(PecaDTO) then
    begin
      Repository.InserirPeca(PecaDTO);
      Result := True;
    end;
  end;
end;

function TPecaService.ValidarPeca(PecaValida: TPecaDTO): Boolean;
begin
  Result :=
    (PecaValida.getNome <> '') and
    (PecaValida.getDescricao <> '') and
    (PecaValida.getCodigoInterno <> '') and
    (PecaValida.getCategoria <> '') and
    (PecaValida.getUnidade <> '') and
    (PecaValida.getModelo <> '') and
    (PecaValida.getAtivo = True) or (PecaValida.getAtivo = False);
end;

end.
