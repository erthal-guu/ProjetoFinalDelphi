unit uUsuarioDTO;

interface

type
  TUsuarioDTO = class
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

function TUsuarioDTO.getGrupo: String;
begin
  Result := Self.Grupo;
end;
function TUsuarioDTO.getID: Integer;
begin
  Result := Self.ID;
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

function TUsuarioDTO.getAtivo: Boolean;
begin
  Result := Self.Ativo;
end;

procedure TUsuarioDTO.setNome(aNome: String);
begin
  Nome := aNome;
end;
procedure TUsuarioDTO.setID(aId: Integer);
begin
  Id := aId;
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

procedure TUsuarioDTO.setAtivo(aAtivo: Boolean);
begin
  Ativo := aAtivo;
end;

end.

