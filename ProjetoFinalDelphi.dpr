program ProjetoFinalDelphi;

uses
  Vcl.Forms,
  uFormCadastro.View in 'src\View\uFormCadastro.View.pas' {FormCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.Run;
end.
