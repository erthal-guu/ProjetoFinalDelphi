program ProjetoFinalDelphi;

uses
  Vcl.Forms,
  uFormCadastro.View in 'src\View\uFormCadastro.View.pas' {FormCadastro},
  uFormCadastro.Model in 'src\Model\uFormCadastro.Model.pas',
  uFormCadastro.repository in 'src\uFormCadastro.repository.pas',
  uFormCadastro.services in 'src\Services\uFormCadastro.services.pas',
  uFormCadastro.Controller in 'src\controller\uFormCadastro.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.Run;
end.
