unit uClienteDTO;

interface

type
  TClienteDTO = class
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

function TClienteDTO.getIdCliente: Integer;
begin
  Result := IdCliente;
end;

procedure TClienteDTO.setIdCliente(aId: Integer);
begin
  IdCliente := aId;
end;

function TClienteDTO.getNome: String;
begin
  Result := Nome;
end;

procedure TClienteDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

function TClienteDTO.getEmail: String;
begin
  Result := Email;
end;

procedure TClienteDTO.setEmail(aEmail: String);
begin
  Email := aEmail;
end;

function TClienteDTO.getCPF: String;
begin
  Result := CPF;
end;

procedure TClienteDTO.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

function TClienteDTO.getTelefone: String;
begin
  Result := Telefone;
end;

procedure TClienteDTO.setTelefone(aTelefone: String);
begin
  Telefone := aTelefone;
end;

function TClienteDTO.getNascimento: String;
begin
  Result := Nascimento;
end;

procedure TClienteDTO.setNascimento(aNascimento: String);
begin
  Nascimento := aNascimento;
end;

function TClienteDTO.getEndereco: String;
begin
  Result := Endereco;
end;

procedure TClienteDTO.setEndereco(aEndereco: String);
begin
  Endereco := aEndereco;
end;

function TClienteDTO.getAtivo: Boolean;
begin
  Result := Ativo;
end;

procedure TClienteDTO.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.

