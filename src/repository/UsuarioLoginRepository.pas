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
  begin
    Self.FQuery.SQL.Clear;
    Self.FQuery.SQL.Add('SELECT * FROM usuarios WHERE CPF = :cpf');
    Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF;

    Self.FQuery.Open;
    try
      if Self.FQuery.IsEmpty then
        Result := nil
      else
      begin
        Result := TUsuario.Create;
        Result.setID(Self.FQuery.FieldByName('id').AsInteger);
        Result.setNome(Self.FQuery.FieldByName('nome').AsString);
        Result.setCPF(Self.FQuery.FieldByName('cpf').AsString);
        Result.setSenha(Self.FQuery.FieldByName('senha').AsString);
      end;
    finally
      Self.FQuery.Close;
    end;
  end;


  end.
