unit UsuarioLoginRepository;

interface

uses
  uDMConexao,
  FireDAC.Comp.Client,
  System.SysUtils,
  uUsuario;

type
  TLoginRepository = class
  private
    FQuery: TFDQuery;
  public
    function SelectUsuario(aUsuario: TUsuario): TUsuario;
    constructor Create(Query: TFDQuery);
  end;

implementation

{ TLoginRepository }

constructor TLoginRepository.Create(Query: TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;

function TLoginRepository.SelectUsuario(aUsuario: TUsuario): TUsuario;
var
  Usuario: TUsuario;
begin
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add('SELECT * FROM usuarios WHERE CPF = :cpf');
  Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF;
  try
    Self.FQuery.Open;
    if Self.FQuery.IsEmpty then
    begin
      Result := nil
    end else begin
      Usuario := TUsuario.Create;
      Usuario.setCPF(Self.FQuery.FieldByName('cpf').AsString);
      Usuario.setSenha(Self.FQuery.FieldByName('senha').AsString);
      Result := Usuario;
    end;
  finally
    Self.FQuery.Close;
  end;
end;

end.
