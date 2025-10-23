unit FornecedorCadastroService;

interface

uses
  uFornecedor, FornecedorCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB, IdHTTP, System.JSON,
  IdSSL, IdSSLOpenSSL, IdSSLOpenSSLHeaders, Logs, uSession, PeçasCadastroRepository,System.Classes;

type
  TFornecedorService = class
  private
    Repository: TFornecedorRepository;
  public
    constructor Create;
    function SalvarFornecedor(Fornecedor: TFornecedor): Boolean;
    function CriarObjeto(aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
      aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFornecedor;
    procedure EditarFornecedor(Fornecedor: TFornecedor);
    function ValidarFornecedor(FornecedorValido: TFornecedor): Boolean;
    function ListarFornecedores: TDataSet;
    function ListarFornecedoresRestaurar: TDataSet;
    procedure DeletarFornecedor(const aId: Integer);
    procedure RestaurarFornecedor(const aId: Integer);
    function PesquisarFornecedores(const aFiltro: String): TDataSet;
    procedure BuscarCep(const ACep: string; out aRua, aBairro, aCidade, aEstado: string);
    procedure VincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer);
    function ListarPecasPorFornecedor(aFornecedorID: Integer): TDataSet;
    Function CarregarFornecedores : TStringlist;
    procedure DesvincularPecaDoFornecedor(aPecaID, aFornecedorID: Integer);
  end;

implementation

{ TFornecedorService }

function TFornecedorService.CarregarFornecedores: TStringlist;
begin
    Result := Repository.CarregarFornecedores;
end;

constructor TFornecedorService.Create;
begin
  Repository := TFornecedorRepository.Create(DataModule1.FDQuery);
end;

function TFornecedorService.CriarObjeto(
  aNome, aRazaoSocial, aCNPJ, aTelefone, aCEP, aRua, aNumero,
  aBairro, aCidade, aEstado: String; aAtivo: Boolean): TFornecedor;
var
  FornecedorDTO: TFornecedor;
begin
  FornecedorDTO := TFornecedor.Create;
  try
    FornecedorDTO.setNome(aNome);
    FornecedorDTO.setRazaoSocial(aRazaoSocial);
    FornecedorDTO.setCNPJ(aCNPJ);
    FornecedorDTO.setTelefone(aTelefone);
    FornecedorDTO.setCEP(aCEP);
    FornecedorDTO.setRua(aRua);
    FornecedorDTO.setNumero(aNumero);
    FornecedorDTO.setBairro(aBairro);
    FornecedorDTO.setCidade(aCidade);
    FornecedorDTO.setEstado(aEstado);
    FornecedorDTO.setAtivo(aAtivo);
    Result := FornecedorDTO;
  except
    FornecedorDTO.Free;
    raise;
  end;
end;

function TFornecedorService.SalvarFornecedor(Fornecedor: TFornecedor): Boolean;
var
  IDUsuarioLogado: Integer;
begin
  Result := False;
  IDUsuarioLogado := uSession.UsuarioLogadoID;

  if ValidarFornecedor(Fornecedor) then
  begin
    if not Repository.ExisteCNPJ(Fornecedor) then
    begin
      Repository.InserirFornecedor(Fornecedor);
      SalvarLog(Format('CADASTRO - ID: %d cadastrou fornecedor: %s (CNPJ: %s)',
        [IDUsuarioLogado, Fornecedor.getNome, Fornecedor.getCNPJ]));
      Result := True;
    end
    else
    begin
      SalvarLog(Format('CADASTRO - ID: %d falhou ao cadastrar (CNPJ já existente: %s)',
        [IDUsuarioLogado, Fornecedor.getCNPJ]));
    end;
  end;
end;

procedure TFornecedorService.EditarFornecedor(Fornecedor: TFornecedor);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.EditarFornecedor(Fornecedor);
  SalvarLog(Format('EDITAR - ID: %d editou fornecedor: %s (CNPJ: %s)',
    [IDUsuarioLogado, Fornecedor.getNome, Fornecedor.getCNPJ]));
end;

procedure TFornecedorService.DeletarFornecedor(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.DeletarFornecedor(aId);
  SalvarLog(Format('DELETAR - ID: %d deletou fornecedor ID: %d',
    [IDUsuarioLogado, aId]));
end;

procedure TFornecedorService.DesvincularPecaDoFornecedor(aPecaID,aFornecedorID: Integer);
begin
 Repository.DesvincularPecaFornecedor(aPecaID,aFornecedorID);
end;

procedure TFornecedorService.RestaurarFornecedor(const aId: Integer);
var
  IDUsuarioLogado: Integer;
begin
  IDUsuarioLogado := uSession.UsuarioLogadoID;
  Repository.RestaurarFornecedor(aId);
  SalvarLog(Format('RESTAURAR - ID: %d restaurou fornecedor ID: %d',
    [IDUsuarioLogado, aId]));
end;

function TFornecedorService.ListarFornecedores: TDataSet;
begin
  Result := Repository.ListarFornecedores;
end;

function TFornecedorService.ListarFornecedoresRestaurar: TDataSet;
begin
  Result := Repository.ListarFornecedoresRestaurar;
end;

function TFornecedorService.PesquisarFornecedores(const aFiltro: String): TDataSet;
begin
  Result := Repository.PesquisarFornecedores(aFiltro);
end;

function TFornecedorService.ValidarFornecedor(FornecedorValido: TFornecedor): Boolean;
begin
  Result :=
    (FornecedorValido.getNome <> '') and
    (FornecedorValido.getRazaoSocial <> '') and
    (FornecedorValido.getCNPJ <> '') and
    (FornecedorValido.getTelefone <> '') and
    (FornecedorValido.getCEP <> '') and
    (FornecedorValido.getRua <> '') and
    (FornecedorValido.getNumero <> '') and
    (FornecedorValido.getBairro <> '') and
    (FornecedorValido.getCidade <> '') and
    (FornecedorValido.getEstado <> '');
end;

procedure TFornecedorService.BuscarCep(const ACep: string; out aRua, aBairro, aCidade, aEstado: string);
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

procedure TFornecedorService.VincularPecaAoFornecedor(aPecaID, aFornecedorID: Integer);
begin
  Repository.VincularPecaFornecedor(aPecaID, aFornecedorID);
  SalvarLog(Format('VINCULAR - Peça ID: %d vinculada ao Fornecedor ID: %d',
    [aPecaID, aFornecedorID]));
end;

function TFornecedorService.ListarPecasPorFornecedor(aFornecedorID: Integer): TDataSet;
begin
  Result := Repository.ListarPecasVinculadas(aFornecedorID);
end;

end.

