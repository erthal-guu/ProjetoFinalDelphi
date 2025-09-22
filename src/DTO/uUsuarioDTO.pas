unit uUsuarioDTO;

interface

type
  TUsuarioDTO = class
  private
    Nome: String;
    CPF: String;
    Senha: String;
    grupo : String;
    status : String;
  public
    function getNome: String;
    function getCPF: String;
    function getSenha: String;
    function getGrupo: String;
    function getStatus : String;
    procedure setNome(aNome: String);
    procedure setCPF(aCPF: String);
    procedure setSenha(aSenha: String);
    procedure setGrupo(aGrupo : String);
    procedure setStatus(aStatus : String);
  end;

implementation

{ TUsuarioDTO }

function TUsuarioDTO.getGrupo: String;
begin
  Result := Self.Grupo;
end;

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

function TUsuarioDTO.getStatus: String;
begin
  Result := Self.status;
end;

procedure TUsuarioDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;

procedure TUsuarioDTO.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

procedure TUsuarioDTO.setGrupo(aGrupo: String);
begin
  Grupo := aGrupo
end;

procedure TUsuarioDTO.setSenha(aSenha: String);
begin
  Senha := aSenha;
end;

procedure TUsuarioDTO.setStatus(aStatus: String);
begin
  Status := aStatus;
end;

end.

