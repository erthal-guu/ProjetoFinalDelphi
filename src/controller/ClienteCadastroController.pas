unit ClienteCadastroController;

interface
uses uClienteDTO, ClienteCadastroService, FireDAC.Comp.Client, Vcl.Dialogs,Data.DB;

type TClienteController = class
  Service : TClienteService;
    constructor Create;
      function SalvarUsuario(ClienteDTO: TClienteDTO): Boolean;
      procedure EditarUsuario(ClienteDTO: TClienteDTO);
      function ListarUsuarios: TDataSet;
      function CriarObjeto(aNome,aCPF, aEmail,aTelefone,
  aNascimento,aEndereco : String; aAtivo: Boolean): TClienteDTO;
      procedure DeletarUsuarios(const aId :Integer);
      procedure RestaurarUsuarios(const aId :Integer);
      Function PesquisarUsuarios(const aFiltro:String):TDataset;
  end;
implementation

{ TClienteController }

constructor TClienteController.Create;
begin
Self.Service := TClienteService.create;
end;

function TClienteController.CriarObjeto(aNome,aCPF, aEmail,aTelefone,
  aNascimento,aEndereco : String; aAtivo: Boolean): TClienteDTO;
begin
  Result := TClienteDTO.Create;
  Result.setNome(aNome);
  Result.setCPF(aCPF);
  Result.setEmail(aEmail);
  Result.setTelefone(aTelefone);
  Result.setEndereco(aEndereco);
  Result.setNascimento(aNascimento);
  Result.setAtivo(aAtivo);
end;

procedure TClienteController.DeletarUsuarios(const aId: Integer);
begin
  Service.DeletarClientes(aId);
end;

procedure TClienteController.EditarUsuario(ClienteDTO: TClienteDTO);
begin
  Service.EditarClientes(ClienteDTO);
end;

function TClienteController.ListarUsuarios: TDataSet;
begin
  Service.ListarClientes;
end;

function TClienteController.PesquisarUsuarios(const aFiltro: String): TDataset;
begin
  Service.PesquisarClientes(aFiltro);
end;

procedure TClienteController.RestaurarUsuarios(const aId: Integer);
begin
  Service.RestaurarClientes(aId);
end;

function TClienteController.SalvarUsuario(ClienteDTO: TClienteDTO): Boolean;
begin
  Service.SalvarClientes(ClienteDTO);
end;
end.
