  unit uFormCadastroClientesView;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.Grids,
    Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls, Vcl.Imaging.pngimage,
    Vcl.ExtCtrls, Vcl.ComCtrls,ClienteCadastroService,ClienteCadastroController,uClienteDTO;

  type
    TFormCadastroClientes = class(TForm)
      PageControl1: TPageControl;
      Clientes: TTabSheet;
      PnlMain: TPanel;
      PnlContainer: TPanel;
      PnlMainButton: TPanel;
      PnlMainEdit: TPanel;
      PnlBackgrounEdit: TPanel;
      PnlDesignEdit: TPanel;
      Image1: TImage;
      PnlEdit: TPanel;
      LblNome: TLabel;
      LblEmail: TLabel;
      LblCPF: TLabel;
      LblTelefone: TLabel;
      LblNascimento: TLabel;
      EdtNome: TEdit;
      EdtCPF: TMaskEdit;
      EdtEmail: TEdit;
      EdtDataNascimento: TMaskEdit;
      EdtTelefone: TMaskEdit;
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
      PnlHeader: TPanel;
      EdtPesquisar: TSearchBox;
      PnlRestaurar: TPanel;
      LblRestaurar: TLabel;
      ImgFechar: TImage;
      ImgRestaurar: TImage;
      PnlMainRestaurar: TPanel;
      PnlContainerRestaurar: TPanel;
      DBGridRestaurar: TDBGrid;
      EdtEndereço: TEdit;
      LblEndereço: TLabel;
      CmbStatus: TComboBox;
      LblStatus: TLabel;
      DataSourceRestaurar: TDataSource;
      DataSourceClientes: TDataSource;
      PnlButtonEnviar: TPanel;
      LblEnviar: TLabel;
      PnlButtonAtualizar: TPanel;
      LblAtualizar: TLabel;
      procedure BtnAdicionarClick(Sender: TObject);
      procedure BtnPesquisarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure LblEnviarClick(Sender: TObject);
      procedure CarregarGrid;
      Function ValidarCampos:Boolean;
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
    PnlBackgrounEdit.Visible := True;
    PnlDesignEdit.Visible := True;
    EdtPesquisar.Visible := False;
  end;

  procedure TFormCadastroClientes.BtnEditarClick(Sender: TObject);
  begin
    PnlDesignEdit.Visible := True;
    PnlButtonAtualizar.Visible := True;
    PnlButtonEnviar.Visible := False;
    PegarCamposGridClientes;
  end;

  procedure TFormCadastroClientes.BtnExcluirClick(Sender: TObject);
    var
    ClienteController : TClienteController;
    IdUsuario: Integer;
  begin
    if DataSourceClientes.DataSet.IsEmpty then
    begin
      ShowMessage('Nenhum usuário selecionado!');
      Exit;
    end;
    IdUsuario := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

    if MessageDlg('Deseja realmente deletar este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ClienteController := TClienteController.Create;
        ClienteController.DeletarUsuarios(IdUsuario);
        CarregarGrid;
  end;
  end;

  procedure TFormCadastroClientes.BtnPesquisarClick(Sender: TObject);
  begin
    EdtPesquisar.Visible := True;
    PnlDesignEdit.Visible := false;
    PnlBackgrounEdit.Visible := false;
  end;

  procedure TFormCadastroClientes.BtnRestaurarClick(Sender: TObject);
  begin
    PnlRestaurar.Visible := True;
    CarregarGridRestaurar;
  end;

  procedure TFormCadastroClientes.CarregarGrid;
  var
    ClienteService : TClienteService;
  begin
    ClienteService := TClienteService.create;
    DataSourceClientes.DataSet :=  ClienteService.ListarClientes;
    DBGridMain.DataSource := DataSourceClientes;
     try
        if DBGridMain.Columns.Count >= 8 then
      begin
        DBGridMain.Columns[0].Title.Caption := 'Id';
        DBGridMain.Columns[1].Title.Caption := 'Nome';
        DBGridMain.Columns[2].Title.Caption := 'CPF';
        DBGridMain.Columns[3].Title.Caption := 'Email';
        DBGridMain.Columns[4].Title.Caption := 'Telefone';
        DBGridMain.Columns[5].Title.Caption := 'Nascimento';
        DBGridMain.Columns[6].Title.Caption := 'Endereço';
        DBGridMain.Columns[7].Title.Caption := 'Ativo';

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
        DBGridMain.Columns[7].Title.Alignment := taCenter;
        DBGridMain.Columns[7].Alignment := taCenter;

        DBGridMain.Columns[0].Width := 50;
        DBGridMain.Columns[1].Width := 160;
        DBGridMain.Columns[2].Width := 160;
        DBGridMain.Columns[3].Width := 160;
        DBGridMain.Columns[4].Width := 160;
        DBGridMain.Columns[5].Width := 160;
        DBGridMain.Columns[6].Width := 160;
        DBGridMain.Columns[7].Width := 50;
      end;
     finally
      ClienteService.Free;
     end;
  end;

  procedure TFormCadastroClientes.CarregarGridRestaurar;
  var
    ClienteService : TClienteService;
  begin
  ClienteService := TClienteService.create;
  DataSourceRestaurar.DataSet :=  ClienteService.ListarClientesRestaurar;
  DBGridRestaurar.DataSource := DataSourceRestaurar;
    try
      if DBGridRestaurar.Columns.Count >= 5 then
      begin
        DBGridMain.Columns[0].Title.Caption := 'Id';
        DBGridMain.Columns[1].Title.Caption := 'Nome';
        DBGridMain.Columns[2].Title.Caption := 'CPF';
        DBGridMain.Columns[3].Title.Caption := 'Email';
        DBGridMain.Columns[4].Title.Caption := 'Telefone';
        DBGridMain.Columns[5].Title.Caption := 'Nascimento';
        DBGridMain.Columns[6].Title.Caption := 'Endereço';
        DBGridMain.Columns[7].Title.Caption := 'Ativo';

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
        DBGridMain.Columns[7].Title.Alignment := taCenter;
        DBGridMain.Columns[7].Alignment := taCenter;

        DBGridMain.Columns[0].Width := 50;
        DBGridMain.Columns[1].Width := 160;
        DBGridMain.Columns[2].Width := 160;
        DBGridMain.Columns[3].Width := 160;
        DBGridMain.Columns[4].Width := 160;
        DBGridMain.Columns[5].Width := 160;
        DBGridMain.Columns[6].Width := 160;
        DBGridMain.Columns[7].Width := 50;
      end;
    finally
      ClienteService.Free;
    end;
  end;

  procedure TFormCadastroClientes.EditarClientes;
  var
    ClienteController : TClienteController;
    ClienteDTO : TClienteDTO;
    IdCliente  : Integer;
  begin
    if DataSourceClientes.DataSet.IsEmpty then
    begin
      ShowMessage('Nenhum usuário selecionado!');
      Exit;
    end;

    IdCliente := DBGridMain.DataSource.DataSet.FieldByName('id').AsInteger;

    ClienteController := TClienteController.Create;
    try
      ClienteDTO := TClienteDTO.Create;
      try
        ValidarCampos;
        ClienteDTO.setIdCliente(IdCliente);
        ClienteDTO.SetNome(EdtNome.Text);
        ClienteDTO.SetCPF(EdtCPF.Text);
        ClienteDTO.SetEmail(EdtEmail.Text);
        ClienteDTO.SetTelefone(EdtTelefone.Text);
        ClienteDTO.SetNascimento(EdtDataNascimento.Text);
        ClienteDTO.SetEndereco(EdtEndereço.Text);
        ClienteDTO.setAtivo(CmbStatus.ItemIndex = 0);
        ClienteController.EditarUsuario(ClienteDTO);
        CarregarGrid;
        LimparCampos;
      finally
        ClienteDTO.Free;
      end;
    finally
      ClienteController.Free;
    end;
  end;
  procedure TFormCadastroClientes.EdtPesquisarChange(Sender: TObject);
var
  ClienteService : TClienteService;
begin
  ClienteService := TClienteService.Create;
  try
    DataSourceClientes.DataSet := ClienteService.PesquisarClientes(EdtPesquisar.Text);
        DBGridMain.Columns[0].Width := 50;
        DBGridMain.Columns[1].Width := 160;
        DBGridMain.Columns[2].Width := 160;
        DBGridMain.Columns[3].Width := 160;
        DBGridMain.Columns[4].Width := 160;
        DBGridMain.Columns[5].Width := 160;
        DBGridMain.Columns[6].Width := 160;
        DBGridMain.Columns[7].Width := 50;
  finally
    ClienteService.Free;
  end;
end;

  procedure TFormCadastroClientes.FormCreate(Sender: TObject);
  begin
    EdtNome.Height := 31;
    EdtEmail.Height := 31;
    EdtCPF.Height := 31;
    EdtTelefone.Height := 31;
    EdtDataNascimento.Height := 31;
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
  if ValidarCampos then begin
    EditarClientes;
    CarregarGrid;
  end;
  end;

  procedure TFormCadastroClientes.LblEnviarClick(Sender: TObject);
  var
    ClienteController: TClienteController;
    ClienteDTO: TClienteDTO;
  begin
    if ValidarCampos then begin
    ClienteController := TClienteController.Create;
    try
      ClienteDTO := ClienteController.CriarObjeto(EdtNome.Text,EdtCPF.Text,EdtEmail.Text,EdtTelefone.Text,EdtDataNascimento.Text,EdtEndereço.Text,CmbStatus.ItemIndex = 0);
    ClienteController.SalvarUsuario(ClienteDTO);
    LimparCampos;
    CarregarGrid;
    finally
      ClienteController.Free;
    end;
    end;
  end;
  procedure TFormCadastroClientes.LimparCampos;
  begin
    EdtNome.Clear;
    EdtCPF.Clear;
    EdtEmail.Clear;
    EdtDataNascimento.Clear;
    EdtTelefone.Clear;
    EdtEndereço.Clear;
    CmbStatus.ItemIndex := -1;
  end;

  procedure TFormCadastroClientes.PegarCamposGridClientes;
  begin
    EdtTelefone.Clear;
    EdtEndereço.Clear;
    CmbStatus.ItemIndex := -1;
    EdtNome.Text := DBGridMain.DataSource.DataSet.FieldByName('nome').AsString;
    EdtCPF.Text := DBGridMain.DataSource.DataSet.FieldByName('CPF').AsString;
    EdtEmail.Text := DBGridMain.DataSource.DataSet.FieldByName('email').AsString;
    EdtTelefone.Text := DBGridMain.DataSource.DataSet.FieldByName('Telefone').AsString;
    EdtDataNascimento.Text := DBGridMain.DataSource.DataSet.FieldByName('Nascimento').AsString;
    EdtEndereço.Text := DBGridMain.DataSource.DataSet.FieldByName('endereco').AsString;
    if DBGridMain.DataSource.DataSet.FieldByName('ativo').AsBoolean then begin
    CmbStatus.ItemIndex := 0;
   end else begin
    CmbStatus.ItemIndex := 1;
  end;
  end;

  procedure TFormCadastroClientes.RestaurarUsuarios;
    var
    ClienteController : TClienteController;
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
      ClienteController := TClienteController.Create;
        ClienteController.RestaurarUsuarios(IdUsuario);
      end;

  end;

  function TFormCadastroClientes.ValidarCampos: Boolean;
  begin
    if EdtNome.Text = '' then begin
      ShowMessage('O Campo de NOME não pode ficar Vazio');
      exit;
    end;

    if EdtCPF.Text = '' then begin
      ShowMessage('O Campo de CPF não pode ficar Vazio');
      exit;
    end;
      if EdtEmail.Text = '' then begin
      ShowMessage('O Campo de EMAIL não pode ficar Vazio');
      exit;
    end;
      if EdtDataNascimento.Text = '' then begin
      ShowMessage('O Campo de DATA não pode ficar Vazio');
      exit;
    end;
      if EdtTelefone.Text = '' then begin
      ShowMessage('O Campo de TELEFONE não pode ficar Vazio');
      exit;
    end;
      if EdtEndereço.Text = '' then begin
      ShowMessage('O Campo de ENDEREÇO não pode ficar Vazio');
      exit;
    end;
    Result := True;
  end;

  end.
