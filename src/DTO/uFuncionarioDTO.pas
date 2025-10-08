unit uFuncionarioDTO;

interface

type
  TFuncionarioDTO = class
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

    function getAtivo : Boolean;
    procedure setAtivo(aAtivo: Boolean);
  end;

implementation

{ TFuncionarioDTO }

function TFuncionarioDTO.getIdFuncionario: Integer;
begin
  Result := IdFuncionario;
end;

procedure TFuncionarioDTO.setIdFuncionario(aId: Integer);
begin
  IdFuncionario := aId;
end;

function TFuncionarioDTO.getNome: String;
begin
  Result := Nome;
end;

procedure TFuncionarioDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TFuncionarioDTO.getCPF: String;
begin
  Result := CPF;
end;

procedure TFuncionarioDTO.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

function TFuncionarioDTO.getRG: String;
begin
  Result := RG;
end;

procedure TFuncionarioDTO.setRG(aRG: String);
begin
  RG := aRG;
end;

function TFuncionarioDTO.getNascimento: String;
begin
  Result := Nascimento;
end;

procedure TFuncionarioDTO.setNascimento(aNascimento: String);
begin
  Nascimento := aNascimento;
end;

function TFuncionarioDTO.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TFuncionarioDTO.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TFuncionarioDTO.getCEP: String;
begin
  Result := CEP;
end;

procedure TFuncionarioDTO.setCEP(aCEP: String);
begin
  CEP := aCEP;
end;

function TFuncionarioDTO.getRua: String;
begin
  Result := Rua;
end;

procedure TFuncionarioDTO.setRua(aRua: String);
begin
  Rua := aRua;
end;

function TFuncionarioDTO.getNumero: String;
begin
  Result := Numero;
end;

procedure TFuncionarioDTO.setNumero(aNumero: String);
begin
  Numero := aNumero;
end;

function TFuncionarioDTO.getBairro: String;
begin
  Result := Bairro;
end;

procedure TFuncionarioDTO.setBairro(aBairro: String);
begin
  Bairro := aBairro;
end;

function TFuncionarioDTO.getCidade: String;
begin
  Result := Cidade;
end;

procedure TFuncionarioDTO.setCidade(aCidade: String);
begin
  Cidade := aCidade;
end;

function TFuncionarioDTO.getEstado: String;
begin
  Result := Estado;
end;

procedure TFuncionarioDTO.setEstado(aEstado: String);
begin
  Estado := aEstado;
end;

function TFuncionarioDTO.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TFuncionarioDTO.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.
