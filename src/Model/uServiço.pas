unit uServiço;

interface

type
  TServico = class
  private
    Id: Integer;
    Nome: String;
    Categoria: Integer;
    Preco: Currency;
    Observacao: String;
    Profissional: Integer;
  public
    function GetId: Integer;
    procedure SetId(const Value: Integer);

    function GetNome: String;
    procedure SetNome(const Value: String);

    function GetCategoria: Integer;
    procedure SetCategoria(const Value: Integer);

    function GetPreco: Currency;
    procedure SetPreco(const Value: Currency);

    function GetObservacao: String;
    procedure SetObservacao(const Value: String);

    function GetProfissional: Integer;
    procedure SetProfissional(const Value: Integer);
  end;

implementation

function TServico.GetId: Integer;
begin
  Result := Id;
end;

procedure TServico.SetId(const Value: Integer);
begin
  Id := Value;
end;

function TServico.GetNome: String;
begin
  Result := Nome;
end;

procedure TServico.SetNome(const Value: String);
begin
  Nome := Value;
end;

function TServico.GetCategoria: Integer;
begin
  Result := Categoria;
end;

procedure TServico.SetCategoria(const Value: Integer);
begin
  Categoria := Value;
end;

function TServico.GetPreco: Currency;
begin
  Result := Preco;
end;

procedure TServico.SetPreco(const Value: Currency);
begin
  Preco := Value;
end;

function TServico.GetObservacao: String;
begin
  Result := Observacao;
end;

procedure TServico.SetObservacao(const Value: String);
begin
  Observacao := Value;
end;

function TServico.GetProfissional: Integer;
begin
  Result := Profissional;
end;

procedure TServico.SetProfissional(const Value: Integer);
begin
  Profissional := Value;
end;

end.
