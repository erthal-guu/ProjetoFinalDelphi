unit uUsuario;

interface

type
  TUsuario = class
  private
    id : Integer;
    Nome: String;
    CPF: String;
    Senha: String;
    grupo : String;
    Ativo : Boolean;
  public
    Function getID : Integer;
    function getNome: String;
    function getCPF: String;
    function getSenha: String;
    function getGrupo: String;
    function getAtivo : Boolean;
    procedure setNome(aNome: String);
    procedure setCPF(aCPF: String);
    procedure setSenha(aSenha: String);
    procedure setGrupo(aGrupo : String);
    procedure setAtivo(aAtivo : Boolean);
    procedure setId(aId : Integer);
  end;

implementation

{ TUsuarioDTO }

function TUsuario.getGrupo: String;
begin
  Result := Self.Grupo;
end;
function TUsuario.getID: Integer;
begin
  Result := Self.ID;
end;

function TUsuario.getNome: String;
begin
  Result := Self.Nome;
end;

function TUsuario.getCPF: String;
begin
  Result := Self.CPF;
end;

function TUsuario.getSenha: String;
begin
  Result := Self.Senha;
end;

function TUsuario.getAtivo: Boolean;
begin
  Result := Self.Ativo;
end;

procedure TUsuario.setNome(aNome: String);
begin
  Nome := aNome;
end;
procedure TUsuario.setID(aId: Integer);
begin
  Id := aId;
end;

procedure TUsuario.setCPF(aCPF: String);
begin
  CPF := aCPF;
end;

procedure TUsuario.setGrupo(aGrupo: String);
begin
  Grupo := aGrupo
end;

procedure TUsuario.setSenha(aSenha: String);
begin
  Senha := aSenha;
end;

procedure TUsuario.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.

