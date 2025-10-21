unit UsuarioCadastroController;

interface
uses uUsuario, UsuarioCadastroService, FireDAC.Comp.Client, Vcl.Dialogs,Data.DB,System.Classes;

type TUsuarioController = class
  Service : TUsuarioService;
    constructor Create;
      function SalvarUsuario(Usuario: TUsuario): Boolean;
      procedure EditarUsuario(Usuario: TUsuario);
      procedure EditarUsuarioComSenha(Usuario: TUsuario);
      function ListarUsuarios: TDataSet;
      function CriarObjeto(aNome, aCPF, aSenha,aGrupo: String ; aAtivo:Boolean): TUsuario;
      procedure DeletarUsuarios(const aId :Integer);
      procedure RestaurarUsuarios(const aId :Integer);
      Function PesquisarUsuarios(const aFiltro:String):TDataset;
      function CarregarGrupos : TStringList;
  end;
implementation
{ TUsuarioController }

function TUsuarioController.CarregarGrupos: TStringList;
begin
  Result := Service.CarregarGrupos;
end;

constructor TUsuarioController.Create;
begin
  Self.Service := TUsuarioService.create;
end;

function TUsuarioController.CriarObjeto;
begin
  Result := TUsuario.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setSenha(aSenha);
  Result.setGrupo(aGrupo);
  Result.setAtivo(aAtivo)
end;


procedure TUsuarioController.DeletarUsuarios(const aId :Integer);
begin
  Service.DeletarUsuarios(aId);
end;

procedure TUsuarioController.EditarUsuario(Usuario: TUsuario);
begin
  Service.EditarUsuario(Usuario);
end;

procedure TUsuarioController.EditarUsuarioComSenha(Usuario: TUsuario);
begin
  Service.EditarUsuarioComSenha(Usuario);
end;

function TUsuarioController.ListarUsuarios: TDataSet;
begin
  Result := Service.ListarUsuarios;
end;



function TUsuarioController.PesquisarUsuarios(const aFiltro: String): TDataset;
begin
  Result := Service.PesquisarUsuarios(aFiltro);
end;

function TUsuarioController.SalvarUsuario(Usuario: TUsuario):Boolean;
begin
  Result := Service.SalvarUsuario(Usuario);
end;

procedure TUsuarioController.RestaurarUsuarios(const aId :Integer);
begin
  Service.RestaurarUsuarios(aId);
end;

end.
