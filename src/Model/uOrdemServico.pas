unit uOrdemServico;

interface

type
  TOrdemServico = class
  private
    IdOrdemServico: Integer;
    IdServico: Integer;
    IdFuncionario: Integer;
    IdVeiculo: Integer;
    IdCliente: Integer;
    Preco: Currency;
    Ativo: Boolean;
    Observacao: String;
    DataInicio: TDateTime;
    DataConclusao: TDateTime;
  public
    function getIdOrdemServico: Integer;
    procedure setIdOrdemServico(aId: Integer);
    function getIdServico: Integer;
    procedure setIdServico(aId: Integer);
    function getIdFuncionario: Integer;
    procedure setIdFuncionario(aId: Integer);
    function getIdVeiculo: Integer;
    procedure setIdVeiculo(aId: Integer);
    function getIdCliente: Integer;
    procedure setIdCliente(aId: Integer);
    function getPreco: Currency;
    procedure setPreco(aValor: Currency);
    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);
    function getObservacao: String;
    procedure setObservacao(aObs: String);
    function getDataInicio: TDateTime;
    procedure setDataInicio(aData: TDateTime);
    function getDataConclusao: TDateTime;
    procedure setDataConclusao(aData: TDateTime);
  end;

implementation

function TOrdemServico.getIdOrdemServico: Integer;
begin
  Result := IdOrdemServico;
end;

procedure TOrdemServico.setIdOrdemServico(aId: Integer);
begin
  IdOrdemServico := aId;
end;

function TOrdemServico.getIdServico: Integer;
begin
  Result := IdServico;
end;

procedure TOrdemServico.setIdServico(aId: Integer);
begin
  IdServico := aId;
end;

function TOrdemServico.getIdFuncionario: Integer;
begin
  Result := IdFuncionario;
end;

procedure TOrdemServico.setIdFuncionario(aId: Integer);
begin
  IdFuncionario := aId;
end;

function TOrdemServico.getIdVeiculo: Integer;
begin
  Result := IdVeiculo;
end;

procedure TOrdemServico.setIdVeiculo(aId: Integer);
begin
  IdVeiculo := aId;
end;

function TOrdemServico.getIdCliente: Integer;
begin
  Result := IdCliente;
end;

procedure TOrdemServico.setIdCliente(aId: Integer);
begin
  IdCliente := aId;
end;

function TOrdemServico.getPreco: Currency;
begin
  Result := Preco;
end;

procedure TOrdemServico.setPreco(aValor: Currency);
begin
  Preco := aValor;
end;

function TOrdemServico.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TOrdemServico.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

function TOrdemServico.getObservacao: String;
begin
  Result := Observacao;
end;

procedure TOrdemServico.setObservacao(aObs: String);
begin
  Observacao := aObs;
end;

function TOrdemServico.getDataInicio: TDateTime;
begin
  Result := DataInicio;
end;

procedure TOrdemServico.setDataInicio(aData: TDateTime);
begin
  DataInicio := aData;
end;

function TOrdemServico.getDataConclusao: TDateTime;
begin
  Result := DataConclusao;
end;

procedure TOrdemServico.setDataConclusao(aData: TDateTime);
begin
  DataConclusao := aData;
end;

end.
