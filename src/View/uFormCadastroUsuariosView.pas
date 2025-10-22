unit uFormCadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls, UsuarioCadastroController, uUsuario, Vcl.Mask, uDMConexao,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,UsuarioCadastroService;

type
  TFormCadastroUsuarios = class(TForm)
    PageControl1: TPageControl;
    DataSourceMain: TDataSource;
    DataSourceRestaurar: TDataSource;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgroundEdit: TPanel;
    PnlDesignEdit: TPanel;
    imgLogo: TImage;
    PnlEdit: TPanel;
    PnlCmbStatus: TPanel;
    LblStatus: TLabel;
    CmbStatus: TComboBox;
    PnlEdtNome: TPanel;
    LblNome: TLabel;
    EdtNome: TEdit;
    PnlEdtCPF: TPanel;
    LblCPF: TLabel;
    EdtCPF: TMaskEdit;
    PnlEdtSenha: TPanel;
    LblSenha: TLabel;
    EdtSenha: TEdit;
    Panel5: TPanel;
    LblConfrimarSenha: TLabel;
    EdtConfirmarSenha: TEdit;
    PnlCmbGrupo: TPanel;
    LblGrupo: TLabel;
    CmbGrupo: TComboBox;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
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
    DBGridMain: TDBGrid;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    procedure CarregarGridRestaurar;
    procedure LimparCampos;
    procedure FormShow(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure RestaurarUsuarios;
    procedure DeletarUsuarios;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure PegarCamposGridUsuarios;
    procedure BtnEditarClick(Sender: TObject);
    procedure LblAtualizarClick(Sender: TObject);
    procedure EditarUsuarios;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    function ValidarCampos : Boolean;
    procedure EdtCPFClick(Sender: TObject);
    procedure CarregarGrupos;
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
  LimparCampos;
  PnlBackgroundEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
  PnlButtonEnviar.Visible := True;
  PnlButtonAtualizar.Visible := False;
end;


procedure TFormCadastroUsuarios.BtnCancelarClick(Sender: TObject);
begin
  PnlBackgroundEdit.Visible := False;
  PnlDesignEdit.Visible := False;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroUsuarios.BtnEditarClick(Sender: TObject);
begin
  PnlBackgroundEdit.Visible := true;
  PnlDesignEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridUsuarios;
end;

procedure TFormCadastroUsuarios.BtnExcluirClick(Sender: TObject);
begin
  DeletarUsuarios;
end;

procedure TFormCadastroUsuarios.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := false;
  PnlBackgroundEdit.Visible := false;
end;


procedure TFormCadastroUsuarios.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroUsuarios.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este Formulário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FormCadastroUsuarios.close;
  end;
end;

procedure TFormCadastroUsuarios.CarregarGrid;
var
  UsuarioService : TUsuarioService;
begin
UsuarioService := TUsuarioService.create;
DataSourceMain.DataSet :=  UsuarioService.ListarUsuarios;
DBGridMain.DataSource := DataSourceMain;
   try
      if DBGridMain.Columns.Count >= 5 then
    begin
      DBGridMain.Columns[0].Title.Caption := 'Id';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'Grupo';
      DBGridMain.Columns[4].Title.Caption := 'Ativo';

      DBGridMain.Columns[0].Title.Alignment := taCenter;
      DBGridMain.Columns[0].Alignment := taCenter;
      DBGridMain.Columns[1].Title.Alignment := taCenter;
      DBGridMain.Columns[1].Alignment := taCenter;
      DBGridMain.Columns[2].Title.Alignment := taCenter;
      DBGridMain.Columns[2].Alignment := taCenter;
      DBGridMain.Columns[3].Title.Alignment := taCenter;
      DBGridMain.Columns[3].Alignment := taCenter;
      DBGridMain.Columns[4].Title.Alignment := taCenter;
      DBGridMain.Columns[4].Alignment := taCenter;

      DBGridMain.Columns[0].Width := 100;
      DBGridMain.Columns[1].Width := 191;
      DBGridMain.Columns[2].Width := 191;
      DBGridMain.Columns[3].Width := 191;
      DBGridMain.Columns[4].Width := 191;
    end;
   finally
    UsuarioService.Free;
   end;
end;

 procedure TFormCadastroUsuarios.RestaurarUsuarios;
  var
  Controller : TUsuarioController;
  IdUsuario: Integer;
begin
  if DataSourceRestaurar.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;
  IdUsuario := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;

  if MessageDlg('Deseja realmente Restaurar este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TUsuarioController.Create;
      Controller.RestaurarUsuarios(IdUsuario);
    end;
  end;
procedure TFormCadastroUsuarios.PegarCamposGridUsuarios ;
begin
  EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
  EdtCPF.Text := DBGridMain.DataSource.DataSet.FieldByName('CPF').AsString;
  CmbGrupo.Text := DBGridMain.DataSource.DataSet.FieldByName('Grupo').AsString;
  if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then begin
  CmbStatus.ItemIndex := 0;
  CmbGrupo.ItemIndex := 0;
 end else begin
  CmbStatus.ItemIndex := 1;
  CmbGrupo.ItemIndex := 1;
end;
end;

procedure TFormCadastroUsuarios.CarregarGridRestaurar;
var
  UsuarioService : TUsuarioService;
begin
UsuarioService := TUsuarioService.create;
DataSourceRestaurar.DataSet :=  UsuarioService.ListarUsuariosRestaurar;
DBGridRestaurar.DataSource := DataSourceRestaurar;
  try
    if DBGridRestaurar.Columns.Count >= 5 then
    begin
      DBGridRestaurar.Columns[0].Title.Caption := 'Id';
      DBGridRestaurar.Columns[1].Title.Caption := 'Nome';
      DBGridRestaurar.Columns[2].Title.Caption := 'CPF';
      DBGridRestaurar.Columns[3].Title.Caption := 'Grupo';
      DBGridRestaurar.Columns[4].Title.Caption := 'Ativo';


      DBGridRestaurar.Columns[0].Alignment := taCenter;
      DBGridRestaurar.Columns[1].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[1].Alignment := taCenter;
      DBGridRestaurar.Columns[2].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[2].Alignment := taCenter;
      DBGridRestaurar.Columns[3].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[3].Alignment := taCenter;
      DBGridRestaurar.Columns[4].Title.Alignment := taCenter;
      DBGridRestaurar.Columns[4].Alignment := taCenter;

      DBGridRestaurar.Columns[0].Width := 147;
      DBGridRestaurar.Columns[1].Width := 147;
      DBGridRestaurar.Columns[2].Width := 150;
      DBGridRestaurar.Columns[3].Width := 147;
      DBGridRestaurar.Columns[4].Width := 147;
    end;
  finally
    UsuarioService.Free;
  end;

end;

procedure TFormCadastroUsuarios.CarregarGrupos;
var
  UsuarioController: TUsuarioController;
  ListaGrupos: TStringList;
  i: Integer;
begin
  CmbGrupo.Items.Clear;
  UsuarioController := TUsuarioController.Create;
  try
    ListaGrupos := UsuarioController.CarregarGrupos;
    try
      for i := 0 to ListaGrupos.Count - 1 do
        CmbGrupo.Items.AddObject(ListaGrupos[i], ListaGrupos.Objects[i]);
      CmbGrupo.ItemIndex := -1;
    finally
      ListaGrupos.Free;
    end;
  finally
    UsuarioController.Free;
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
  CarregarGrupos;
end;

procedure TFormCadastroUsuarios.ImgFecharClick(Sender: TObject);
begin
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroUsuarios.ImgRestaurarClick(Sender: TObject);
begin
  RestaurarUsuarios;
  CarregarGridRestaurar;
end;

procedure TFormCadastroUsuarios.LblAtualizarClick(Sender: TObject);
begin
if ValidarCampos = True then begin
  EditarUsuarios;
  CarregarGrid;
  ShowMessage('Deu boa');
end;
end;

procedure TFormCadastroUsuarios.LblEnviarClick(Sender: TObject);
var
  Controller: TUsuarioController;
  Usuario: TUsuario;
begin
  if ValidarCampos then begin
  Controller := TUsuarioController.Create;
  try
    Usuario := Controller.CriarObjeto(EdtNome.Text,EdtCPF.Text,EdtSenha.Text,CmbGrupo.text,CmbStatus.ItemIndex = 0);
  Controller.SalvarUsuario(Usuario);
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
  EdtConfirmarSenha.Clear;
  CmbGrupo.ItemIndex := -1;
  CmbStatus.ItemIndex := -1;
end;

function TFormCadastroUsuarios.ValidarCampos: Boolean;
var
  Controller: TUsuarioController;
  Usuario: TUsuario;
begin
  Result := False;

  if EdtNome.Text = '' then
  begin
    ShowMessage('O Campo de NOME não pode ficar Vazio');
    Exit;
  end;

  if EdtCPF.Text = '' then
  begin
    ShowMessage('O Campo de CPF não pode ficar Vazio');
    Exit;
  end;

  if (EdtSenha.Text <> '') and (EdtConfirmarSenha.Text <> '') then
  begin
    if EdtSenha.Text <> EdtConfirmarSenha.Text then
    begin
      ShowMessage('As Senhas não coincidem');
      Exit;
    end;
 if (EdtSenha.Text = '') and (EdtConfirmarSenha.Text = '') then
  begin
    try
      Controller := TUsuarioController.Create;
      Usuario := TUsuario.Create;
      Controller.EditarUsuarioComSenha(Usuario);
      CarregarGrid;
      LimparCampos;
    finally
      Controller.Free;
      Usuario.Free;
    end;
  end;
    Result := True;
    Exit;
  end;

  Result := True;
end;


procedure TFormCadastroUsuarios.DeletarUsuarios;
  var
  Controller : TUsuarioController;
  IdUsuario: Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;
  IdUsuario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

  if MessageDlg('Deseja realmente deletar este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TUsuarioController.Create;
      Controller.DeletarUsuarios(IdUsuario);
      CarregarGrid;
end;
end;

procedure TFormCadastroUsuarios.EditarUsuarios;
var
  Controller : TUsuarioController;
  Usuario : TUsuario;
  IdUsuario  : Integer;
begin
  if DataSourceMain.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;

  IdUsuario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

  Controller := TUsuarioController.Create;
  try
    Usuario := TUsuario.Create;
    try
      ValidarCampos;
      Usuario.SetId(IdUsuario);
      Usuario.SetNome(EdtNome.Text);
      Usuario.SetCPF(EdtCPF.Text);
      Usuario.setSenha(EdtSenha.text);
      Usuario.SetGrupo(CmbGrupo.Text);
      Usuario.setAtivo(CmbStatus.ItemIndex = 0);
      Controller.EditarUsuario(Usuario);
      CarregarGrid;
      LimparCampos;

    finally
      Usuario.Free;
    end;
  finally
    Controller.Free;
  end;
end;

procedure TFormCadastroUsuarios.EdtCPFClick(Sender: TObject);
begin
  EdtCPF.SelStart := 0;
end;

procedure TFormCadastroUsuarios.EdtPesquisarChange(Sender: TObject);
var
  Controller : TUsuarioController;
begin
  Controller := TUsuarioController.Create;
  Controller.PesquisarUsuarios(EdtPesquisar.Text);

      DBGridMain.Columns[0].Width := 140;
      DBGridMain.Columns[1].Width := 140;
      DBGridMain.Columns[2].Width := 140;
      DBGridMain.Columns[3].Width := 140;
      DBGridMain.Columns[4].Width := 140;
end;

end.
