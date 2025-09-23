unit UsuarioCadastroController;

interface
uses uUsuarioDTO, CadastroUsuarioService, FireDAC.Comp.Client, Vcl.Dialogs;

type TUsuarioController = class
  Service : TUsuarioService;
    constructor Create;
      function SalvarUsuario(UsuarioDTO: TUsuarioDTO): Boolean;
      procedure EditarUsuario(UsuarioDTO: TUsuarioDTO);
      function ListarUsuarios: TFDQuery;
      function CriarObjeto(aNome, aCPF, aSenha: String): TUsuarioDTO;
      function CriarObjetoCRUD(aNome, aCPF, aSenha, aGrupo, aStatus: String): TUsuarioDTO;
      procedure SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO);
  end;
implementation
{ TUsuarioController }

constructor TUsuarioController.Create;
begin
  Self.Service := TUsuarioService.create;
end;

function TUsuarioController.CriarObjeto;
begin
  Result := TUsuarioDTO.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setSenha(aSenha);;
end;

function TUsuarioController.CriarObjetoCRUD(aNome, aCPF, aSenha,
  aGrupo,aStatus: String): TUsuarioDTO;
begin
  Result := TUsuarioDTO.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setSenha(aSenha);
  Result.setGrupo(aGrupo);
  Result.setStatus(aStatus);
end;

procedure TUsuarioController.EditarUsuario(UsuarioDTO: TUsuarioDTO);
begin
  Service.EditarUsuario(UsuarioDTO);
end;

function TUsuarioController.ListarUsuarios: TFDQuery;
begin
  Result := Service.ListarUsuarios;
end;

function TUsuarioController.SalvarUsuario(UsuarioDTO: TUsuarioDTO):Boolean;
begin
  Result := Service.SalvarUsuario(UsuarioDTO);
end;

procedure TUsuarioController.SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO);
begin
  Service.SalvarUsuarioCRUD(UsuarioDTO);
end;

end.
