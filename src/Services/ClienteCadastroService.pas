unit ClienteCadastroService;

interface
uses
  uClienteDTO, ClienteCadastroRepository, uDMConexao, System.SysUtils,uMainController, FireDAC.Comp.Client,Data.DB,BCrypt,Vcl.Dialogs;
 type
  TClienteService = class
  private
    Repository: TClienteRepository;
  public
    constructor create;
    function SalvarClientes(ClienteDTO :  TClienteDTO): Boolean;
    function CriarObjeto(aNome,aCPF, aEmail,aTelefone,
    aNascimento,aEndereco : String; aAtivo: Boolean): TClienteDTO;
    procedure EditarClientes(ClienteDTO : TClienteDTO);
    function ValidarClientes(ClienteValido: TClienteDTO) : Boolean;
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
    aNascimento,aEndereco : String; aAtivo: Boolean): TClienteDTO;
var
  ClienteDTO: TClienteDTO;
begin
  ClienteDTO := TClienteDTO.Create;
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

procedure TClienteService.EditarClientes(ClienteDTO: TClienteDTO);
begin
  Repository.EditarClientes(ClienteDTO);
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

function TClienteService.SalvarClientes(ClienteDTO: TClienteDTO): Boolean;
begin
if ValidarClientes(ClienteDTO) then begin
    Result := False;
    try
    if not Self.Repository.ExisteCPF(ClienteDTO) then begin
      Self.Repository.inserirCliente(ClienteDTO);
      Result := True;
    end;
    finally
    Repository.Free;
    end;
end;
end;

function TClienteService.ValidarClientes(ClienteValido: TClienteDTO): Boolean;
begin
Result := (ClienteValido.getNome <> '') and
           (ClienteValido.getCPF <> '') and
           (ClienteValido.getEmail <> '') and
           (ClienteValido.getTelefone <> '') and
           (ClienteValido.getEndereco <> '') and
           (ClienteValido.getNascimento <> '');
end;

end.
