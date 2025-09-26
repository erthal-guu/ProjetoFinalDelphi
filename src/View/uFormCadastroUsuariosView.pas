unit uFormCadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls, UsuarioCadastroController, uUsuarioDTO, Vcl.Mask, uDMConexao,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,CadastroUsuarioService;

type
  TFormCadastroUsuarios = class(TForm)
    PageControl1: TPageControl;
    Usuarios: TTabSheet;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    Image1: TImage;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlGrid: TPanel;
    PnlEdit: TPanel;
    EdtNome: TEdit;
    CmbGrupo: TComboBox;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    CmbStatus: TComboBox;
    EdtCPF: TMaskEdit;
    EdtSenha: TEdit;
    DataSource1: TDataSource;
    DBGridMain: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGridRestaurar: TDBGrid;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    function ValidarCampos : Boolean;
    procedure CarregarGrid;
    procedure LimparCampos;
    procedure FormShow(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FormCadastroUsuarios: TFormCadastroUsuarios;

implementation

{$R *.dfm}

procedure TFormCadastroUsuarios.BtnAdicionarClick(Sender: TObject);
begin
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;


procedure TFormCadastroUsuarios.BtnExcluirClick(Sender: TObject);
var
  Controller : TUsuarioController;
  IdUsuario: Integer;
begin
  if DataSource1.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;
  IdUsuario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

  if MessageDlg('Deseja realmente deletar este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TUsuarioController.Create;
    try
      Controller.DeletarUsuarios(IdUsuario);
      CarregarGrid;
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFormCadastroUsuarios.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgrounEdit.Visible := false;
end;


procedure TFormCadastroUsuarios.CarregarGrid;
var
  UsuarioService : TUsuarioService;
begin
UsuarioService := TUsuarioService.create;
DataSource1.DataSet :=  UsuarioService.ListarUsuarios;
DBGridMain.DataSource := DataSource1;

    if DBGridMain.Columns.Count >= 5 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'Grupo';
      DBGridMain.Columns[4].Title.Caption := 'Status';

      DBGridMain.Columns[0].Width := 170;
      DBGridMain.Columns[1].Width := 170;
      DBGridMain.Columns[2].Width := 170;
      DBGridMain.Columns[3].Width := 170;
      DBGridMain.Columns[4].Width := 170;
    end;

    if DBGridRestaurar.Columns.Count >= 5 then
    begin
      DBGridRestaurar.Columns[0].Title.Caption := 'Id';
      DBGridRestaurar.Columns[1].Title.Caption := 'Nome';
      DBGridRestaurar.Columns[2].Title.Caption := 'CPF';
      DBGridRestaurar.Columns[3].Title.Caption := 'Grupo';
      DBGridRestaurar.Columns[4].Title.Caption := 'Status';

      DBGridRestaurar.Columns[0].Width := 40;
      DBGridRestaurar.Columns[1].Width := 40;
      DBGridRestaurar.Columns[2].Width := 40;
      DBGridRestaurar.Columns[3].Width := 40;
      DBGridRestaurar.Columns[4].Width := 40;
    end;

end;

procedure TFormCadastroUsuarios.FormCreate(Sender: TObject);
begin
  EdtSenha.Height := 31;
  EdtNome.Height := 31;
  EdtCPF.Height := 31;
  CmbGrupo.Height:= 31;
  CmbGrupo.Font.Size := 13;
  CmbStatus.Font.Size := 13;
  CmbStatus.Height:= 31;
end;


procedure TFormCadastroUsuarios.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

procedure TFormCadastroUsuarios.LblEnviarClick(Sender: TObject);
var
  Controller: TUsuarioController;
  UsuarioDTO: TUsuarioDTO;
begin
  if ValidarCampos then begin
  Controller := TUsuarioController.Create;
  try
    UsuarioDTO := Controller.CriarObjetoCRUD(EdtNome.Text,EdtCPF.Text,EdtSenha.Text,CmbGrupo.text,CmbStatus.Text);
  Controller.SalvarUsuarioCRUD(UsuarioDTO);
  LimparCampos;
  CarregarGrid;
  finally
    Controller.Free;
  end;
  end;
end;

procedure TFormCadastroUsuarios.LimparCampos;
begin
  EdtNome.Clear;
  EdtCPF.Clear;
  EdtSenha.Clear;
end;

function TFormCadastroUsuarios.ValidarCampos: Boolean;
begin
  if EdtNome.Text = '' then begin
    ShowMessage('O Campo de NOME não pode ficar Vazio');
    exit;
  end;

  if EdtCPF.Text = '' then begin
    ShowMessage('O Campo de CPF não pode ficar Vazio');
    exit;
  end;
  if EdtSenha.Text = '' then begin
    ShowMessage('O Campo de SENHA não pode ficar Vazio');
    exit;
  end;
  if Length(EdtSenha.Text) < 5 then begin
    ShowMessage('A senha deve Conter Pelo menos "5" Caracteres');
    exit;
  end;
  Result := True;
end;

end.
