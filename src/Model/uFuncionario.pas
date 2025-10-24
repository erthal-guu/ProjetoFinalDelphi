unit uFuncionario;

interface

type
  TFuncionario = class
  private
    IdFuncionario : Integer;
    Nome: String;
    CPF: String;
    RG: String;
    Nascimento: String;
    Telefone: String;
    CEP: String;
    Rua: String;
    Numero: String;
    Bairro: String;
    Cidade: String;
    Estado: String;
    Tipo: String;
    Ativo: Boolean;
  public
    // Getters e Setters
    function getIdFuncionario : Integer;
    procedure setIdFuncionario(aId: Integer);

    function getNome : String;
    procedure setNome(aNome: String);

    function getCPF : String;
    procedure setCPF(aCPF: String);

    function getRG : String;
    procedure setRG(aRG: String);

    function getNascimento : String;
    procedure setNascimento(aNascimento: String);

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

    function getTipo : String;
    procedure setTipo(aTipo: String);

    function getAtivo : Boolean;
    procedure setAtivo(aAtivo: Boolean);
  end;

implementation

{ TFuncionarioDTO }

function TFuncionario.getIdFuncionario: Integer;
begin
  Result := IdFuncionario;
end;

procedure TFuncionario.setIdFuncionario(aId: Integer);
begin
  IdFuncionario := aId;
end;

function TFuncionario.getNome: String;
begin
  Result := Nome;
end;

function TFuncionario.getTipo: String;
begin
  Result := Tipo;
end;

procedure TFuncionario.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TFuncionario.getCPF: String;
begin
  Result := CPF;
end;

procedure TFuncionario.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

function TFuncionario.getRG: String;
begin
  Result := RG;
end;

procedure TFuncionario.setRG(aRG: String);
begin
  RG := aRG;
end;

function TFuncionario.getNascimento: String;
begin
  Result := Nascimento;
end;

procedure TFuncionario.setNascimento(aNascimento: String);
begin
  Nascimento := aNascimento;
end;

procedure TFuncionario.setTipo(aTipo: String);
begin
  Tipo := aTipo;
end;

function TFuncionario.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TFuncionario.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TFuncionario.getCEP: String;
begin
  Result := CEP;
end;

procedure TFuncionario.setCEP(aCEP: String);
begin
  CEP := aCEP;
end;

function TFuncionario.getRua: String;
begin
  Result := Rua;
end;

procedure TFuncionario.setRua(aRua: String);
begin
  Rua := aRua;
end;

function TFuncionario.getNumero: String;
begin
  Result := Numero;
end;

procedure TFuncionario.setNumero(aNumero: String);
begin
  Numero := aNumero;
end;

function TFuncionario.getBairro: String;
begin
  Result := Bairro;
end;

procedure TFuncionario.setBairro(aBairro: String);
begin
  Bairro := aBairro;
end;

function TFuncionario.getCidade: String;
begin
  Result := Cidade;
end;

procedure TFuncionario.setCidade(aCidade: String);
begin
  Cidade := aCidade;
end;

function TFuncionario.getEstado: String;
begin
  Result := Estado;
end;

procedure TFuncionario.setEstado(aEstado: String);
begin
  Estado := aEstado;
end;

function TFuncionario.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TFuncionario.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
