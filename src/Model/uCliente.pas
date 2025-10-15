unit uCliente;

interface

type
  TCliente = class
  private
    IdCliente : Integer;
    Nome : String;
    Email : String;
    CPF : String;
    Telefone : String;
    Nascimento : String;
    Endereco : String;
    Ativo : Boolean;
  public
    // Getters e Setters
    function getIdCliente : Integer;
    procedure setIdCliente(aId: Integer);

    function getNome : String;
    procedure setNome(aNome: String);

    function getEmail : String;
    procedure setEmail(aEmail: String);

    function getCPF : String;
    procedure setCPF(aCPF: String);

    function getTelefone : String;
    procedure setTelefone(aTelefone: String);

    function getNascimento : String;
    procedure setNascimento(aNascimento: String);

    function getEndereco : String;
    procedure setEndereco(aEndereco: String);

    function getAtivo : Boolean;
    procedure setAtivo(aAtivo: Boolean);
    end;

implementation

{ TCliente }

function TCliente.getIdCliente: Integer;
begin
  Result := IdCliente;
end;

procedure TCliente.setIdCliente(aId: Integer);
begin
  IdCliente := aId;
end;

function TCliente.getNome: String;
begin
  Result := Nome;
end;

procedure TCliente.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TCliente.getEmail: String;
begin
  Result := Email;
end;

procedure TCliente.setEmail(aEmail: String);
begin
  Email := aEmail;
end;

function TCliente.getCPF: String;
begin
  Result := CPF;
end;

procedure TCliente.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

function TCliente.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TCliente.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TCliente.getNascimento: String;
begin
  Result := Nascimento;
end;

procedure TCliente.setNascimento(aNascimento: String);
begin
  Nascimento := aNascimento;
end;

function TCliente.getEndereco: String;
begin
  Result := Endereco;
end;

procedure TCliente.setEndereco(aEndereco: String);
begin
  Endereco := aEndereco;
end;

function TCliente.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TCliente.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.

