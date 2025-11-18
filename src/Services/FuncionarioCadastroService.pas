unit FuncionarioCadastroService;

interface

uses
  uFuncionario, FuncionarioCadastroRepository, uDMConexao, System.SysUtils,
  uMainController, FireDAC.Comp.Client, Data.DB, Vcl.Dialogs, IdHTTP, System.JSON,
  IdSSL, IdSSLOpenSSL, IdSSLOpenSSLHeaders, uSession, Logs;

type
  TFuncionarioService = class
  private
    Repository: TFuncionarioRepository;
  public
    constructor Create;
    function SalvarFuncionario(Funcionario: TFuncionario): Boolean;
    function CriarObjeto(aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,
      aBairro, aCidade, aEstado,aTipo: String; aAtivo: Boolean): TFuncionario;
    procedure EditarFuncionario(Funcionario: TFuncionario);
    function ValidarFuncionario(FuncionarioValido: TFuncionario): Boolean;
    function ListarFuncionarios: TDataSet;
    function ListarFuncionariosRestaurar: TDataSet;
    procedure DeletarFuncionario(const aId: Integer);
    procedure RestaurarFuncionario(const aId: Integer);
    function PesquisarFuncionarios(const aFiltro: String): TDataSet;
    procedure BuscarCep(const ACep: string; out aRua, aBairro, aCidade, aEstado: string);
  end;

implementation

{ TFuncionarioService }

constructor TFuncionarioService.Create;
begin
  Repository := TFuncionarioRepository.Create(DataModule1.FDQuery);
end;

function TFuncionarioService.CriarObjeto(
  aNome, aCPF, aRG, aNascimento, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado,aTipo: String; aAtivo: Boolean): TFuncionario;
var
  Funcionario: TFuncionario;
begin
  Funcionario := TFuncionario.Create;
  try
    Funcionario.setNome(aNome);
    Funcionario.setCPF(aCPF);
    Funcionario.setRG(aRG);
    Funcionario.setNascimento(aNascimento);
    Funcionario.setTelefone(aTelefone);
    Funcionario.setCEP(aCEP);
    Funcionario.setRua(aRua);
    Funcionario.setNumero(aNumero);
    Funcionario.setBairro(aBairro);
    Funcionario.setCidade(aCidade);
    Funcionario.setEstado(aEstado);
    Funcionario.setAtivo(aAtivo);
    Funcionario.setAtivo(aAtivo);
    Result := Funcionario;
  except
    Funcionario.Free;
    raise;
  end;
end;

function TFuncionarioService.SalvarFuncionario(Funcionario: TFuncionario): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarFuncionario(Funcionario) then
  begin
    if not Repository.ExisteCPF(Funcionario) then
    begin
      Repository.InserirFuncionario(Funcionario);
      SalvarLog(Format('CADASTRO - ID: %d cadastrou funcionário: %s (CPF: %s)',
        [IDUsuarioLogado, Funcionario.getNome, Funcionario.getCPF]));
      Result := True;
    end
    else
      SalvarLog(Format('CADASTRO - ID: %d falhou ao cadastrar (CPF já existente: %s)',
        [IDUsuarioLogado, Funcionario.getCPF]));
  end;
end;

procedure TFuncionarioService.EditarFuncionario(Funcionario: TFuncionario);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  if Repository.ExisteCPF(Funcionario) then begin
    ShowMessage('Esse CPF ja esta cadastrado a um Funcionário');
  end else begin
    Repository.EditarFuncionario(Funcionario);
    SalvarLog(Format('EDITAR - ID: %d editou funcionário: %s (CPF: %s)',
    [IDUsuarioLogado, Funcionario.getNome, Funcionario.getCPF]));
  end;
end;

procedure TFuncionarioService.DeletarFuncionario(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  Repository.DeletarFuncionario(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou funcionário ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TFuncionarioService.RestaurarFuncionario(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  Repository.RestaurarFuncionario(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou funcionário ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TFuncionarioService.ListarFuncionarios: TDataSet;
begin
  Result := Repository.ListarFuncionarios;
end;

function TFuncionarioService.ListarFuncionariosRestaurar: TDataSet;
begin
  Result := Repository.ListarFuncionariosRestaurar;
end;

function TFuncionarioService.PesquisarFuncionarios(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarFuncionarios(aFiltro);
end;

function TFuncionarioService.ValidarFuncionario(FuncionarioValido: TFuncionario): Boolean;
begin
  Result :=
    (FuncionarioValido.getNome <> '') and
    (FuncionarioValido.getCPF <> '') and
    (FuncionarioValido.getRG <> '') and
    (FuncionarioValido.getNascimento <> '') and
    (FuncionarioValido.getTelefone <> '') and
    (FuncionarioValido.getCEP <> '') and
    (FuncionarioValido.getRua <> '') and
    (FuncionarioValido.getNumero <> '') and
    (FuncionarioValido.getBairro <> '') and
    (FuncionarioValido.getCidade <> '') and
    (FuncionarioValido.getTipo <> '') and
    (FuncionarioValido.getEstado <> '');
end;

procedure TFuncionarioService.BuscarCep(const ACep: string; out aRua, aBairro, aCidade, aEstado: string);
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  JsonStr: string;
  JsonObj: TJSONObject;
  CepLimpo: string;
  dummyInt: Integer;
begin
  aRua := ''; aBairro := ''; aCidade := ''; aEstado := '';
  CepLimpo := StringReplace(ACep, '-', '', [rfReplaceAll]);
  CepLimpo := StringReplace(CepLimpo, '.', '', [rfReplaceAll]);
  CepLimpo := Trim(CepLimpo);
  if (Length(CepLimpo) <> 8) or (not TryStrToInt(CepLimpo, dummyInt)) then
    Exit;

  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    IdSSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := IdSSL;
    JsonStr := IdHTTP.Get('https://viacep.com.br/ws/' + CepLimpo + '/json/');
    JsonObj := TJSONObject.ParseJSONValue(JsonStr) as TJSONObject;
    try
      if Assigned(JsonObj.Values['erro']) then
        raise Exception.Create('CEP não encontrado.');
      aRua    := JsonObj.Values['logradouro'].Value;
      aBairro := JsonObj.Values['bairro'].Value;
      aCidade := JsonObj.Values['localidade'].Value;
      aEstado := JsonObj.Values['uf'].Value;
    finally
      JsonObj.Free;
    end;
  finally
    IdSSL.Free;
    IdHTTP.Free;
  end;
end;

end.

