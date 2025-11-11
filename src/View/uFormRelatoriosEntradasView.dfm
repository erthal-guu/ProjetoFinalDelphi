object FormEntradas: TFormEntradas
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormEntradas'
  ClientHeight = 541
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
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
    object LblTituloEntradas: TLabel
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
      ExplicitWidth = 99
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
    object LblTotalHead: TLabel
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
    object LblTotal: TLabel
      Left = 807
      Top = 113
      Width = 102
      Height = 40
      Caption = '2500,00'
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
    object LblQuantidadeHead: TLabel
      Left = 766
      Top = 255
      Width = 183
      Height = 21
      Caption = 'Quantidade de Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblQuantidade: TLabel
      Left = 849
      Top = 282
      Width = 16
      Height = 40
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object LblTickMedioHead: TLabel
      Left = 806
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
    object LblTickMedio: TLabel
      Left = 807
      Top = 445
      Width = 102
      Height = 40
      Caption = '1000,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object ImgFecharEntradas: TImage
      Left = 936
      Top = 20
      Width = 25
      Height = 25
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
        00180806000000E0773DF8000000097048597300000EC300000EC301C76FA864
        0000001974455874536F667477617265007777772E696E6B73636170652E6F72
        679BEE3C1A0000010F4944415478DAC5964D0AC2301085675C783A050F20F80B
        820BC55308228A4871E10F75E752F05EAE7551F5854688A549A6A962E0D13493
        BCAF69324DF9493423A231B485464CF4A012057E155CD6501F5A301AEEA85475
        FC08754321DAFC00B574D34D0122548646BF20488EB92A115B0227A8094852C2
        FCEDE1ED9094304F58DA31C45CDD706680BADF40031FC4621E433D73FD3E0052
        88D43C17E083A46199B915603CE51E6A1BCD173DA6263177021C33318BD3DC0B
        30667286EA99909A4DC39790FF0558768B59BCC918B2C894994D4C4517D9B5CF
        D3B02C19730192242A92F15CD4DCE82B82F83E76CEF72B8170A8B914C265CC45
        901F1F99CB5F1FFA570598A2328176F4BDDF9615D481E62FF3919E24F9015515
        0000000049454E44AE426082}
      OnClick = ImgFecharEntradasClick
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
