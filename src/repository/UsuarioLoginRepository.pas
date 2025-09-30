unit UsuarioLoginRepository;

interface
uses uDMConexao,FireDAC.Comp.Client, System.SysUtils,uUsuarioDTO,uUsuarioModel;

type TLoginRepository = class
private
  FQuery:TFDQuery;
public
function SelectUsuario(aUsuario : TUsuarioDTO):TUsuario;
constructor Create(Query : TFDQuery);
end;
implementation


{ TCadastrRepository }

constructor TLoginRepository.Create(Query : TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;


function TLoginRepository.SelectUsuario(aUsuario: TUsuarioDTO): TUsuario;
begin
  Self.FQuery.SQL.Clear;
  Self.FQuery.SQL.Add('SELECT * FROM usuarios WHERE CPF = :cpf');
  Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF;
  try
    Self.FQuery.Open;

    if Self.FQuery.IsEmpty then
    begin
      Result := nil;
    end
    else
    begin
      Result := TUsuario.Create('', '', '');
      Result.setNome(Self.FQuery.FieldByName('nome').AsString);
      Result.setCPF(Self.FQuery.FieldByName('cpf').AsString);
      Result.setSenha(Self.FQuery.FieldByName('senha').AsString);
    end;
  finally
    Self.FQuery.Close;
  end;
end;


end.
