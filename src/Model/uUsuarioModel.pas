unit uUsuarioModel;

interface

type TUsuario = class
  private
    Nome : String;
    CPF : String;
    Senha : String;
  public
    function getNome :String;
    procedure setNome(aNome:String);
    function getCPF :String;
    procedure setCPF(aCPF:String);
    function getSenha :String;
    procedure setSenha(aSenha:String);
    constructor create(aNome,aCPF,aSenha:String);
end;



implementation

{ TUsuario }

constructor TUsuario.create(aNome, aCPF, aSenha: String);
begin
  Nome := aNome;
  CPF := aCPF;
  Senha := aSenha;
end;

function TUsuario.getCPF: String;
begin
  Result := Self.CPF;
end;

function TUsuario.getNome: String;
begin
  Result := Self.Nome;
end;

function TUsuario.getSenha: String;
begin
  Result := Self.Senha
end;

procedure TUsuario.setCPF(aCPF: String);
begin
  Self.CPF := aCPF;
end;

procedure TUsuario.setNome(aNome: String);
begin
  Self.Nome := aNome;
end;
procedure TUsuario.setSenha(aSenha: String);
begin
  Self.Senha := aSenha;
end;

end.
