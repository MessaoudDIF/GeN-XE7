object OperacionForm: TOperacionForm
  Left = 321
  Top = 220
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Operacion'
  ClientHeight = 466
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 25
    Width = 792
    Height = 72
    Align = alTop
    BevelOuter = bvLowered
    Color = clBlack
    ParentBackground = False
    TabOrder = 1
    object Label40: TLabel
      Left = 28
      Top = 126
      Width = 60
      Height = 13
      Caption = 'Impresora:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 7
      Top = 23
      Width = 48
      Height = 13
      Caption = 'Contado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label29: TLabel
      Left = 417
      Top = 22
      Width = 44
      Height = 13
      Caption = 'Cheque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label30: TLabel
      Left = 420
      Top = 46
      Width = 41
      Height = 13
      Caption = 'Tarjeta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label32: TLabel
      Left = 591
      Top = 5
      Width = 15
      Height = 13
      Caption = 'N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label33: TLabel
      Left = 641
      Top = 5
      Width = 41
      Height = 13
      Caption = 'Detalle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label34: TLabel
      Left = 722
      Top = 5
      Width = 37
      Height = 13
      Caption = 'Vence'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label31: TLabel
      Left = 30
      Top = 46
      Width = 25
      Height = 13
      Caption = 'Otro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 171
      Top = 46
      Width = 48
      Height = 13
      Caption = 'Pagare?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 275
      Top = 46
      Width = 78
      Height = 13
      Caption = 'Presupuesto?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label7: TLabel
      Left = 6
      Top = 3
      Width = 49
      Height = 13
      Caption = 'REMITO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TipoRadioGroup: TRadioGroup
      Left = 819
      Top = 42
      Width = 137
      Height = 104
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Venta'
        'Presupuesto'
        'Financiaci'#243'n')
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 90
      Top = 126
      Width = 321
      Height = 21
      TabOrder = 1
    end
    object NroChequeEdit: TEdit
      Left = 570
      Top = 18
      Width = 49
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object NroTarjetaEdit: TEdit
      Left = 570
      Top = 42
      Width = 49
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object DetChequeEdit: TEdit
      Left = 618
      Top = 18
      Width = 84
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object DetTarjetaEdit: TEdit
      Left = 618
      Top = 42
      Width = 165
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object FECheque: TEdit
      Left = 465
      Top = 18
      Width = 106
      Height = 21
      TabOrder = 6
      Text = '0'
      Visible = False
      OnChange = FEChequeChange
    end
    object FETarjeta: TEdit
      Left = 465
      Top = 42
      Width = 106
      Height = 21
      TabOrder = 7
      Text = '0'
      Visible = False
      OnChange = FETarjetaChange
    end
    object DiaChequeDateTimePicker: TDateTimePicker
      Left = 701
      Top = 18
      Width = 82
      Height = 21
      Date = 43830.000000000000000000
      Time = 0.506836111111624600
      TabOrder = 8
      Visible = False
    end
    object FEContado: TEdit
      Left = 60
      Top = 19
      Width = 106
      Height = 21
      TabOrder = 9
      Text = '0'
      OnChange = FEContadoChange
      OnExit = FEContadoExit
    end
    object FEOtro: TEdit
      Left = 59
      Top = 42
      Width = 106
      Height = 21
      TabOrder = 10
      Text = '0'
      Visible = False
      OnChange = FEOtroChange
    end
    object PagareCheckBox: TCheckBox
      Left = 225
      Top = 44
      Width = 14
      Height = 17
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 11
      Visible = False
    end
    object Presupuesto: TCheckBox
      Left = 359
      Top = 44
      Width = 17
      Height = 17
      TabOrder = 12
      Visible = False
    end
    object PedidoCheckBox: TCheckBox
      Left = 60
      Top = 3
      Width = 14
      Height = 16
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 13
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 25
    Align = alTop
    BevelOuter = bvLowered
    Color = clBlack
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 44
      Height = 13
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ClienteLabel: TLabel
      Left = 92
      Top = 6
      Width = 80
      Height = 13
      Caption = 'Consumidor Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 647
      Top = 6
      Width = 40
      Height = 13
      Caption = 'Fecha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label16: TLabel
      Left = 319
      Top = 6
      Width = 59
      Height = 13
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object VendedorLabel: TLabel
      Left = 404
      Top = 6
      Width = 9
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 265
      Top = 6
      Width = 41
      Height = 13
      Caption = 'Precio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PrecioLabel: TLabel
      Left = 304
      Top = 6
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CUITLabel: TLabel
      Left = 196
      Top = 6
      Width = 9
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 559
      Top = 7
      Width = 38
      Height = 13
      Caption = 'PERC:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 636
      Top = 7
      Width = 8
      Height = 13
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object ClienteEdit: TEdit
      Left = 72
      Top = 2
      Width = 16
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object VendedorEdit: TEdit
      Left = 378
      Top = 2
      Width = 22
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0'
      Visible = False
    end
    object FechaDateTimePicker: TDateTimePicker
      Left = 688
      Top = 2
      Width = 103
      Height = 21
      Date = 43466.000000000000000000
      Time = 0.475039594908594200
      TabOrder = 2
      Visible = False
    end
    object PercEdit: TEdit
      Left = 598
      Top = 3
      Width = 37
      Height = 21
      TabOrder = 3
      Text = '0'
      Visible = False
      OnExit = PercEditExit
    end
  end
  object SGFact: TStringGrid
    Left = 0
    Top = 97
    Width = 584
    Height = 312
    Align = alClient
    ColCount = 11
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 3
    ColWidths = (
      45
      274
      2
      52
      93
      84
      36
      64
      64
      64
      64)
    RowHeights = (
      24
      20)
  end
  object Panel3: TPanel
    Left = 0
    Top = 409
    Width = 792
    Height = 57
    Align = alBottom
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object ProcesarBitBtn: TBitBtn
      Left = 709
      Top = 5
      Width = 80
      Height = 50
      Hint = 'F12 - PROCESAR VENTA'
      Caption = 'GRABAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = ProcesarBitBtnClick
    end
    object ClienteBitBtn: TBitBtn
      Left = 3
      Top = 4
      Width = 85
      Height = 50
      Hint = 'F1 SELECCIONAR CLIENTE'
      Caption = 'cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clPurple
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ClienteBitBtnClick
    end
    object VendedorBitBtn: TBitBtn
      Left = 85
      Top = 4
      Width = 80
      Height = 50
      Hint = 'F3 SELECCIONAR VENDEDOR'
      Caption = 'vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Visible = False
      OnClick = VendedorBitBtnClick
    end
    object AgregarBitBtn: TBitBtn
      Left = 314
      Top = 4
      Width = 80
      Height = 50
      Hint = 'F5 - AGREGAR ARTICULO'
      Caption = '+ articulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = AgregarBitBtnClick
    end
    object NuevoBitBtn: TBitBtn
      Left = 235
      Top = 4
      Width = 80
      Height = 50
      Hint = 'F8 - CREAR ARTICULO'
      Caption = '* nuevo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clAqua
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Visible = False
      OnClick = NuevoBitBtnClick
    end
    object QuitarBitBtn: TBitBtn
      Left = 392
      Top = 4
      Width = 80
      Height = 50
      Hint = 'F6 - QUITAR ARTICULO'
      Caption = '- quitar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = QuitarBitBtnClick
    end
    object CantidadBitBtn: TBitBtn
      Left = 470
      Top = 4
      Width = 80
      Height = 50
      Hint = 'F7 - AUMENTAR CANTIDAD DE ARTICULO'
      Caption = 'cantidad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = CantidadBitBtnClick
    end
    object DescuentoBitBtn: TBitBtn
      Left = 548
      Top = 4
      Width = 90
      Height = 50
      Hint = 'F8 - DESCUENTO SOBRE ARTICULO'
      Caption = 'descuento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = DescuentoBitBtnClick
    end
  end
  object Panel2: TPanel
    Left = 584
    Top = 97
    Width = 208
    Height = 312
    Align = alRight
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    object SGTotal: TStringGrid
      Left = 1
      Top = 184
      Width = 204
      Height = 127
      BiDiMode = bdRightToLeft
      ColCount = 2
      DefaultColWidth = 100
      FixedRows = 0
      ParentBiDiMode = False
      ScrollBars = ssNone
      TabOrder = 0
      ColWidths = (
        100
        100)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 6
      Width = 196
      Height = 163
      Caption = 'Saldo'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      object LbSaldo: TLabel
        Left = 3
        Top = 18
        Width = 186
        Height = 43
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object TotalLabel: TLabel
        Left = 5
        Top = 55
        Width = 186
        Height = 43
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 101
        Width = 66
        Height = 62
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object cbTipo: TComboBox
          Left = 6
          Top = 15
          Width = 54
          Height = 37
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Text = 'C'
          OnChange = cbTipoChange
        end
      end
      object ComprobanteEdit: TEdit
        Left = 69
        Top = 116
        Width = 122
        Height = 37
        Alignment = taCenter
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object Tabla: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 200
    Top = 168
  end
  object Q: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 288
    Top = 168
  end
end
