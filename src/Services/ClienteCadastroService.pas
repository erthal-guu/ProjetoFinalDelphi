unit ClienteCadastroService;

interface
uses
  uCliente, ClienteCadastroRepository, uDMConexao, System.SysUtils,uMainController, FireDAC.Comp.Client,Data.DB,BCrypt,Vcl.Dialogs;
 type
  TClienteService = class
  private
    Repository: TClienteRepository;
  public
    constructor create;
    function SalvarClientes(Cliente :  TCliente): Boolean;
    function CriarObjeto(aNome,aCPF, aEmail,aTelefone,
    aNascimento,aEndereco : String; aAtivo: Boolean): TCliente;
    procedure EditarClientes(Cliente : TCliente);
    function ValidarClientes(ClienteValido: TCliente) : Boolean;
    function ListarClientes: TDataSet;
    function ListarClientesRestaurar : TDataSet;
    procedure DeletarClientes(const aId :Integer);
    procedure RestaurarClientes(const aId :Integer);
    function PesquisarClientes(const aFiltro: String):TDataSet;
  end;

implementation

{ TClienteService }

constructor TClienteService.create;
begin
  Repository := TClienteRepository.Create(DataModule1.FDQuery);
end;

function TClienteService.CriarObjeto(aNome,aCPF, aEmail,aTelefone,
    aNascimento,aEndereco : String; aAtivo: Boolean): TCliente;
var
  ClienteDTO: TCliente;
begin
  ClienteDTO := TCliente.Create;
  try
    ClienteDTO.setNome(aNome);
    ClienteDTO.setCPF(aCPF);
    ClienteDTO.setEmail(aEmail);
    ClienteDTO.setTelefone(aTelefone);
    ClienteDTO.setEndereco(aEndereco);
    ClienteDTO.setNascimento(aNascimento);
    ClienteDTO.setAtivo(aAtivo);

    Result := ClienteDTO;
  except
    ClienteDTO.Free;
    raise;
  end;
end;

procedure TClienteService.DeletarClientes(const aId: Integer);
begin
  Repository.DeletarClientes(aID);
end;

procedure TClienteService.EditarClientes(Cliente: TCliente);
begin
  Repository.EditarClientes(Cliente);
end;

function TClienteService.ListarClientes: TDataSet;
begin
  Result := Repository.ListarClientes;
end;

function TClienteService.ListarClientesRestaurar: TDataSet;
begin
  Result := Repository.ListarClientesRestaurar;
end;

function TClienteService.PesquisarClientes(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarClientes(aFiltro);
end;

procedure TClienteService.RestaurarClientes(const aId: Integer);
begin
  Repository.RestaurarClientes(aId);
end;

function TClienteService.SalvarClientes(Cliente: TCliente): Boolean;
begin
if ValidarClientes(Cliente) then begin
    Result := False;
    try
    if not Self.Repository.ExisteCPF(Cliente) then begin
      Self.Repository.inserirCliente(Cliente);
      Result := True;
    end;
    finally
    Repository.Free;
    end;
end;
end;

function TClienteService.ValidarClientes(ClienteValido: TCliente): Boolean;
begin
Result := (ClienteValido.getNome <> '') and
           (ClienteValido.getCPF <> '') and
           (ClienteValido.getEmail <> '') and
           (ClienteValido.getTelefone <> '') and
           (ClienteValido.getEndereco <> '') and
           (ClienteValido.getNascimento <> '');
end;

end.
