unit VeiculoCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uVeiculo, Data.DB, System.Classes;

type
  TVeiculoRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirVeiculo(aVeiculo: TVeiculo);
    function EditarVeiculo(aVeiculo: TVeiculo): Boolean;
    function ListarVeiculos: TDataSet;
    function ListarVeiculosRestaurar: TDataSet;
    procedure DeletarVeiculo(const aID: Integer);
    procedure RestaurarVeiculo(const aID: Integer);
    function PesquisarVeiculos(const aFiltro: String): TDataSet;
    function CarregarClientes: TStringList;
    function ExistePlaca(aVeiculo: TVeiculo): Boolean;
    function ExisteChassi(aVeiculo: TVeiculo): Boolean;
  end;

implementation

constructor TVeiculoRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TVeiculoRepository.InserirVeiculo(aVeiculo: TVeiculo);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('INSERT INTO veiculos (modelo, marca, chassi, placa, cor, fabricacao, id_cliente, ativo)');
  FQuery.SQL.Add('VALUES (:modelo, :marca, :chassi, :placa, :cor, :fabricacao, :id_cliente, :ativo)');
  FQuery.ParamByName('modelo').AsString      := aVeiculo.getModelo;
  FQuery.ParamByName('marca').AsString       := aVeiculo.getMarca;
  FQuery.ParamByName('chassi').AsString      := aVeiculo.getChassi;
  FQuery.ParamByName('placa').AsString       := aVeiculo.getPlaca;
  FQuery.ParamByName('cor').AsString         := aVeiculo.getCor;
  FQuery.ParamByName('fabricacao').AsString  := aVeiculo.getFabricacao;
  FQuery.ParamByName('id_cliente').AsInteger := aVeiculo.getCliente;
  FQuery.ParamByName('ativo').AsBoolean      := True;
  FQuery.ExecSQL;
end;

function TVeiculoRepository.EditarVeiculo(aVeiculo: TVeiculo): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE veiculos SET');
    FQuery.SQL.Add('modelo = :modelo, marca = :marca, chassi = :chassi, placa = :placa,');
    FQuery.SQL.Add('cor = :cor, fabricacao = :fabricacao, id_cliente = :id_cliente, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('modelo').AsString      := aVeiculo.getModelo;
    FQuery.ParamByName('marca').AsString       := aVeiculo.getMarca;
    FQuery.ParamByName('chassi').AsString      := aVeiculo.getChassi;
    FQuery.ParamByName('placa').AsString       := aVeiculo.getPlaca;
    FQuery.ParamByName('cor').AsString         := aVeiculo.getCor;
    FQuery.ParamByName('fabricacao').AsString  := aVeiculo.getFabricacao;
    FQuery.ParamByName('id_cliente').AsInteger := aVeiculo.getCliente;
    FQuery.ParamByName('ativo').AsBoolean      := True;
    FQuery.ParamByName('id').AsInteger         := aVeiculo.getIdVeiculo;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao editar veículo: ' + E.Message);
  end;
end;

function TVeiculoRepository.ListarVeiculos: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT v.id, v.modelo, v.marca, v.chassi, v.placa, v.cor, v.fabricacao, cli.nome as "Cliente", v.ativo');
    FQuery.SQL.Add('FROM veiculos v');
    FQuery.SQL.Add('INNER JOIN clientes cli ON v.id_cliente = cli.id');
    FQuery.SQL.Add('WHERE v.ativo = TRUE');
    FQuery.SQL.Add('ORDER BY v.id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Veículos: ' + E.Message);
  end;
end;

function TVeiculoRepository.ListarVeiculosRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, modelo, marca, chassi, placa, cor, fabricacao, id_cliente, ativo');
    FQuery.SQL.Add('FROM veiculos WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar veículos para restauração: ' + E.Message);
  end;
end;

procedure TVeiculoRepository.DeletarVeiculo(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE veiculos SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TVeiculoRepository.RestaurarVeiculo(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE veiculos SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TVeiculoRepository.PesquisarVeiculos(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, modelo, marca, chassi, placa, cor, fabricacao, id_cliente, ativo');
    FQuery.SQL.Add('FROM veiculos');
    FQuery.SQL.Add('WHERE (modelo ILIKE :filtro OR placa ILIKE :filtro OR marca ILIKE :filtro OR chassi ILIKE :filtro)');
    FQuery.SQL.Add('AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar veículo por filtro: ' + E.Message);
  end;
end;

function TVeiculoRepository.CarregarClientes: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM clientes ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  except
    on E: Exception do
    begin
      Lista.Free;
      raise Exception.Create('Erro ao listar Clientes: ' + E.Message);
    end;
  end;
  Qry.Free;
end;

function TVeiculoRepository.ExistePlaca(aVeiculo: TVeiculo): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM veiculos WHERE placa = :placa');
  FQuery.ParamByName('placa').AsString := aVeiculo.getPlaca;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

function TVeiculoRepository.ExisteChassi(aVeiculo: TVeiculo): Boolean;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS Total FROM veiculos WHERE chassi = :chassi');
  FQuery.ParamByName('chassi').AsString := aVeiculo.getChassi;
  FQuery.Open;
  Result := FQuery.FieldByName('Total').AsInteger > 0;
end;

end.
