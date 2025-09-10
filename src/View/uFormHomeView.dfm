object FormHome: TFormHome
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormHome'
  ClientHeight = 692
  ClientWidth = 1122
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  TextHeight = 15
  object PnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1122
    Height = 692
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object PgCntrl: TPageControl
      Left = 0
      Top = 0
      Width = 192
      Height = 280
      ActivePage = TabSheet1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Cadastros'
        ImageIndex = 1
        object PnlMenu: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 250
          Align = alLeft
          TabOrder = 0
          object PnlServiços: TPanel
            Left = 1
            Top = 206
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Servi'#231'os'
            TabOrder = 0
            OnClick = PnlServiçosClick
          end
          object PnlPeças: TPanel
            Left = 1
            Top = 165
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Pe'#231'as'
            TabOrder = 1
            OnClick = PnlPeçasClick
          end
          object PnlFornecedores: TPanel
            Left = 1
            Top = 124
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Fornecedores'
            TabOrder = 2
            OnClick = PnlFornecedoresClick
          end
          object PnlFuncionarios: TPanel
            Left = 1
            Top = 83
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Funcionarios'
            TabOrder = 3
            OnClick = PnlFuncionariosClick
          end
          object PnlClientes: TPanel
            Left = 1
            Top = 42
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Clientes'
            TabOrder = 4
            OnClick = PnlClientesClick
          end
          object PnlUsuarios: TPanel
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 183
            Height = 41
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Usuarios'
            TabOrder = 5
            OnClick = PnlUsuariosClick
          end
        end
      end
    end
  end
end
