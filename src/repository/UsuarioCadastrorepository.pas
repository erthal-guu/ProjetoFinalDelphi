unit UsuarioCadastrorepository;

interface
uses uDMConexao,FireDAC.Comp.Client, System.SysUtils,uUsuarioDTO;

type TCadastroRepository = class
private
  FQuery:TFDQuery;
public
procedure inserirUsuario(aUsuario : TUsuarioDTO);
constructor Create(Query : TFDQuery);
end;
implementation


{ TCadastrRepository }

constructor TCadastroRepository.Create(Query : TFDQuery);
begin
  inherited Create;
  FQuery := Query;
end;


procedure TCadastroRepository.inserirUsuario(aUsuario : TUsuarioDTO);
begin
  Self.FQuery.close;
  Self.FQuery.SQL.Add('INSERT INTO usuarios (nome,CPF,senha) VALUES (:nome,:CPF,:senha)');
  Self.FQuery.ParamByName('nome').AsString := aUsuario.getNome ;
  Self.FQuery.ParamByName('cpf').AsString := aUsuario.getCPF ;
  Self.FQuery.ParamByName('senha').AsString := aUsuario.getSenha;
  Self.FQuery.ExecSQL;
end;

end.
