unit uFornecedorDTO;

interface

type
  TFornecedorDTO = class
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

{ TFornecedorDTO }

function TFornecedorDTO.getIdFornecedor: Integer;
begin
  Result := IdFornecedor;
end;

procedure TFornecedorDTO.setIdFornecedor(aId: Integer);
begin
  IdFornecedor := aId;
end;

function TFornecedorDTO.getNome: String;
begin
  Result := Nome;
end;

procedure TFornecedorDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TFornecedorDTO.getRazaoSocial: String;
begin
  Result := RazaoSocial;
end;

procedure TFornecedorDTO.setRazaoSocial(aRazaoSocial: String);
begin
  RazaoSocial := aRazaoSocial;
end;

function TFornecedorDTO.getCNPJ: String;
begin
  Result := CNPJ;
end;

procedure TFornecedorDTO.setCNPJ(aCNPJ: String);
begin
  CNPJ := aCNPJ;
end;

function TFornecedorDTO.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TFornecedorDTO.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TFornecedorDTO.getCEP: String;
begin
  Result := CEP;
end;

procedure TFornecedorDTO.setCEP(aCEP: String);
begin
  CEP := aCEP;
end;

function TFornecedorDTO.getRua: String;
begin
  Result := Rua;
end;

procedure TFornecedorDTO.setRua(aRua: String);
begin
  Rua := aRua;
end;

function TFornecedorDTO.getNumero: String;
begin
  Result := Numero;
end;

procedure TFornecedorDTO.setNumero(aNumero: String);
begin
  Numero := aNumero;
end;

function TFornecedorDTO.getBairro: String;
begin
  Result := Bairro;
end;

procedure TFornecedorDTO.setBairro(aBairro: String);
begin
  Bairro := aBairro;
end;

function TFornecedorDTO.getCidade: String;
begin
  Result := Cidade;
end;

procedure TFornecedorDTO.setCidade(aCidade: String);
begin
  Cidade := aCidade;
end;

function TFornecedorDTO.getEstado: String;
begin
  Result := Estado;
end;

procedure TFornecedorDTO.setEstado(aEstado: String);
begin
  Estado := aEstado;
end;

function TFornecedorDTO.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TFornecedorDTO.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
