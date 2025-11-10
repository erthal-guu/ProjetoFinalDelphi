object FormEntradas: TFormEntradas
  Left = 0
  Top = 0
  Caption = 'FormEntradas'
  ClientHeight = 545
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PnlRestaurar: TPanel
    AlignWithMargins = True
    Left = -9
    Top = 3
    Width = 980
    Height = 537
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = 6172416
    ParentBackground = False
    TabOrder = 0
    Visible = False
    object LblRestaurar: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 20
      Width = 974
      Height = 32
      Margins.Top = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 6
      ExplicitTop = 26
    end
    object Shape3: TShape
      AlignWithMargins = True
      Left = 752
      Top = 80
      Width = 209
      Height = 89
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Brush.Color = 9521152
      Pen.Color = clHighlight
      Shape = stRoundRect
    end
    object Label5: TLabel
      Left = 794
      Top = 89
      Width = 131
      Height = 21
      Caption = 'Total de Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 794
      Top = 115
      Width = 131
      Height = 40
      Caption = '25.500,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Shape4: TShape
      AlignWithMargins = True
      Left = 751
      Top = 241
      Width = 209
      Height = 98
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Brush.Color = 9521152
      Pen.Color = clHighlight
      Shape = stRoundRect
    end
    object Shape5: TShape
      AlignWithMargins = True
      Left = 752
      Top = 405
      Width = 209
      Height = 98
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Brush.Color = 9521152
      Pen.Color = clHighlight
      Shape = stRoundRect
    end
    object Label7: TLabel
      Left = 766
      Top = 255
      Width = 185
      Height = 21
      Caption = 'Quantidade de Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 838
      Top = 287
      Width = 46
      Height = 40
      Caption = ' 10'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 807
      Top = 418
      Width = 103
      Height = 21
      Caption = 'Ticket M'#233'dio '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 814
      Top = 445
      Width = 86
      Height = 40
      Caption = '886,90'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object PnlMainRestaurar: TPanel
      AlignWithMargins = True
      Left = 21
      Top = 80
      Width = 277
      Height = 423
      Margins.Left = 20
      Margins.Right = 20
      Margins.Bottom = 20
      BevelOuter = bvNone
      Color = 9521152
      ParentBackground = False
      TabOrder = 0
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 20
        Top = 20
        Width = 237
        Height = 383
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        ParentBackground = False
        TabOrder = 0
        object LblTitulo: TLabel
          Left = 81
          Top = 15
          Width = 81
          Height = 37
          Caption = 'Filtros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 10
          Top = 188
          Width = 57
          Height = 15
          Caption = 'Categoria :'
        end
        object Label2: TLabel
          Left = 10
          Top = 129
          Width = 58
          Height = 15
          Caption = 'Data Final :'
        end
        object Label3: TLabel
          Left = 10
          Top = 75
          Width = 62
          Height = 15
          Caption = 'Data In'#237'cio :'
        end
        object EdtDataInicio: TDateTimePicker
          Left = 10
          Top = 90
          Width = 215
          Height = 23
          Date = 45971.000000000000000000
          Time = 0.661488715275481800
          TabOrder = 0
        end
        object CmbRelatorios: TComboBox
          Left = 10
          Top = 204
          Width = 215
          Height = 23
          TabOrder = 2
        end
        object EdtDataFinal: TDateTimePicker
          Left = 10
          Top = 145
          Width = 215
          Height = 23
          Date = 45971.000000000000000000
          Time = 0.661488715275481800
          TabOrder = 3
        end
        object Panel2: TPanel
          Left = 10
          Top = 246
          Width = 215
          Height = 44
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 1
          object Shape2: TShape
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 215
            Height = 44
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Brush.Color = 9521152
            Pen.Color = clSilver
            Shape = stRoundRect
            ExplicitTop = 8
            ExplicitWidth = 207
          end
          object PnlAdicionar: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 205
            Height = 34
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            BevelOuter = bvNone
            Color = 9521152
            ParentBackground = False
            TabOrder = 0
            object LblAdicionar: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 6
              Width = 199
              Height = 25
              Margins.Top = 6
              Align = alClient
              Alignment = taCenter
              Caption = 'Gerar Relat'#243'rio'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 101
              ExplicitHeight = 20
            end
          end
        end
        object Panel3: TPanel
          Left = 32
          Top = 305
          Width = 177
          Height = 36
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 4
          object Shape1: TShape
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 177
            Height = 36
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Brush.Color = 6172416
            Pen.Color = clSilver
            Shape = stRoundRect
            ExplicitTop = -8
            ExplicitHeight = 44
          end
          object Panel4: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 167
            Height = 26
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            BevelOuter = bvNone
            Color = 6172416
            ParentBackground = False
            TabOrder = 0
            object Label4: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 161
              Height = 20
              Align = alClient
              Alignment = taCenter
              Caption = 'Limpar Filtros'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 90
            end
          end
        end
      end
    end
    object PnlGraficoPecasUsadas: TPanel
      Left = 320
      Top = 80
      Width = 417
      Height = 201
      Caption = 'PnlGraficoPecasUsadas'
      TabOrder = 1
      object GraficoPeçasUsadas: TChart
        Left = 1
        Top = 1
        Width = 415
        Height = 199
        Title.Text.Strings = (
          'TChart')
        View3D = False
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 192
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          HoverElement = []
          SeriesColor = 8404992
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          Data = {
            000600000000000000002062400000000000A069400000000000387340000000
            0000C8744000000000006073400000000000306B40}
          Detail = {0000000000}
        end
      end
    end
    object PnlGraficoEntradasMes: TPanel
      Left = 321
      Top = 304
      Width = 416
      Height = 199
      Caption = 'Panel5'
      TabOrder = 2
      object GraficoEntradasMes: TChart
        Left = 1
        Top = 1
        Width = 414
        Height = 197
        Title.Text.Strings = (
          'TChart')
        View3D = False
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 7
        ExplicitHeight = 206
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series2: TAreaSeries
          HoverElement = [heCurrent]
          SeriesColor = 8404992
          AreaChartBrush.Color = clGray
          AreaChartBrush.BackColor = clDefault
          DrawArea = True
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
end
