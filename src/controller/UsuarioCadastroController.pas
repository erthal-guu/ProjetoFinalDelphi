unit UsuarioCadastroController;

interface
uses uUsuarioDTO, CadastroUsuarioService, FireDAC.Comp.Client, Vcl.Dialogs,Data.DB;

type TUsuarioController = class
  Service : TUsuarioService;
    constructor Create;
      function SalvarUsuario(UsuarioDTO: TUsuarioDTO): Boolean;
      procedure EditarUsuario(UsuarioDTO: TUsuarioDTO);
      function ListarUsuarios: TDataSet;
      function CriarObjeto(aNome, aCPF, aSenha: String): TUsuarioDTO;
      function CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String ; aAtivo:Boolean): TUsuarioDTO;
      procedure SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO);
      procedure DeletarUsuarios(const aId :Integer);
      procedure RestaurarUsuarios(const aId :Integer);
      Function PesquisarUsuarios(const aFiltro:String):TDataset;
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

function TUsuarioController.CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo: String ; aAtivo:Boolean): TUsuarioDTO;
begin
  Result := TUsuarioDTO.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setSenha(aSenha);
  Result.setGrupo(aGrupo);
  Result.setAtivo(aAtivo);
end;

procedure TUsuarioController.DeletarUsuarios(const aId :Integer);
begin
  Service.DeletarUsuarios(aId);
end;

procedure TUsuarioController.EditarUsuario(UsuarioDTO: TUsuarioDTO);
begin
  Service.EditarUsuario(UsuarioDTO);
end;

function TUsuarioController.ListarUsuarios: TDataSet;
begin
  Result := Service.ListarUsuarios;
end;



function TUsuarioController.PesquisarUsuarios(const aFiltro: String): TDataset;
begin
  Result := Service.PesquisarUsuarios(aFiltro);
end;

function TUsuarioController.SalvarUsuario(UsuarioDTO: TUsuarioDTO):Boolean;
begin
  Result := Service.SalvarUsuario(UsuarioDTO);
end;

procedure TUsuarioController.SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO);
begin
  Service.SalvarUsuarioCRUD(UsuarioDTO);
end;
procedure TUsuarioController.RestaurarUsuarios(const aId :Integer);
begin
  Service.RestaurarUsuarios(aId);
end;

end.
