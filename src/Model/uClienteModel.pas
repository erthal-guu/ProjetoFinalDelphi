unit uClienteModel;

interface

type
  TCliente = class
  private
    Nome : String;
    Email : String;
    CPF : String;
    Telefone : String;
    Nascimento : TDate;
    Endereco : String;
  public
    // Getters e Setters
    function getNome : String;
    procedure setNome(aNome: String);

    function getEmail : String;
    procedure setEmail(aEmail: String);

    function getCPF : String;
    procedure setCPF(aCPF: String);

    function getTelefone : String;
    procedure setTelefone(aTelefone: String);

    function getNascimento : TDate;
    procedure setNascimento(aNascimento: TDate);

    function getEndereco : String;
    procedure setEndereco(aEndereco: String);


    // Construtor
    constructor Create(aId: Integer; aNome, aEmail, aCPF, aTelefone, aEndereco: String; aNascimento: TDate; aAtivo: Boolean);
  end;

implementation

{ TCliente }

constructor TCliente.Create(aId: Integer; aNome, aEmail, aCPF, aTelefone, aEndereco: String; aNascimento: TDate; aAtivo: Boolean);
begin
  Nome       := aNome;
  Email      := aEmail;
  CPF        := aCPF;
  Telefone   := aTelefone;
  Endereco   := aEndereco;
  Nascimento := aNascimento;
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

function TCliente.getNascimento: TDate;
begin
  Result := Nascimento;
end;

procedure TCliente.setNascimento(aNascimento: TDate);
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

end.

