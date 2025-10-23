unit Logs;

interface

uses
  System.SysUtils,System.IOUtils;

procedure SalvarLog(const Mensagem: string);

implementation

procedure SalvarLog(const Mensagem: string);
var
  CaminhoLog, NomeArquivo: string;
begin
  CaminhoLog := 'C:\Users\siqueira.6989\Desktop\ProjetoFinalDelphi\src\Logs';
  if not TDirectory.Exists(CaminhoLog) then
    TDirectory.CreateDirectory(CaminhoLog);
  NomeArquivo := Format('%s\Log_%s.txt', [CaminhoLog, FormatDateTime('yyyy-mm-dd', Now)]);
  TFile.AppendAllText(NomeArquivo,FormatDateTime('hh:nn:ss', Now) + ' - ' + Mensagem + sLineBreak,TEncoding.UTF8);
end;

end.

