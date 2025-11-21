unit uFormCadastroClientesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, ClienteCadastroService, ClienteCadastroController,
  uCliente;

type
  TFormCadastroClientes = class(TForm)
    DataSourceRestaurar: TDataSource;
    DataSourceClientes: TDataSource;
    PnlMain: TPanel;
    PnlContainer: TPanel;
    PnlMainButton: TPanel;
    PnlMainEdit: TPanel;
    PnlBackgrounEdit: TPanel;
    PnlDesignEdit: TPanel;
    PnlEdit: TPanel;
    LblNome: TLabel;
    LblEmail: TLabel;
    LblCPF: TLabel;
    LblTelefone: TLabel;
    LblNascimento: TLabel;
    LblStatus: TLabel;
    EdtNome: TEdit;
    EdtCPF: TMaskEdit;
    EdtEmail: TEdit;
    EdtDataNascimento: TMaskEdit;
    EdtTelefone: TMaskEdit;
    CmbStatus: TComboBox;
    PnlGrid: TPanel;
    DBGridMain: TDBGrid;
    PnlHeader: TPanel;
    EdtPesquisar: TSearchBox;
    PnlButtonCrud: TPanel;
    PnlBackgroundButton: TPanel;
    PnlButton: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAdicionar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnPesquisar: TSpeedButton;
    BtnRestaurar: TSpeedButton;
    BtnSair: TSpeedButton;
    BtnCancelar: TSpeedButton;
    Image1: TImage;
    Label1: TLabel;
    PnlRestaurar: TPanel;
    LblRestaurar: TLabel;
    ImgFechar: TImage;
    ImgRestaurar: TImage;
    PnlMainRestaurar: TPanel;
    PnlContainerRestaurar: TPanel;
    DBGridRestaurar: TDBGrid;
    PnlButtonForm: TPanel;
    ShpButton: TShape;
    PnlButtonAtualizar: TPanel;
    LblAtualizar: TLabel;
    Image2: TImage;
    PnlButtonEnviar: TPanel;
    LblEnviar: TLabel;
    Image6: TImage;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LblEnviarClick(Sender: TObject);
    procedure CarregarGrid;
    Function ValidarCampos: Boolean;
    procedure LimparCampos;
    procedure FormShow(Sender: TObject);
    procedure EditarClientes;
    procedure LblAtualizarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure PegarCamposGridClientes;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure RestaurarUsuarios;
    procedure CarregarGridRestaurar;
    procedure ImgRestaurarClick(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtCPFClick(Sender: TObject);
    procedure EdtTelefoneClick(Sender: TObject);
    procedure EdtDataNascimentoClick(Sender: TObject);
    procedure ExcluirUsuarios;
    procedure CadastrarClientes;
    Function ValidarData: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroClientes: TFormCadastroClientes;

implementation

{$R *.dfm}

procedure TFormCadastroClientes.BtnAdicionarClick(Sender: TObject);
begin
  LimparCampos;
  PnlButtonEnviar.Visible := True;
  PnlBackgrounEdit.Visible := True;
  PnlDesignEdit.Visible := True;
  EdtPesquisar.Visible := False;
end;

procedure TFormCadastroClientes.BtnCancelarClick(Sender: TObject);
begin
  PnlDesignEdit.Visible := False;
  EdtPesquisar.Visible := False;
  PnlBackgrounEdit.Visible := False;
  PnlRestaurar.Visible := False;
  CarregarGrid;
end;

procedure TFormCadastroClientes.BtnEditarClick(Sender: TObject);
begin
  PnlDesignEdit.Visible := True;
  PnlButtonAtualizar.Visible := True;
  PnlButtonEnviar.Visible := False;
  PegarCamposGridClientes;
end;

procedure TFormCadastroClientes.BtnExcluirClick(Sender: TObject);
begin
  ExcluirUsuarios;
end;

procedure TFormCadastroClientes.ExcluirUsuarios;
var
  ClienteController: TClienteController;
  IdUsuario: Integer;
begin
  if DataSourceClientes.DataSet.IsEmpty then begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;
  IdUsuario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

  if MessageDlg('Deseja realmente deletar este usuário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    ClienteController := TClienteController.Create;
    ClienteController.DeletarClientes(IdUsuario);
    CarregarGrid;
  end;
end;

procedure TFormCadastroClientes.BtnPesquisarClick(Sender: TObject);
begin
  EdtPesquisar.Visible := True;
  PnlDesignEdit.Visible := False;
  PnlBackgrounEdit.Visible := False;
end;

procedure TFormCadastroClientes.BtnRestaurarClick(Sender: TObject);
begin
  PnlRestaurar.Visible := True;
  CarregarGridRestaurar;
end;

procedure TFormCadastroClientes.BtnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar este Formulário?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    Close;
    PnlBackgrounEdit.Visible := False;
    PnlEdit.Visible := False;
    PnlRestaurar.Visible := False;
    EdtPesquisar.Visible := False;
  end;
end;

procedure TFormCadastroClientes.CarregarGrid;
var
  ClienteService: TClienteService;
begin
  ClienteService := TClienteService.Create;
  DataSourceClientes.DataSet := ClienteService.ListarClientes;
  DBGridMain.DataSource := DataSourceClientes;
  try
    if DBGridMain.Columns.Count >= 7 then begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'Email';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'Nascimento';
      DBGridMain.Columns[6].Title.Caption := 'Ativo';

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
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;
      DBGridMain.Columns[6].Title.Alignment := taCenter;
      DBGridMain.Columns[6].Alignment := taCenter;

      DBGridMain.Columns[0].Width := 50;
      DBGridMain.Columns[1].Width := 100;
      DBGridMain.Columns[2].Width := 160;
      DBGridMain.Columns[3].Width := 160;
      DBGridMain.Columns[4].Width := 160;
      DBGridMain.Columns[5].Width := 180;
      DBGridMain.Columns[6].Width := 50;
    end;
  finally
    ClienteService.Free;
  end;
end;

procedure TFormCadastroClientes.CadastrarClientes;
var
  ClienteController: TClienteController;
  Cliente: TCliente;
begin
  ClienteController := TClienteController.Create;
  try
    Cliente := ClienteController.CriarObjeto(EdtNome.Text, EdtCPF.Text,
      EdtEmail.Text, EdtTelefone.Text, EdtDataNascimento.Text,
      CmbStatus.ItemIndex = 0);
    ClienteController.SalvarClientes(Cliente);
  finally
    ClienteController.Free;
  end;
end;

procedure TFormCadastroClientes.CarregarGridRestaurar;
var
  ClienteService: TClienteService;
begin
  ClienteService := TClienteService.Create;
  DataSourceRestaurar.DataSet := ClienteService.ListarClientesRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
  try
    if DBGridRestaurar.Columns.Count >= 7 then begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'Email';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'Nascimento';
      DBGridMain.Columns[6].Title.Caption := 'Ativo';

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
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;
      DBGridMain.Columns[6].Title.Alignment := taCenter;
      DBGridMain.Columns[6].Alignment := taCenter;

      DBGridMain.Columns[0].Width := 50;
      DBGridMain.Columns[1].Width := 160;
      DBGridMain.Columns[2].Width := 160;
      DBGridMain.Columns[3].Width := 160;
      DBGridMain.Columns[4].Width := 160;
      DBGridMain.Columns[5].Width := 160;
      DBGridMain.Columns[6].Width := 50;
    end;
  finally
    ClienteService.Free;
  end;
end;

procedure TFormCadastroClientes.EditarClientes;
var
  ClienteController: TClienteController;
  Cliente: TCliente;
  IdCliente: Integer;
begin
  if DataSourceClientes.DataSet.IsEmpty then begin
    ShowMessage('Nenhum usuário selecionado!');
    Exit;
  end;

  IdCliente := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

  ClienteController := TClienteController.Create;
  try
    Cliente := TCliente.Create;
    try
      ValidarCampos;
      Cliente.setIdCliente(IdCliente);
      Cliente.SetNome(EdtNome.Text);
      Cliente.SetCPF(EdtCPF.Text);
      Cliente.SetEmail(EdtEmail.Text);
      Cliente.SetTelefone(EdtTelefone.Text);
      Cliente.SetNascimento(EdtDataNascimento.Text);
      Cliente.setAtivo(CmbStatus.ItemIndex = 0);
      ClienteController.EditarClientes(Cliente);
      CarregarGrid;
      LimparCampos;
    finally
      Cliente.Free;
    end;
  finally
    ClienteController.Free;
  end;
end;

procedure TFormCadastroClientes.EdtCPFClick(Sender: TObject);
begin
  EdtCPF.SelStart := 0;
end;

procedure TFormCadastroClientes.EdtDataNascimentoClick(Sender: TObject);
begin
  EdtDataNascimento.SelStart := 0;
end;

procedure TFormCadastroClientes.EdtPesquisarChange(Sender: TObject);
var
  Controller: TClienteController;
begin
  Controller := TClienteController.Create;
  try
    DataSourceClientes.DataSet := Controller.PesquisarClientes
      (EdtPesquisar.Text);
    if DBGridMain.Columns.Count >= 7 then begin
      DBGridMain.Columns[0].Title.Caption := 'ID';
      DBGridMain.Columns[1].Title.Caption := 'Nome';
      DBGridMain.Columns[2].Title.Caption := 'CPF';
      DBGridMain.Columns[3].Title.Caption := 'Email';
      DBGridMain.Columns[4].Title.Caption := 'Telefone';
      DBGridMain.Columns[5].Title.Caption := 'Nascimento';
      DBGridMain.Columns[6].Title.Caption := 'Ativo';

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
      DBGridMain.Columns[5].Title.Alignment := taCenter;
      DBGridMain.Columns[5].Alignment := taCenter;
      DBGridMain.Columns[6].Title.Alignment := taCenter;
      DBGridMain.Columns[6].Alignment := taCenter;

      DBGridMain.Columns[0].Width := 50;
      DBGridMain.Columns[1].Width := 160;
      DBGridMain.Columns[2].Width := 160;
      DBGridMain.Columns[3].Width := 160;
      DBGridMain.Columns[4].Width := 160;
      DBGridMain.Columns[5].Width := 160;
      DBGridMain.Columns[6].Width := 50;
    end;
    finally
      Controller.Free
    end;
  end;

  procedure TFormCadastroClientes.EdtTelefoneClick(Sender: TObject);
  begin
    EdtTelefone.SelStart := 0;
  end;

  procedure TFormCadastroClientes.FormCreate(Sender: TObject);
  begin
    EdtNome.Height := 31;
    EdtEmail.Height := 31;
    EdtCPF.Height := 31;
    EdtTelefone.Height := 31;
    EdtDataNascimento.Height := 31;
    CmbStatus.Font.Size := 13;
  end;

  procedure TFormCadastroClientes.FormShow(Sender: TObject);
  begin
    CarregarGrid;
  end;

  procedure TFormCadastroClientes.ImgFecharClick(Sender: TObject);
  begin
    PnlRestaurar.Visible := False;
    CarregarGrid;
  end;

  procedure TFormCadastroClientes.ImgRestaurarClick(Sender: TObject);
  begin
    RestaurarUsuarios;
    CarregarGridRestaurar;
  end;

  procedure TFormCadastroClientes.LblAtualizarClick(Sender: TObject);
  begin
    if (ValidarCampos and ValidarData) then begin
      EditarClientes;
      CarregarGrid;
    end;
  end;

  procedure TFormCadastroClientes.LblEnviarClick(Sender: TObject);
  begin
    if (ValidarCampos and ValidarData) then begin
      CadastrarClientes;
      LimparCampos;
      CarregarGrid;
      ShowMessage('Cliente cadastrado com sucesso!');
    end;
  end;

  procedure TFormCadastroClientes.LimparCampos;
  begin
    EdtNome.Clear;
    EdtCPF.Clear;
    EdtEmail.Clear;
    EdtDataNascimento.Clear;
    EdtTelefone.Clear;
    CmbStatus.ItemIndex := -1;
  end;

  procedure TFormCadastroClientes.PegarCamposGridClientes;
  begin
    EdtTelefone.Clear;
    CmbStatus.ItemIndex := -1;
    EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
    EdtCPF.Text := DBGridMain.DataSource.DataSet.FieldByName('CPF').AsString;
    EdtEmail.Text := DBGridMain.DataSource.DataSet.FieldByName('email').AsString;
    EdtTelefone.Text := DBGridMain.DataSource.DataSet.FieldByName('Telefone').AsString;
    EdtDataNascimento.Text := DBGridMain.DataSource.DataSet.FieldByName('Nascimento').AsString;
    if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then begin
      CmbStatus.ItemIndex := 0;
    end else begin
      CmbStatus.ItemIndex := 1;
    end;
  end;

  procedure TFormCadastroClientes.RestaurarUsuarios;
  var
    ClienteController: TClienteController;
    IdUsuario: Integer;
  begin
    if DataSourceRestaurar.DataSet.IsEmpty then begin
      ShowMessage('Nenhum usuário selecionado!');
      Exit;
    end;
    IdUsuario := DBGridRestaurar.DataSource.DataSet.FieldByName('id').AsInteger;

    if MessageDlg('Deseja realmente Restaurar este usuário?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then begin
      ClienteController := TClienteController.Create;
      ClienteController.RestaurarClientes(IdUsuario);
    end;

  end;

  function TFormCadastroClientes.ValidarCampos: Boolean;
  begin
    if EdtNome.Text = '' then begin
      ShowMessage('O Campo de NOME não pode ficar Vazio');
      Exit;
    end;

    if EdtCPF.Text = '' then begin
      ShowMessage('O Campo de CPF não pode ficar Vazio');
      Exit;
    end;
    if EdtEmail.Text = '' then begin
      ShowMessage('O Campo de EMAIL não pode ficar Vazio');
      Exit;
    end;
    if EdtDataNascimento.Text = '' then begin
      ShowMessage('O Campo de DATA não pode ficar Vazio');
      Exit;
    end;
    if EdtTelefone.Text = '' then begin
      ShowMessage('O Campo de TELEFONE não pode ficar Vazio');
      Exit;
    end;
    if CmbStatus.ItemIndex = -1 then begin
      ShowMessage('Selecione o STATUS');
      Exit;
    end;
    Result := True;
  end;

  Function TFormCadastroClientes.ValidarData: Boolean;
  var
    dia, mes, ano: Integer;
    dataValida: Boolean;
  begin
    if Length(EdtDataNascimento.Text) = 10 then begin
      dia := StrToInt(Copy(EdtDataNascimento.Text, 1, 2));
      mes := StrToInt(Copy(EdtDataNascimento.Text, 4, 2));
      ano := StrToInt(Copy(EdtDataNascimento.Text, 7, 4));

      dataValida := (dia >= 1) and (dia <= 31) and (mes >= 1) and (mes <= 12)
        and (ano > 1900) and (ano < 2100);

      if not dataValida then begin
        ShowMessage('Data inválida!');
        EdtDataNascimento.SetFocus;
        Result := False;
        Exit;
      end;
      Result := True;
    end;
  end;

end.
