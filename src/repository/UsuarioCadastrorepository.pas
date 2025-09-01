unit UsuarioCadastrorepository;

interface
uses uDMConexao,FireDAC.Comp.Client, System.SysUtils,uUsuarioDTO;

type TCadastroRepository = class
private
  FQuery:TFDQuery;
  procedure inserirAluno(aUsuario : TUsuarioDTO);
public
constructor Create(Query:TFDQuery);
end;
implementation


{ TCadastrRepository }

constructor TCadastroRepository.Create(Query: TFDQuery);
begin
FQuery := Query;
end;


procedure TCadastroRepository.inserirAluno(aUsuario : TUsuarioDTO);
begin
  aUsuario := TUsuarioDTO.Create;
  FQuery.close;
  FQuery.SQL.Add('INSERT INTO usuarios (nome,CPF, senha) VALUES (:nome,:CPF,:senha)');
  FQuery.ParamByName('nome').AsString := aUsuario.getNome ;
  FQuery.ParamByName('cpf').AsString := aUsuario.getCPF ;
  FQuery.ParamByName('senha').AsString := aUsuario.getSenha;
  FQuery.ExecSQL;
end;

end.
