unit uPeças;

interface

type
  TPeca = class
  private
    IdPeca: Integer;
    Nome: String;
    Descricao: String;
    CodigoInterno: String;
    Categoria: Integer;
    Unidade: String;
    Modelo: String;
    Ativo: Boolean;
    Preço: Currency;
  public
    function getIdPeca: Integer;
    procedure setIdPeca(aId: Integer);
    function getNome: String;
    procedure setNome(aNome: String);
    function getDescricao: String;
    procedure setDescricao(aDescricao: String);
    function getCodigoInterno: String;
    procedure setCodigoInterno(aCodigoInterno: String);
    function getCategoria: Integer;
    procedure setCategoria(aCategoria: Integer);
    function getUnidade: String;
    procedure setUnidade(aUnidade: String);
    function getModelo: String;
    procedure setModelo(aModelo: String);
    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);
    function getPreço: Currency;
    procedure setPreço(aPreço: Currency);
  end;

implementation

function TPeca.getIdPeca: Integer;
begin
  Result := IdPeca;
end;

procedure TPeca.setIdPeca(aId: Integer);
begin
  IdPeca := aId;
end;

function TPeca.getNome: String;
begin
  Result := Nome;
end;

procedure TPeca.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TPeca.getDescricao: String;
begin
  Result := Descricao;
end;

procedure TPeca.setDescricao(aDescricao: String);
begin
  Descricao := aDescricao;
end;

function TPeca.getCodigoInterno: String;
begin
  Result := CodigoInterno;
end;

procedure TPeca.setCodigoInterno(aCodigoInterno: String);
begin
  CodigoInterno := aCodigoInterno;
end;

function TPeca.getCategoria: Integer;
begin
  Result := Categoria;
end;

procedure TPeca.setCategoria(aCategoria: Integer);
begin
  Categoria := aCategoria;
end;

function TPeca.getUnidade: String;
begin
  Result := Unidade;
end;

procedure TPeca.setUnidade(aUnidade: String);
begin
  Unidade := aUnidade;
end;

function TPeca.getModelo: String;
begin
  Result := Modelo;
end;

procedure TPeca.setModelo(aModelo: String);
begin
  Modelo := aModelo;
end;

function TPeca.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TPeca.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

function TPeca.getPreço: Currency;
begin
  Result := Preço;
end;

procedure TPeca.setPreço(aPreço: Currency);
begin
  Preço := aPreço;
end;

end.
