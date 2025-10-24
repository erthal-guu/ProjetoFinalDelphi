unit OrdemServicoCadastroRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uOrdemServico, Data.DB,
  System.Classes, System.Generics.Collections;

type
  TOrdemServicoRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure InserirOrdemServico(aOS: TOrdemServico; aPecasIDs: TList<Integer>);
    function EditarOrdemServico(aOS: TOrdemServico; aPecasIDs: TList<Integer>): Boolean;
    function ListarOrdensServico: TDataSet;
    function ListarOrdensServicoRestaurar: TDataSet;
    procedure DeletarOrdemServico(const aID: Integer);
    procedure RestaurarOrdemServico(const aID: Integer);
    function PesquisarOrdensServico(const aFiltro: String): TDataSet;
    function CarregarServicos: TStringList;
    function CarregarFuncionarios: TStringList;
    function CarregarVeiculos: TStringList;
    function CarregarClientes: TStringList;
    function CarregarPecas: TStringList;
    function CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
    function ObterPrecoServico(const aIDServico: Integer): Currency;
    function ObterPrecoPecas(const aIDsPecasString: String): Currency;
    function ObterPorcentagemMarcaVeiculo(const aIDVeiculo: Integer): Currency;
    function ObterClienteDoVeiculo(const aIDVeiculo: Integer): Integer;
  end;

implementation

constructor TOrdemServicoRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

procedure TOrdemServicoRepository.InserirOrdemServico(aOS: TOrdemServico; aPecasIDs: TList<Integer>);
var
  OSID: Integer;
  PecaID: Integer;
begin
  FQuery.Connection.StartTransaction;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('INSERT INTO ordens_servico (id_servico, id_funcionario, id_veiculo, id_cliente, preco, ativo)');
    FQuery.SQL.Add('VALUES (:id_servico, :id_funcionario, :id_veiculo, :id_cliente, :preco, :ativo)');
    FQuery.SQL.Add('RETURNING id');
    FQuery.ParamByName('id_servico').AsInteger := aOS.getIdServico;
    FQuery.ParamByName('id_funcionario').AsInteger := aOS.getIdFuncionario;
    FQuery.ParamByName('id_veiculo').AsInteger := aOS.getIdVeiculo;
    FQuery.ParamByName('id_cliente').AsInteger := aOS.getIdCliente;
    FQuery.ParamByName('preco').AsCurrency := aOS.getPreco;
    FQuery.ParamByName('ativo').AsBoolean := aOS.getAtivo;
    FQuery.Open;
    OSID := FQuery.FieldByName('id').AsInteger;

    if Assigned(aPecasIDs) then
    begin
      for PecaID in aPecasIDs do
      begin
        FQuery.Close;
        FQuery.SQL.Clear;
        FQuery.SQL.Add('INSERT INTO ordem_servico_pecas (id_ordem_servico, id_peca)');
        FQuery.SQL.Add('VALUES (:id_ordem_servico, :id_peca)');
        FQuery.ParamByName('id_ordem_servico').AsInteger := OSID;
        FQuery.ParamByName('id_peca').AsInteger := PecaID;
        FQuery.ExecSQL;
      end;
    end;

    FQuery.Connection.Commit;
  except
    FQuery.Connection.Rollback;
    raise;
  end;
end;

function TOrdemServicoRepository.EditarOrdemServico(aOS: TOrdemServico; aPecasIDs: TList<Integer>): Boolean;
var
  PecaID: Integer;
begin
  Result := False;
  FQuery.Connection.StartTransaction;
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE ordens_servico SET');
    FQuery.SQL.Add('id_servico = :id_servico, id_funcionario = :id_funcionario, id_veiculo = :id_veiculo,');
    FQuery.SQL.Add('id_cliente = :id_cliente, preco = :preco, ativo = :ativo');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('id_servico').AsInteger := aOS.getIdServico;
    FQuery.ParamByName('id_funcionario').AsInteger := aOS.getIdFuncionario;
    FQuery.ParamByName('id_veiculo').AsInteger := aOS.getIdVeiculo;
    FQuery.ParamByName('id_cliente').AsInteger := aOS.getIdCliente;
    FQuery.ParamByName('preco').AsCurrency := aOS.getPreco;
    FQuery.ParamByName('ativo').AsBoolean := aOS.getAtivo;
    FQuery.ParamByName('id').AsInteger := aOS.getIdOrdemServico;
    FQuery.ExecSQL;

    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('DELETE FROM ordem_servico_pecas WHERE id_ordem_servico = :id');
    FQuery.ParamByName('id').AsInteger := aOS.getIdOrdemServico;
    FQuery.ExecSQL;

    if Assigned(aPecasIDs) then
    begin
      for PecaID in aPecasIDs do
      begin
        FQuery.Close;
        FQuery.SQL.Clear;
        FQuery.SQL.Add('INSERT INTO ordem_servico_pecas (id_ordem_servico, id_peca)');
        FQuery.SQL.Add('VALUES (:id_ordem_servico, :id_peca)');
        FQuery.ParamByName('id_ordem_servico').AsInteger := aOS.getIdOrdemServico;
        FQuery.ParamByName('id_peca').AsInteger := PecaID;
        FQuery.ExecSQL;
      end;
    end;

    FQuery.Connection.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise Exception.Create('Erro ao editar ordem de serviço: ' + E.Message);
    end;
  end;
end;

function TOrdemServicoRepository.ListarOrdensServico: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT os.id, s.nome AS "Serviço", f.nome AS "Funcionário",');
    FQuery.SQL.Add('v.modelo AS "Veículo", c.nome AS "Cliente", os.preco AS "Preço", os.ativo');
    FQuery.SQL.Add('FROM ordens_servico os');
    FQuery.SQL.Add('INNER JOIN servicos s ON os.id_servico = s.id');
    FQuery.SQL.Add('INNER JOIN funcionarios f ON os.id_funcionario = f.id');
    FQuery.SQL.Add('INNER JOIN veiculos v ON os.id_veiculo = v.id');
    FQuery.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    FQuery.SQL.Add('WHERE os.ativo = TRUE');
    FQuery.SQL.Add('ORDER BY os.id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Ordens de Serviço: ' + E.Message);
  end;
end;

function TOrdemServicoRepository.ListarOrdensServicoRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT * FROM ordens_servico WHERE ativo = FALSE');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar Ordens de Serviço para restauração: ' + E.Message);
  end;
end;

procedure TOrdemServicoRepository.DeletarOrdemServico(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE ordens_servico SET ativo = FALSE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

procedure TOrdemServicoRepository.RestaurarOrdemServico(const aID: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('UPDATE ordens_servico SET ativo = TRUE WHERE id = :id');
  FQuery.ParamByName('id').AsInteger := aID;
  FQuery.ExecSQL;
end;

function TOrdemServicoRepository.PesquisarOrdensServico(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT os.*, s.nome AS servico_nome, f.nome AS funcionario_nome,');
    FQuery.SQL.Add('v.modelo AS veiculo_placa, c.nome AS cliente_nome');
    FQuery.SQL.Add('FROM ordens_servico os');
    FQuery.SQL.Add('INNER JOIN servicos s ON os.id_servico = s.id');
    FQuery.SQL.Add('INNER JOIN funcionarios f ON os.id_funcionario = f.id');
    FQuery.SQL.Add('INNER JOIN veiculos v ON os.id_veiculo = v.id');
    FQuery.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    FQuery.SQL.Add('WHERE (s.nome ILIKE :filtro OR c.nome ILIKE :filtro OR v.modelo ILIKE :filtro)');
    FQuery.SQL.Add('AND os.ativo = TRUE ORDER BY os.id');
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar Ordem de Serviço: ' + E.Message);
  end;
end;

function TOrdemServicoRepository.CarregarServicos: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM servicos WHERE ativo = TRUE ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.CarregarFuncionarios: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM funcionarios WHERE ativo = TRUE AND tipo = ''Mecânico'' ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.CarregarVeiculos: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT id, modelo FROM veiculos WHERE ativo = TRUE ORDER BY modelo');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('modelo').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.CarregarClientes: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM clientes WHERE ativo = TRUE ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.CarregarPecas: TStringList;
var
  Lista: TStringList;
  Qry: TFDQuery;
begin
  Lista := TStringList.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id, nome FROM pecas WHERE ativo = TRUE ORDER BY nome');
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.AddObject(Qry.FieldByName('nome').AsString, TObject(Qry.FieldByName('id').AsInteger));
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.CarregarPecasDaOS(const aIDOS: Integer): TList<Integer>;
var
  Lista: TList<Integer>;
  Qry: TFDQuery;
begin
  Lista := TList<Integer>.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id_peca FROM ordem_servico_pecas WHERE id_ordem_servico = :id');
    Qry.ParamByName('id').AsInteger := aIDOS;
    Qry.Open;
    while not Qry.Eof do
    begin
      Lista.Add(Qry.FieldByName('id_peca').AsInteger);
      Qry.Next;
    end;
    Result := Lista;
  finally
    Qry.Free;
  end;
end;


function TOrdemServicoRepository.ObterPrecoServico(const aIDServico: Integer): Currency;
var
  Qry: TFDQuery;
begin
  Result := 0;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COALESCE(preco, 0) as preco FROM servicos WHERE id = :id AND ativo = TRUE');
    Qry.ParamByName('id').AsInteger := aIDServico;
    Qry.Open;

    if not Qry.IsEmpty then
      Result := Qry.FieldByName('preco').AsCurrency;
  finally
    Qry.Free;
  end;
end;
function TOrdemServicoRepository.ObterPrecoPecas(const aIDsPecasString: string): Currency;
var
  Qry: TFDQuery;
begin
  Result := 0;

  if Trim(aIDsPecasString) = '' then
    Exit;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COALESCE(SUM(preco_compra), 0) as total FROM pecas');
    Qry.SQL.Add('WHERE id IN (' + aIDsPecasString + ') AND ativo = TRUE');
    Qry.Open;

    if not Qry.IsEmpty then
      Result := Qry.FieldByName('total').AsCurrency;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.ObterClienteDoVeiculo(const aIDVeiculo: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Result := 0;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Add('SELECT id_cliente FROM veiculos');
    Qry.SQL.Add('WHERE id = :id_veiculo AND ativo = TRUE');
    Qry.ParamByName('id_veiculo').AsInteger := aIDVeiculo;
    Qry.Open;

    if not Qry.IsEmpty then
      Result := Qry.FieldByName('id_cliente').AsInteger;
  finally
    Qry.Free;
  end;
end;

function TOrdemServicoRepository.ObterPorcentagemMarcaVeiculo(const aIDVeiculo: Integer): Currency;
var
  Qry: TFDQuery;
begin
  Result := 0;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FQuery.Connection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COALESCE(porcentagem_acrescimo, 0) as porcentagem_acrescimo FROM veiculos');
    Qry.SQL.Add('WHERE id = :id AND ativo = TRUE');
    Qry.ParamByName('id').AsInteger := aIDVeiculo;
    Qry.Open;

    if not Qry.IsEmpty then
      Result := Qry.FieldByName('porcentagem_acrescimo').AsCurrency;
  finally
    Qry.Free;
  end;
end;

end.
