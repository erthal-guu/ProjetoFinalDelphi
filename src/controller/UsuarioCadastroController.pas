unit UsuarioCadastroController;

interface
uses uUsuarioDTO,UsuarioCadastrorepository,uDMConexao,Vcl.Dialogs,uMainController;

type TUsuarioController = class
  public
    procedure SalvarUsuario(UsuarioDTO : TUsuarioDTO);
    procedure SalvarUsuarioCRUD(UsuarioDTO : TUsuarioDTO);
    function CriarObjeto(aNome, aCPF, aSenha: String) : TUsuarioDTO;
    function CriarObjetoCRUD(aNome, aCPF, aSenha,aGrupo,aStatus: String) : TUsuarioDTO;
    procedure EditarUsuario (UsuarioDTO : TUsuarioDTO);
    function ValidarUsuario(UsuarioValido: TUsuarioDTO) : Boolean;
end;

implementation
{ TUsuarioController }

function TUsuarioController.CriarObjeto;
var UsuarioDTO : TUsuarioDTO;
begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setNome(aNome);
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(aSenha);
    Result := UsuarioDTO;
end;

function TUsuarioController.CriarObjetoCRUD(aNome, aCPF, aSenha,
  aGrupo,aStatus: String): TUsuarioDTO;
var UsuarioDTO : TUsuarioDTO;
begin
    UsuarioDTO := TUsuarioDTO.Create;
    UsuarioDTO.setNome(aNome);
    UsuarioDTO.setCPF(aCPF);
    UsuarioDTO.setSenha(aSenha);
    UsuarioDTO.setGrupo(aGrupo);
    UsuarioDTO.setStatus(aStatus);
    Result := UsuarioDTO;
end;

procedure TUsuarioController.EditarUsuario(UsuarioDTO: TUsuarioDTO);
var
  Repository : TCadastroRepository;
begin
if ValidarUsuario(UsuarioDTO) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    try
    Repository.EditarUsuario(UsuarioDTO);
      ShowMessage('Usuário Editado com sucesso!');
    finally
    Repository.Free;
    end;
end;
end;

procedure TUsuarioController.SalvarUsuario(UsuarioDTO: TUsuarioDTO);
var
  Repository : TCadastroRepository;
begin
if ValidarUsuario(UsuarioDTO) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    try
    if not Repository.ExisteCPF(UsuarioDTO) then begin
      Repository.inserirUsuario(UsuarioDTO);
      ShowMessage('Usuário salvo com sucesso!');
      MainController.showHome;
    end else begin
      ShowMessage('Já existe um Usuário com esse CPF');
    end;
    finally
      Repository.Free;
    end;
  end;
end;

procedure TUsuarioController.SalvarUsuarioCRUD(UsuarioDTO: TUsuarioDTO);
var
  Repository : TCadastroRepository;
begin
if ValidarUsuario(UsuarioDTO) then begin

    Repository := TCadastroRepository.Create(DataModule1.FDQuery);
    try
    if not Repository.ExisteCPF(UsuarioDTO) then begin
      Repository.inserirUsuario(UsuarioDTO);
      ShowMessage('Usuário salvo com sucesso!');
    end else begin
      ShowMessage('Já existe um Usuário com esse CPF');
    end;
    finally
      Repository.Free;
    end;
  end;
end;

function TUsuarioController.ValidarUsuario(UsuarioValido: TUsuarioDTO): Boolean;
begin
 Result := ((UsuarioValido.getNome)<>'')and((UsuarioValido.getCPF)<>'')
            and((UsuarioValido.getSenha)<>'')
end;

end.
