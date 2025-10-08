unit ClienteCadastroController;

interface
uses uClienteDTO, ClienteCadastroService, FireDAC.Comp.Client, Vcl.Dialogs,Data.DB;

type TClienteController = class
  Service : TClienteService;
    constructor Create;
      function SalvarClientes(ClienteDTO: TClienteDTO): Boolean;
      procedure EditarClientes(ClienteDTO: TClienteDTO);
      function ListarClientes: TDataSet;
      function CriarObjeto(aNome,aCPF, aEmail,aTelefone,
  aNascimento,aEndereco : String; aAtivo: Boolean): TClienteDTO;
      procedure DeletarClientes(const aId :Integer);
      procedure RestaurarClientes(const aId :Integer);
      Function PesquisarClientes(const aFiltro:String):TDataset;
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

procedure TClienteController.DeletarClientes(const aId: Integer);
begin
  Service.DeletarClientes(aId);
end;

procedure TClienteController.EditarClientes(ClienteDTO: TClienteDTO);
begin
  Service.EditarClientes(ClienteDTO);
end;

function TClienteController.ListarClientes: TDataSet;
begin
  Service.ListarClientes;
end;

function TClienteController.PesquisarClientes(const aFiltro: String): TDataset;
begin
  Service.PesquisarClientes(aFiltro);
end;

procedure TClienteController.RestaurarClientes(const aId: Integer);
begin
  Service.RestaurarClientes(aId);
end;

function TClienteController.SalvarClientes(ClienteDTO: TClienteDTO): Boolean;
begin
  Service.SalvarClientes(ClienteDTO);
end;
end.
