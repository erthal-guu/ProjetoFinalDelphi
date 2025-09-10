object FormHome: TFormHome
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormHome'
  ClientHeight = 672
  ClientWidth = 1122
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1122
    Height = 672
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 192
      Height = 280
      ActivePage = Cadastros
      TabOrder = 0
      object Cadastros: TTabSheet
        Caption = 'Cadastros'
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 250
          Align = alLeft
          TabOrder = 0
          ExplicitLeft = 464
          ExplicitHeight = 41
          object Panel3: TPanel
            Left = 1
            Top = 206
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Servi'#231'os'
            TabOrder = 0
            ExplicitLeft = 8
            ExplicitTop = 8
            ExplicitWidth = 185
          end
          object Panel4: TPanel
            Left = 1
            Top = 165
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Pe'#231'as'
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = 9
          end
          object Panel5: TPanel
            Left = 1
            Top = 124
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Fornecedores'
            TabOrder = 2
            ExplicitLeft = 2
            ExplicitTop = 9
          end
          object Panel6: TPanel
            Left = 1
            Top = 83
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Funcionarios'
            TabOrder = 3
            ExplicitLeft = -2
            ExplicitTop = 87
          end
          object Panel7: TPanel
            Left = 1
            Top = 42
            Width = 183
            Height = 41
            Align = alTop
            Caption = 'Clientes'
            TabOrder = 4
            ExplicitTop = 36
          end
          object Panel8: TPanel
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
            ExplicitTop = -2
          end
        end
      end
    end
  end
end
