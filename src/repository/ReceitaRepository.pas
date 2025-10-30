﻿unit ReceitaRepository;

interface

uses
  uDMConexao, FireDAC.Comp.Client, System.SysUtils, uReceita, Data.DB, Generics.Collections, System.Classes;

type
  TReceitaRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Query: TFDQuery);
    procedure ReceberReceita(aReceita: TReceita);
    function ListarReceitas: TDataSet;
    function ListarReceitasRestaurar: TDataSet;
    function ListarHistoricoReceitas: TDataSet;
    procedure DeletarReceita(const aID: Integer);
    procedure RestaurarReceita(const aID: Integer);
    function PesquisarReceitas(const aFiltro: String): TDataSet;
    function CarregarOrdensServico: TDataSet;
  end;

implementation

constructor TReceitaRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;


procedure TReceitaRepository.ReceberReceita(aReceita: TReceita);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE receitas');
    FQuery.SQL.Add('SET valor_recebido = :valor_recebido, data_recebimento = :data_recebimento');
    FQuery.SQL.Add('WHERE id = :id');
    FQuery.ParamByName('valor_recebido').AsCurrency := aReceita.getValorRecebido;
    FQuery.ParamByName('data_recebimento').AsDateTime := aReceita.getDataRecebimento;
    FQuery.ParamByName('id').AsInteger := aReceita.getIdReceita;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao receber receita: ' + E.Message);
  end;
end;


function TReceitaRepository.ListarReceitas: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT ');
    FQuery.SQL.Add('  r.id,');
    FQuery.SQL.Add('  r.id_ordem_servico,');
    FQuery.SQL.Add('  c.nome AS cliente_nome,');
    FQuery.SQL.Add('  r.valor_total,');
    FQuery.SQL.Add('  r.valor_recebido,');
    FQuery.SQL.Add('  r.status,');
    FQuery.SQL.Add('  r.data_emissao,');
    FQuery.SQL.Add('  r.data_vencimento,');
    FQuery.SQL.Add('  r.data_recebimento,');
    FQuery.SQL.Add('  r.forma_pagamento,');
    FQuery.SQL.Add('  r.observacao,');
    FQuery.SQL.Add('  r.ativo');
    FQuery.SQL.Add('FROM receitas r');
    FQuery.SQL.Add('INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id');
    FQuery.SQL.Add('INNER JOIN clientes c ON os.id_cliente = c.id');
    FQuery.SQL.Add('WHERE r.ativo = TRUE');
    FQuery.SQL.Add('ORDER BY r.id DESC');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar receitas: ' + E.Message);
  end;
end;

function TReceitaRepository.ListarReceitasRestaurar: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, valor_recebido, data_recebimento, valor_total,');
    FQuery.SQL.Add('       data_emissao, data_vencimento, forma_pagamento, observacao, status, ativo');
    FQuery.SQL.Add('FROM receitas');
    FQuery.SQL.Add('WHERE ativo = FALSE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar receitas para restauração: ' + E.Message);
  end;
end;

function TReceitaRepository.ListarHistoricoReceitas: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, valor_recebido, data_recebimento, valor_total,');
    FQuery.SQL.Add('       data_emissao, data_vencimento, forma_pagamento, observacao, status, ativo');
    FQuery.SQL.Add('FROM receitas');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar histórico de receitas: ' + E.Message);
  end;
end;

procedure TReceitaRepository.DeletarReceita(const aID: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE receitas SET ativo = FALSE WHERE id = :id');
    FQuery.ParamByName('id').AsInteger := aID;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao deletar receita: ' + E.Message);
  end;
end;

procedure TReceitaRepository.RestaurarReceita(const aID: Integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('UPDATE receitas SET ativo = TRUE WHERE id = :id');
    FQuery.ParamByName('id').AsInteger := aID;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao restaurar receita: ' + E.Message);
  end;
end;

function TReceitaRepository.PesquisarReceitas(const aFiltro: String): TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, valor_recebido, data_recebimento, valor_total,');
    FQuery.SQL.Add('       data_emissao, data_vencimento, forma_pagamento, observacao, status, ativo');
    FQuery.SQL.Add('FROM receitas');
    FQuery.SQL.Add('WHERE (CAST(valor_recebido AS VARCHAR) ILIKE :filtro OR');
    FQuery.SQL.Add('       CAST(valor_total AS VARCHAR) ILIKE :filtro OR');
    FQuery.SQL.Add('       forma_pagamento ILIKE :filtro OR');
    FQuery.SQL.Add('       observacao ILIKE :filtro OR');
    FQuery.SQL.Add('       status ILIKE :filtro)');
    FQuery.SQL.Add('  AND ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.ParamByName('filtro').AsString := '%' + Trim(aFiltro) + '%';
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao pesquisar receitas: ' + E.Message);
  end;
end;

function TReceitaRepository.CarregarOrdensServico: TDataSet;
begin
  try
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT id, preco, data_abertura FROM ordens_servico WHERE ativo = TRUE');
    FQuery.SQL.Add('ORDER BY id');
    FQuery.Open;
    Result := FQuery;
  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar ordens de serviço: ' + E.Message);
  end;
end;

end.
