unit FornecedorCadastroService;

interface

uses
  uFornecedor, FornecedorCadastroRepository, uDMConexao, System.SysUtils,
  FireDAC.Comp.Client, Data.DB,IdHTTP, System.JSON,
    IdSSL, IdSSLOpenSSL, IdSSLOpenSSLHeaders;

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
  end;

implementation

procedure TFornecedorService.BuscarCep(const ACep: string; out aRua, aBairro,
  aCidade, aEstado: string);
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
  begin
    Exit;
  end;

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

procedure TFornecedorService.DeletarFornecedor(const aId: Integer);
begin
  Repository.DeletarFornecedor(aId);
end;

procedure TFornecedorService.EditarFornecedor(Fornecedor: TFornecedor);
begin
  Repository.EditarFornecedor(Fornecedor);
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

procedure TFornecedorService.RestaurarFornecedor(const aId: Integer);
begin
  Repository.RestaurarFornecedor(aId);
end;

function TFornecedorService.SalvarFornecedor(Fornecedor: TFornecedor): Boolean;
begin
  Result := False;
  if ValidarFornecedor(Fornecedor) then
  begin
    if not Repository.ExisteCNPJ(Fornecedor) then
    begin
      Repository.InserirFornecedor(Fornecedor);
      Result := True;
    end;
  end;
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

end.
