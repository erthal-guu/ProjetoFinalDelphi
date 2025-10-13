unit uPeçasDTO;

interface

type
  TPecaDTO = class
  private
    IdPeca : Integer;
    Nome: String;
    Descricao: String;
    CodigoInterno: String;
    Categoria: String;
    Unidade: String;
    Modelo: String;
    Status: String;
  public
    function getIdPeca: Integer;
    procedure setIdPeca(aId: Integer);

    function getNome: String;
    procedure setNome(aNome: String);

    function getDescricao: String;
    procedure setDescricao(aDescricao: String);

    function getCodigoInterno: String;
    procedure setCodigoInterno(aCodigoInterno: String);

    function getCategoria: String;
    procedure setCategoria(aCategoria: String);

    function getUnidade: String;
    procedure setUnidade(aUnidade: String);

    function getModelo: String;
    procedure setModelo(aModelo: String);

    function getStatus: String;
    procedure setStatus(aStatus: String);
  end;

implementation

function TPecaDTO.getIdPeca: Integer;
begin
  Result := IdPeca;
end;

procedure TPecaDTO.setIdPeca(aId: Integer);
begin
  IdPeca := aId;
end;

function TPecaDTO.getNome: String;
begin
  Result := Nome;
end;

procedure TPecaDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TPecaDTO.getDescricao: String;
begin
  Result := Descricao;
end;

procedure TPecaDTO.setDescricao(aDescricao: String);
begin
  Descricao := aDescricao;
end;

function TPecaDTO.getCodigoInterno: String;
begin
  Result := CodigoInterno;
end;

procedure TPecaDTO.setCodigoInterno(aCodigoInterno: String);
begin
  CodigoInterno := aCodigoInterno;
end;

function TPecaDTO.getCategoria: String;
begin
  Result := Categoria;
end;

procedure TPecaDTO.setCategoria(aCategoria: String);
begin
  Categoria := aCategoria;
end;

function TPecaDTO.getUnidade: String;
begin
  Result := Unidade;
end;

procedure TPecaDTO.setUnidade(aUnidade: String);
begin
  Unidade := aUnidade;
end;

function TPecaDTO.getModelo: String;
begin
  Result := Modelo;
end;

procedure TPecaDTO.setModelo(aModelo: String);
begin
  Modelo := aModelo;
end;

function TPecaDTO.getStatus: String;
begin
  Result := Status;
end;

procedure TPecaDTO.setStatus(aStatus: String);
begin
  Status := aStatus;
end;

end.
