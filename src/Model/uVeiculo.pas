unit uVeiculo;

interface

type
  TVeiculo = class
  private
    IdVeiculo: Integer;
    Modelo: String;
    Marca: String;
    Chassi: String;
    Placa: String;
    Cor: String;
    Fabricacao: String;
    Categoria: Integer;
    Cliente: Integer;
  public
    function getIdVeiculo: Integer;
    procedure setIdVeiculo(aId: Integer);
    function getModelo: String;
    procedure setModelo(aModelo: String);
    function getMarca: String;
    procedure setMarca(aMarca: String);
    function getChassi: String;
    procedure setChassi(aChassi: String);
    function getPlaca: String;
    procedure setPlaca(aPlaca: String);
    function getCor: String;
    procedure setCor(aCor: String);
    function getFabricacao: String;
    procedure setFabricacao(aFabricacao: String);
    function getCategoria: Integer;
    procedure setCategoria(aCategoria: Integer);
    function getCliente: Integer;
    procedure setCliente(aCliente: Integer);
  end;

implementation

function TVeiculo.getIdVeiculo: Integer;
begin
  Result := IdVeiculo;
end;

procedure TVeiculo.setIdVeiculo(aId: Integer);
begin
  IdVeiculo := aId;
end;

function TVeiculo.getModelo: String;
begin
  Result := Modelo;
end;

procedure TVeiculo.setModelo(aModelo: String);
begin
  Modelo := aModelo;
end;

function TVeiculo.getMarca: String;
begin
  Result := Marca;
end;

procedure TVeiculo.setMarca(aMarca: String);
begin
  Marca := aMarca;
end;

function TVeiculo.getChassi: String;
begin
  Result := Chassi;
end;

procedure TVeiculo.setChassi(aChassi: String);
begin
  Chassi := aChassi;
end;

function TVeiculo.getPlaca: String;
begin
  Result := Placa;
end;

procedure TVeiculo.setPlaca(aPlaca: String);
begin
  Placa := aPlaca;
end;

function TVeiculo.getCor: String;
begin
  Result := Cor;
end;

procedure TVeiculo.setCor(aCor: String);
begin
  Cor := aCor;
end;

function TVeiculo.getFabricacao: String;
begin
  Result := Fabricacao;
end;

procedure TVeiculo.setFabricacao(aFabricacao: String);
begin
  Fabricacao := aFabricacao;
end;

function TVeiculo.getCategoria: Integer;
begin
  Result := Categoria;
end;

procedure TVeiculo.setCategoria(aCategoria: Integer);
begin
  Categoria := aCategoria;
end;

function TVeiculo.getCliente: Integer;
begin
  Result := Cliente;
end;

procedure TVeiculo.setCliente(aCliente: Integer);
begin
  Cliente := aCliente;
end;

end.
