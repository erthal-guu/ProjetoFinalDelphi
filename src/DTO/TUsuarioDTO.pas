unit uUsuarioDTO;

interface

type
  TUsuarioDTO = class
  private
    Nome: String;
    CPF: String;
    Senha: String;
  public
    function getNome: String;
    function getCPF: String;
    function getSenha: String;
    procedure setNome(aNome: String);
    procedure setCPF(aCPF: String);
    procedure setSenha(aSenha: String);
  end;

implementation

{ TUsuarioDTO }

function TUsuarioDTO.getNome: String;
begin
  Result := Self.Nome;
end;

function TUsuarioDTO.getCPF: String;
begin
  Result := Self.CPF;
end;

function TUsuarioDTO.getSenha: String;
begin
  Result := Self.Senha;
end;

procedure TUsuarioDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

procedure TUsuarioDTO.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

procedure TUsuarioDTO.setSenha(aSenha: String);
begin
  Senha := aSenha;
end;

end.

