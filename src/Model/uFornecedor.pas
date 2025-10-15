unit uFornecedor;

interface

type
  TFornecedor = class
  private
    IdFornecedor : Integer;
    Nome: String;
    RazaoSocial: String;
    CNPJ: String;
    Telefone: String;
    CEP: String;
    Rua: String;
    Numero: String;
    Bairro: String;
    Cidade: String;
    Estado: String;
    Ativo: Boolean;
  public
    // Getters e Setters
    function getIdFornecedor : Integer;
    procedure setIdFornecedor(aId: Integer);

    function getNome : String;
    procedure setNome(aNome: String);

    function getRazaoSocial : String;
    procedure setRazaoSocial(aRazaoSocial: String);

    function getCNPJ : String;
    procedure setCNPJ(aCNPJ: String);

    function getTelefone : String;
    procedure setTelefone(aTelefone: String);

    function getCEP : String;
    procedure setCEP(aCEP: String);

    function getRua : String;
    procedure setRua(aRua: String);

    function getNumero : String;
    procedure setNumero(aNumero: String);

    function getBairro : String;
    procedure setBairro(aBairro: String);

    function getCidade : String;
    procedure setCidade(aCidade: String);

    function getEstado : String;
    procedure setEstado(aEstado: String);

    function getAtivo : Boolean;
    procedure setAtivo(aAtivo: Boolean);
  end;

implementation

{ TFornecedor }

function TFornecedor.getIdFornecedor: Integer;
begin
  Result := IdFornecedor;
end;

procedure TFornecedor.setIdFornecedor(aId: Integer);
begin
  IdFornecedor := aId;
end;

function TFornecedor.getNome: String;
begin
  Result := Nome;
end;

procedure TFornecedor.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TFornecedor.getRazaoSocial: String;
begin
  Result := RazaoSocial;
end;

procedure TFornecedor.setRazaoSocial(aRazaoSocial: String);
begin
  RazaoSocial := aRazaoSocial;
end;

function TFornecedor.getCNPJ: String;
begin
  Result := CNPJ;
end;

procedure TFornecedor.setCNPJ(aCNPJ: String);
begin
  CNPJ := aCNPJ;
end;

function TFornecedor.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TFornecedor.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TFornecedor.getCEP: String;
begin
  Result := CEP;
end;

procedure TFornecedor.setCEP(aCEP: String);
begin
  CEP := aCEP;
end;

function TFornecedor.getRua: String;
begin
  Result := Rua;
end;

procedure TFornecedor.setRua(aRua: String);
begin
  Rua := aRua;
end;

function TFornecedor.getNumero: String;
begin
  Result := Numero;
end;

procedure TFornecedor.setNumero(aNumero: String);
begin
  Numero := aNumero;
end;

function TFornecedor.getBairro: String;
begin
  Result := Bairro;
end;

procedure TFornecedor.setBairro(aBairro: String);
begin
  Bairro := aBairro;
end;

function TFornecedor.getCidade: String;
begin
  Result := Cidade;
end;

procedure TFornecedor.setCidade(aCidade: String);
begin
  Cidade := aCidade;
end;

function TFornecedor.getEstado: String;
begin
  Result := Estado;
end;

procedure TFornecedor.setEstado(aEstado: String);
begin
  Estado := aEstado;
end;

function TFornecedor.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TFornecedor.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
