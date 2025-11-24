unit ClienteCadastroService;

interface

uses
  uCliente, ClienteCadastroRepository, uDMConexao, System.SysUtils,
  uMainController,
  FireDAC.Comp.Client, Data.DB, BCrypt, Vcl.Dialogs, Logs, uSession,
  System.Classes;

type
  TClienteService = class
  private
    Repository: TClienteRepository;
  public
    constructor Create;
    destructor Destroy; override;
    function SalvarClientes(Cliente: TCliente): Boolean;
    function CriarObjeto(aNome, aCPF, aEmail, aTelefone, aNascimento: String;
      aAtivo: Boolean): TCliente;
    procedure EditarClientes(Cliente: TCliente);
    function ValidarClientes(ClienteValido: TCliente): Boolean;
    function ListarClientes: TDataSet;
    function ListarClientesRestaurar: TDataSet;
    procedure DeletarClientes(const aId: Integer);
    procedure RestaurarClientes(const aId: Integer);
    function PesquisarClientes(const aFiltro: String): TDataSet;
  end;

implementation

{ TClienteService }

constructor TClienteService.Create;
begin
  Repository := TClienteRepository.Create(DataModule1.FDQuery);
end;

destructor TClienteService.Destroy;
begin
  Repository.Free;
  inherited;
end;

function TClienteService.CriarObjeto(aNome, aCPF, aEmail, aTelefone,
  aNascimento: String; aAtivo: Boolean): TCliente;
var
  Cliente: TCliente;
begin
  Cliente := TCliente.Create;
  try
    Cliente.setNome(aNome);
    Cliente.setCPF(aCPF);
    Cliente.setEmail(aEmail);
    Cliente.setTelefone(aTelefone);
    Cliente.setNascimento(aNascimento);
    Cliente.setAtivo(aAtivo);
    Result := Cliente;
  except
    Cliente.Free;
    raise;
  end;
end;

function TClienteService.ValidarClientes(ClienteValido: TCliente): Boolean;
begin
  Result := (ClienteValido.getNome <> '') and (ClienteValido.getCPF <> '') and
    (ClienteValido.getEmail <> '') and (ClienteValido.getTelefone <> '') and
    (ClienteValido.getNascimento <> '');
end;

function TClienteService.SalvarClientes(Cliente: TCliente): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if not ValidarClientes(Cliente) then begin
    ShowMessage('Preencha todos os campos obrigatórios.');
    Exit;
  end;

  try
    if not Repository.ExisteCPF(Cliente) then begin
      Repository.InserirCliente(Cliente);
      SalvarLog(Format
        ('CADASTRO CLIENTE - ID: %d cadastrou o cliente: %s (CPF: %s)',
        [IDUsuarioLogado, Cliente.getNome, Cliente.getCPF]));
      Result := True;
    end
    else begin
      ShowMessage('CPF já cadastrado.');
      SalvarLog(Format
        ('CADASTRO CLIENTE - ID: %d falhou ao cadastrar (CPF já existente: %s)',
        [IDUsuarioLogado, Cliente.getCPF]));
      Result := False;
    end;
  except
    on E: Exception do begin
      SalvarLog(Format('CADASTRO CLIENTE - ID: %d erro ao cadastrar: %s - %s',
        [IDUsuarioLogado, E.ClassName, E.Message]));
      raise;
    end;
  end;
end;

procedure TClienteService.EditarClientes(Cliente: TCliente);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  if Repository.ExisteCPF(Cliente) then begin
    ShowMessage('Esse CPF já esta cadastrado a um Cliente');
  end
  else begin
    Repository.EditarClientes(Cliente);
    SalvarLog(Format('EDITAR - ID: %d editou Cliente: %s (CPF: %s)',
      [IDUsuarioLogado, Cliente.getNome, Cliente.getCPF]));
  end;
end;

procedure TClienteService.DeletarClientes(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  try
    Repository.DeletarClientes(aId);
    SalvarLog(Format('DELETAR CLIENTE - ID: %d deletou o cliente ID: %d',
      [IDUsuarioLogado, aId]));
  except
    on E: Exception do begin
      SalvarLog(Format
        ('DELETAR CLIENTE - ID: %d erro ao deletar cliente ID: %d - %s',
        [IDUsuarioLogado, aId, E.Message]));
      raise;
    end;
  end;
end;

procedure TClienteService.RestaurarClientes(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  try
    Repository.RestaurarClientes(aId);
    SalvarLog(Format('RESTAURAR CLIENTE - ID: %d restaurou o cliente ID: %d',
      [IDUsuarioLogado, aId]));
  except
    on E: Exception do begin
      SalvarLog(Format
        ('RESTAURAR CLIENTE - ID: %d erro ao restaurar cliente ID: %d - %s',
        [IDUsuarioLogado, aId, E.Message]));
      raise;
    end;
  end;
end;

function TClienteService.ListarClientes: TDataSet;
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Result := Repository.ListarClientes;
end;

function TClienteService.ListarClientesRestaurar: TDataSet;
begin
  Result := Repository.ListarClientesRestaurar;
end;

function TClienteService.PesquisarClientes(const aFiltro: String): TDataSet;
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Result := Repository.PesquisarClientes(aFiltro);
end;

end.
