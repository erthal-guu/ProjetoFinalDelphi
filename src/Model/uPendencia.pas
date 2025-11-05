unit uPendencia;

interface

type
  TPendencia = class
  private
    Id: Integer;
    IdCliente: Integer;
    Descricao: String;
    ValorTotal: Currency;
    DataVencimento: TDateTime;
    DataCriacao: TDateTime;
        Status: String;
    Observacao: String;
    Ativo: Boolean;
  public
    // Getters e Setters
    function getId: Integer;
    procedure setId(aId: Integer);

    function getIdCliente: Integer;
    procedure setIdCliente(aIdCliente: Integer);

    function getDescricao: String;
    procedure setDescricao(aDescricao: String);

    function getValorTotal: Currency;
    procedure setValorTotal(aValorTotal: Currency);

    function getDataVencimento: TDateTime;
    procedure setDataVencimento(aDataVencimento: TDateTime);

    function getDataCriacao: TDateTime;
    procedure setDataCriacao(aDataCriacao: TDateTime);

    
    function getStatus: String;
    procedure setStatus(aStatus: String);

    function getObservacao: String;
    procedure setObservacao(aObservacao: String);

    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);
  end;

implementation

{ TPendencia }

function TPendencia.getId: Integer;
begin
  Result := Id;
end;

procedure TPendencia.setId(aId: Integer);
begin
  Id := aId;
end;

function TPendencia.getIdCliente: Integer;
begin
  Result := IdCliente;
end;

procedure TPendencia.setIdCliente(aIdCliente: Integer);
begin
  IdCliente := aIdCliente;
end;

function TPendencia.getDescricao: String;
begin
  Result := Descricao;
end;

procedure TPendencia.setDescricao(aDescricao: String);
begin
  Descricao := aDescricao;
end;

function TPendencia.getValorTotal: Currency;
begin
  Result := ValorTotal;
end;

procedure TPendencia.setValorTotal(aValorTotal: Currency);
begin
  ValorTotal := aValorTotal;
end;

function TPendencia.getDataVencimento: TDateTime;
begin
  Result := DataVencimento;
end;

procedure TPendencia.setDataVencimento(aDataVencimento: TDateTime);
begin
  DataVencimento := aDataVencimento;
end;

function TPendencia.getDataCriacao: TDateTime;
begin
  Result := DataCriacao;
end;

procedure TPendencia.setDataCriacao(aDataCriacao: TDateTime);
begin
  DataCriacao := aDataCriacao;
end;

function TPendencia.getStatus: String;
begin
  Result := Status;
end;

procedure TPendencia.setStatus(aStatus: String);
begin
  Status := aStatus;
end;

function TPendencia.getObservacao: String;
begin
  Result := Observacao;
end;

procedure TPendencia.setObservacao(aObservacao: String);
begin
  Observacao := aObservacao;
end;

function TPendencia.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TPendencia.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
