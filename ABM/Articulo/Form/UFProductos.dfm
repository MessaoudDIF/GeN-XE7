object FProductos: TFProductos
  Left = 259
  Top = 164
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSingle
  Caption = 'Altas, Bajas y Modificaciones de Articulos'
  ClientHeight = 468
  ClientWidth = 794
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
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 656
    Height = 468
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Detalles'
      object Label2: TLabel
        Left = 14
        Top = 82
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Descripci'#243'n'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 41
        Top = 176
        Width = 42
        Height = 13
        Caption = 'Cantidad'
      end
      object Label23: TLabel
        Left = 34
        Top = 140
        Width = 49
        Height = 13
        Caption = 'Proveedor'
      end
      object Label8: TLabel
        Left = 454
        Top = 85
        Width = 59
        Height = 13
        Caption = 'Tasa de IVA'
        FocusControl = IVADBEdit
      end
      object Label19: TLabel
        Left = 490
        Top = 61
        Width = 23
        Height = 13
        Caption = 'Flete'
      end
      object Label30: TLabel
        Left = 590
        Top = 85
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label10: TLabel
        Left = 56
        Top = 208
        Width = 27
        Height = 13
        Caption = 'Costo'
        FocusControl = CostoDBEdit
      end
      object Label5: TLabel
        Left = 448
        Top = 155
        Width = 65
        Height = 13
        Caption = 'Costo + Flete:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText1: TDBText
        Left = 519
        Top = 155
        Width = 106
        Height = 17
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 430
        Top = 195
        Width = 83
        Height = 16
        Caption = 'Costo Final:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label28: TLabel
        Left = 590
        Top = 61
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label21: TLabel
        Left = 687
        Top = 64
        Width = 3
        Height = 13
      end
      object Label4: TLabel
        Left = 485
        Top = 242
        Width = 28
        Height = 13
        Caption = 'Lista'
        FocusControl = PrecioCtaCteDBEdit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 467
        Top = 114
        Width = 46
        Height = 13
        Caption = 'Ganancia'
        FocusControl = GanaciaDBEdit
      end
      object Label34: TLabel
        Left = 590
        Top = 112
        Width = 8
        Height = 13
        Caption = '%'
      end
      object DBText2: TDBText
        Left = 519
        Top = 189
        Width = 144
        Height = 29
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 14
        Top = 61
        Width = 76
        Height = 13
        Caption = 'Codigo de Barra'
      end
      object PaintBox1: TImage
        Left = 258
        Top = 8
        Width = 89
        Height = 73
        AutoSize = True
        Center = True
        ParentShowHint = False
        ShowHint = False
        Visible = False
      end
      object DescripcionDBEdit: TDBEdit
        Left = 15
        Top = 101
        Width = 332
        Height = 21
        DataField = 'Descripcion'
        DataSource = DataSource
        TabOrder = 1
      end
      object DBEdit1: TDBEdit
        Left = 90
        Top = 175
        Width = 73
        Height = 21
        DataField = 'Disponible'
        DataSource = DataSource
        TabOrder = 3
      end
      object DBLookupComboBox4: TDBLookupComboBox
        Left = 90
        Top = 140
        Width = 231
        Height = 21
        DataField = 'Proveedor'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'NOMBRE'
        ListSource = DSQProve
        TabOrder = 2
        OnEnter = DBLookupComboBox4Enter
      end
      object BitBtn13: TBitBtn
        Left = 320
        Top = 140
        Width = 27
        Height = 21
        Hint = ' F4 AGREGAR PROVEEDOR'
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = BitBtn13Click
      end
      object IVADBEdit: TDBEdit
        Left = 519
        Top = 85
        Width = 65
        Height = 21
        DataField = 'Tasa'
        DataSource = DataSource
        TabOrder = 6
      end
      object FleteDBEdit: TDBEdit
        Left = 519
        Top = 59
        Width = 65
        Height = 21
        DataField = 'ImpOtros'
        DataSource = DataSource
        TabOrder = 5
      end
      object CostoDBEdit: TDBEdit
        Left = 90
        Top = 208
        Width = 113
        Height = 21
        DataField = 'Costo'
        DataSource = DataSource
        TabOrder = 4
      end
      object PrecioCtaCteDBEdit: TDBEdit
        Left = 519
        Top = 239
        Width = 97
        Height = 21
        DataField = 'PRECIO'
        DataSource = DataSource
        TabOrder = 8
      end
      object GanaciaDBEdit: TDBEdit
        Left = 519
        Top = 112
        Width = 65
        Height = 21
        DataField = 'PORCENTAJE'
        DataSource = DataSource
        TabOrder = 7
        OnExit = GanaciaDBEditExit
      end
      object CodigoBarraEdit: TDBEdit
        Left = 97
        Top = 60
        Width = 136
        Height = 21
        DataField = 'CodigoBarra'
        DataSource = DataSource
        TabOrder = 0
      end
      object CodigoBarraBitBtn: TBitBtn
        Left = 232
        Top = 60
        Width = 27
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = CodigoBarraBitBtnClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Notas'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBMemo1: TDBMemo
        Left = 0
        Top = 0
        Width = 648
        Height = 440
        Align = alClient
        DataField = 'Notas'
        DataSource = DataSource
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Informaci'#243'n Adicional'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label6: TLabel
        Left = 351
        Top = 116
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Ubicaci'#243'n'
        FocusControl = DBEdit6
      end
      object Label15: TLabel
        Left = 333
        Top = 177
        Width = 66
        Height = 13
        Caption = 'Stock M'#237'nimo'
        Visible = False
      end
      object Label17: TLabel
        Left = 332
        Top = 207
        Width = 67
        Height = 13
        Caption = 'Stock M'#225'ximo'
        FocusControl = DBEdit7
        Visible = False
      end
      object Label18: TLabel
        Left = 329
        Top = 237
        Width = 70
        Height = 13
        Caption = 'Stock Vendido'
        FocusControl = DBEdit8
        Visible = False
      end
      object Label20: TLabel
        Left = 298
        Top = 268
        Width = 101
        Height = 13
        Caption = 'Fecha Compra Ultimo'
        FocusControl = DBEdit17
      end
      object Label9: TLabel
        Left = 365
        Top = 88
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Unidad'
        FocusControl = DBEdit9
      end
      object Label32: TLabel
        Left = 339
        Top = 145
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Procedencia'
        FocusControl = DBEdit21
      end
      object Label25: TLabel
        Left = 30
        Top = 88
        Width = 29
        Height = 13
        Caption = 'Rubro'
      end
      object Label26: TLabel
        Left = 29
        Top = 120
        Width = 30
        Height = 13
        Caption = 'Marca'
      end
      object Label27: TLabel
        Left = 11
        Top = 57
        Width = 47
        Height = 13
        Caption = 'Categor'#237'a'
      end
      object DBEdit6: TDBEdit
        Left = 406
        Top = 115
        Width = 145
        Height = 21
        DataField = 'Ubicacion'
        DataSource = DataSource
        TabOrder = 4
      end
      object DBEdit5: TDBEdit
        Left = 406
        Top = 176
        Width = 96
        Height = 21
        DataField = 'StockMinimo'
        DataSource = DataSource
        TabOrder = 6
        Visible = False
      end
      object DBEdit7: TDBEdit
        Left = 406
        Top = 207
        Width = 96
        Height = 21
        DataField = 'StockMaximo'
        DataSource = DataSource
        TabOrder = 7
        Visible = False
      end
      object DBEdit8: TDBEdit
        Left = 406
        Top = 237
        Width = 97
        Height = 21
        DataField = 'StockVendido'
        DataSource = DataSource
        TabOrder = 8
        Visible = False
      end
      object DBEdit17: TDBEdit
        Left = 406
        Top = 268
        Width = 145
        Height = 21
        DataField = 'FechaCompUlt'
        DataSource = DataSource
        TabOrder = 9
      end
      object DBEdit9: TDBEdit
        Left = 406
        Top = 87
        Width = 73
        Height = 21
        DataField = 'Unidad'
        DataSource = DataSource
        TabOrder = 3
      end
      object DBEdit21: TDBEdit
        Left = 406
        Top = 144
        Width = 97
        Height = 21
        DataField = 'Procedencia'
        DataSource = DataSource
        TabOrder = 5
      end
      object RubroDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 84
        Width = 170
        Height = 21
        DataField = 'Rubro'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = DSRubro
        TabOrder = 1
        OnEnter = RubroDBLookupComboBoxEnter
      end
      object RubroBitBtn: TBitBtn
        Left = 235
        Top = 84
        Width = 28
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = RubroBitBtnClick
      end
      object MarcaDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 116
        Width = 170
        Height = 21
        DataField = 'Marca'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = MarcaDataSource
        TabOrder = 2
        OnEnter = MarcaDBLookupComboBoxEnter
        OnKeyUp = MarcaDBLookupComboBoxKeyUp
      end
      object MarcaBitBtn: TBitBtn
        Left = 235
        Top = 115
        Width = 28
        Height = 22
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = MarcaBitBtnClick
      end
      object CategoriaDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 53
        Width = 170
        Height = 21
        DataField = 'Categoria'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = DSTCat
        TabOrder = 0
        OnEnter = CategoriaDBLookupComboBoxEnter
      end
      object CategoriaBitBtn: TBitBtn
        Left = 235
        Top = 53
        Width = 28
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = CategoriaBitBtnClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Precios'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label11: TLabel
        Left = 185
        Top = 221
        Width = 39
        Height = 13
        Caption = 'Precio 5'
        FocusControl = Precio1DBEdit
      end
      object Label12: TLabel
        Left = 185
        Top = 96
        Width = 39
        Height = 13
        Caption = 'Precio 1'
        FocusControl = Precio2DBEdit
      end
      object Label13: TLabel
        Left = 185
        Top = 128
        Width = 39
        Height = 13
        Caption = 'Precio 2'
        FocusControl = Precio3DBEdit
      end
      object Label7: TLabel
        Left = 185
        Top = 251
        Width = 39
        Height = 13
        Caption = 'Precio 6'
        FocusControl = Precio6DBEdit
      end
      object Label31: TLabel
        Left = 185
        Top = 157
        Width = 39
        Height = 13
        Caption = 'Precio 3'
        FocusControl = Precio4DBEdit
      end
      object Label3: TLabel
        Left = 185
        Top = 189
        Width = 39
        Height = 13
        Caption = 'Precio 4'
        FocusControl = Precio5DBEdit
      end
      object Label22: TLabel
        Left = 231
        Top = 73
        Width = 46
        Height = 16
        Caption = 'Listas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Precio1DBEdit: TDBEdit
        Left = 232
        Top = 95
        Width = 96
        Height = 21
        DataField = 'Precio1'
        DataSource = DataSource
        TabOrder = 0
      end
      object Precio2DBEdit: TDBEdit
        Left = 232
        Top = 125
        Width = 96
        Height = 21
        DataField = 'Precio2'
        DataSource = DataSource
        TabOrder = 1
      end
      object Precio3DBEdit: TDBEdit
        Left = 232
        Top = 155
        Width = 97
        Height = 21
        DataField = 'Precio3'
        DataSource = DataSource
        TabOrder = 2
      end
      object Precio6DBEdit: TDBEdit
        Left = 231
        Top = 249
        Width = 97
        Height = 21
        DataField = 'Precio6'
        DataSource = DataSource
        TabOrder = 5
        OnExit = Precio6DBEditExit
      end
      object Precio4DBEdit: TDBEdit
        Left = 231
        Top = 186
        Width = 97
        Height = 21
        DataField = 'Precio4'
        DataSource = DataSource
        TabOrder = 3
      end
      object Precio5DBEdit: TDBEdit
        Left = 231
        Top = 219
        Width = 97
        Height = 21
        DataField = 'Precio5'
        DataSource = DataSource
        TabOrder = 4
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Contabilidad'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label50: TLabel
        Left = 185
        Top = 51
        Width = 162
        Height = 13
        Caption = 'Cuenta Contable Asociada a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label54: TLabel
        Left = 145
        Top = 203
        Width = 35
        Height = 13
        Caption = 'Orden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label53: TLabel
        Left = 91
        Top = 163
        Width = 89
        Height = 13
        Caption = 'Ingresos Brutos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label51: TLabel
        Left = 154
        Top = 123
        Width = 26
        Height = 13
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label52: TLabel
        Left = 136
        Top = 83
        Width = 44
        Height = 13
        Caption = 'Nombre'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CuentaDBLookupComboBox: TDBLookupComboBox
        Left = 185
        Top = 83
        Width = 351
        Height = 21
        DataField = 'CtaNombre'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 0
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 185
        Top = 123
        Width = 351
        Height = 21
        DataField = 'CtaTipo'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 1
      end
      object DBLookupComboBox2: TDBLookupComboBox
        Left = 185
        Top = 163
        Width = 351
        Height = 21
        DataField = 'CtaIIBB'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 2
      end
      object DBLookupComboBox7: TDBLookupComboBox
        Left = 185
        Top = 203
        Width = 351
        Height = 21
        DataField = 'CtaAnticipo'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 3
      end
    end
  end
  object Panel3: TPanel
    Left = 656
    Top = 0
    Width = 138
    Height = 468
    Align = alRight
    Color = clBlack
    ParentBackground = False
    TabOrder = 1
    object Label29: TLabel
      Left = 45
      Top = 206
      Width = 46
      Height = 13
      Caption = 'Grabar?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 48
      Top = 22
      Width = 40
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 28
      Top = 145
      Width = 80
      Height = 50
      Caption = 'Si'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 6
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 28
      Top = 225
      Width = 80
      Height = 50
      Caption = 'No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = bkNo
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object CodigoDBEdit: TDBEdit
      Left = 25
      Top = 41
      Width = 86
      Height = 32
      DataField = 'CODIGO'
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 28
      Top = 352
      Width = 80
      Height = 50
      Caption = 'Buscar F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object DBNavigator1: TDBNavigator
      Left = 10
      Top = 427
      Width = 120
      Height = 36
      DataSource = DataSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Hints.Strings = (
        'Primer registro'
        'Registro anterior'
        'Registro siguiente'
        #218'ltimo registro'
        'Insertar registro'
        'Eliminar registro'
        'Editar registro'
        'Guardar cambios'
        'Cancelar edici'#243'n'
        'Refrescar datos')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Tabla
    Left = 75
    Top = 265
  end
  object DSTCat: TDataSource
    DataSet = CategoriaT
    Left = 392
    Top = 425
  end
  object DSTSubCat: TDataSource
    DataSet = SubCategoriaT
    Left = 544
    Top = 425
  end
  object DSMateriales: TDataSource
    DataSet = MaterialT
    Left = 41
    Top = 368
  end
  object DSRubro: TDataSource
    DataSet = RubroT
    Left = 616
    Top = 425
  end
  object DSQProve: TDataSource
    DataSet = ProveedorT
    Left = 256
    Top = 368
  end
  object MarcaDataSource: TDataSource
    DataSet = MarcaT
    Left = 120
    Top = 368
  end
  object CuentaDataSource: TDataSource
    DataSet = CuentaQuery
    Left = 190
    Top = 425
  end
  object Tabla: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    AfterCancel = TablaAfterCancel
    AfterDelete = TablaAfterDelete
    AfterInsert = TablaAfterInsert
    AfterPost = TablaAfterPost
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESCRIPCION'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'COSTO'
        DataType = ftFloat
      end
      item
        Name = 'ULTCOSTO'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO1'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO2'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO3'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO4'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO5'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO6'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO'
        DataType = ftFloat
      end
      item
        Name = 'PORCENTAJE'
        DataType = ftFloat
      end
      item
        Name = 'ULTPRECIO'
        DataType = ftFloat
      end
      item
        Name = 'MARCA'
        DataType = ftInteger
      end
      item
        Name = 'COLOR'
        DataType = ftInteger
      end
      item
        Name = 'CATEGORIA'
        DataType = ftInteger
      end
      item
        Name = 'SUBCATEGORIA'
        DataType = ftInteger
      end
      item
        Name = 'UBICACION'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'UNIDAD'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'DISPONIBLE'
        DataType = ftInteger
      end
      item
        Name = 'ENPRODUCCION'
        DataType = ftInteger
      end
      item
        Name = 'NOTAS'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'IVA'
        DataType = ftInteger
      end
      item
        Name = 'TASA'
        DataType = ftInteger
      end
      item
        Name = 'IMPOTROS'
        DataType = ftInteger
      end
      item
        Name = 'IIBB'
        DataType = ftInteger
      end
      item
        Name = 'STOCKMINIMO'
        DataType = ftInteger
      end
      item
        Name = 'STOCKMAXIMO'
        DataType = ftInteger
      end
      item
        Name = 'STOCKVENDIDO'
        DataType = ftInteger
      end
      item
        Name = 'FECHACOMPULT'
        DataType = ftDateTime
      end
      item
        Name = 'LISTA'
        DataType = ftInteger
      end
      item
        Name = 'PROCEDENCIA'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CODIGOBARRA'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'RUBRO'
        DataType = ftInteger
      end
      item
        Name = 'PROVEEDOR'
        DataType = ftInteger
      end
      item
        Name = 'GARANTIA'
        DataType = ftInteger
      end
      item
        Name = 'FECHA'
        DataType = ftDateTime
      end
      item
        Name = 'PEDIDO'
        DataType = ftInteger
      end
      item
        Name = 'STOCK'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'EXISTENTE'
        DataType = ftInteger
      end
      item
        Name = 'ACTUAL'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOCONTADO'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOLISTA'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOFINAL'
        DataType = ftInteger
      end
      item
        Name = 'PREPARADO'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CTANOMBRE'
        DataType = ftInteger
      end
      item
        Name = 'CTATIPO'
        DataType = ftInteger
      end
      item
        Name = 'CTAANTICIPO'
        DataType = ftInteger
      end
      item
        Name = 'CTAIIBB'
        DataType = ftInteger
      end
      item
        Name = 'ESTADO'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'VENCE'
        DataType = ftDateTime
      end
      item
        Name = 'VENCIMIENTO'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'PK_Articulo'
        Fields = 'CODIGO'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'Articulo'
    UniDirectional = False
    Left = 27
    Top = 264
  end
  object CategoriaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Categoria'
    UniDirectional = False
    Left = 352
    Top = 425
  end
  object SubCategoriaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'SubCategoria'
    UniDirectional = False
    Left = 512
    Top = 425
  end
  object RubroT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Rubro'
    UniDirectional = False
    Left = 584
    Top = 425
  end
  object MaterialT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Material'
    UniDirectional = False
    Left = 11
    Top = 368
  end
  object QTemp: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 240
    Top = 425
  end
  object Usuario: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Usuario"')
    Left = 8
    Top = 425
  end
  object DSUsuarios: TDataSource
    DataSet = Usuario
    Left = 38
    Top = 425
  end
  object CuentaQuery: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Cuenta"'
      'order by DESCRIPCION')
    Left = 160
    Top = 425
  end
  object MarcaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Marca'
    UniDirectional = False
    Left = 88
    Top = 368
  end
  object ProveedorT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Proveedor'
    UniDirectional = False
    Left = 200
    Top = 368
  end
  object ConfigQuery: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Config"')
    Left = 96
    Top = 425
  end
end
