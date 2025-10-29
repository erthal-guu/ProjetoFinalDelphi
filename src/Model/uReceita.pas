unit uReceita;

interface

uses
  System.SysUtils;

type
  TReceita = class
  private
    IdReceita: Integer;
    ValorRecebido: Currency;
    DataRecebimento: TDateTime;
    ValorTotal: Currency;
    FormaPagamento: String;
    Observacao: String;
    Status: String;
    Ativo: Boolean;
  public
    function getIdReceita: Integer;
    procedure setIdReceita(aId: Integer);
    function getValorRecebido: Currency;
    procedure setValorRecebido(aValor: Currency);
    function getDataRecebimento: TDateTime;
    procedure setDataRecebimento(aData: TDateTime);
    function getValorTotal: Currency;
    procedure setValorTotal(aValor: Currency);
    function getFormaPagamento: String;
    procedure setFormaPagamento(aForma: String);
    function getObservacao: String;
    procedure setObservacao(aObs: String);
    function getStatus: String;
    procedure setStatus(aStatus: String);
    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);
  end;

implementation

function TReceita.getIdReceita: Integer;
begin
  Result := IdReceita;
end;

procedure TReceita.setIdReceita(aId: Integer);
begin
  IdReceita := aId;
end;

function TReceita.getValorRecebido: Currency;
begin
  Result := ValorRecebido;
end;

procedure TReceita.setValorRecebido(aValor: Currency);
begin
  ValorRecebido := aValor;
end;

function TReceita.getDataRecebimento: TDateTime;
begin
  Result := DataRecebimento;
end;

procedure TReceita.setDataRecebimento(aData: TDateTime);
begin
  DataRecebimento := aData;
end;

function TReceita.getValorTotal: Currency;
begin
  Result := ValorTotal;
end;

procedure TReceita.setValorTotal(aValor: Currency);
begin
  ValorTotal := aValor;
end;

function TReceita.getFormaPagamento: String;
begin
  Result := FormaPagamento;
end;

procedure TReceita.setFormaPagamento(aForma: String);
begin
  FormaPagamento := aForma;
end;

function TReceita.getObservacao: String;
begin
  Result := Observacao;
end;

procedure TReceita.setObservacao(aObs: String);
begin
  Observacao := aObs;
end;

function TReceita.getStatus: String;
begin
  Result := Status;
end;

procedure TReceita.setStatus(aStatus: String);
begin
  Status := aStatus;
end;

function TReceita.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TReceita.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
