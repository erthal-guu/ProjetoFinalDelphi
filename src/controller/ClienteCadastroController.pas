unit ClienteCadastroController;

interface
uses uCliente, ClienteCadastroService, FireDAC.Comp.Client, Vcl.Dialogs,Data.DB;

type TClienteController = class
  Service : TClienteService;
    constructor Create;
      function SalvarClientes(Cliente: TCliente): Boolean;
      procedure EditarClientes(Cliente: TCliente);
      function ListarClientes: TDataSet;
      function CriarObjeto(aNome,aCPF, aEmail,aTelefone,
  aNascimento,aEndereco : String; aAtivo: Boolean): TCliente;
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
  aNascimento,aEndereco : String; aAtivo: Boolean): TCliente;
begin
  Result := TCliente.Create;
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

procedure TClienteController.EditarClientes(Cliente: TCliente);
begin
  Service.EditarClientes(Cliente);
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

function TClienteController.SalvarClientes(Cliente: TCliente): Boolean;
begin
  Service.SalvarClientes(Cliente);
end;
end.
