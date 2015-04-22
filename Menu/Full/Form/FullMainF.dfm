object FullMainForm: TFullMainForm
  Left = 425
  Top = 258
  Align = alTop
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'DeGsoft GeN - ERP - Menu Principal'
  ClientHeight = 70
  ClientWidth = 748
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 748
    Height = 70
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 376
    ExplicitTop = 120
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C0000004F4D00003C0700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu1: TMainMenu
    Left = 16
    object Operaciones1: TMenuItem
      Caption = 'OPERACION'
      object Vender1: TMenuItem
        Caption = 'VENDER'
        OnClick = Vender1Click
      end
      object CrearPedido1: TMenuItem
        Caption = 'CREAR PEDIDO'
        OnClick = CrearPedido1Click
      end
      object Comprar1: TMenuItem
        Caption = 'COMPRAR'
        OnClick = Comprar1Click
      end
      object CuentaCorriente1: TMenuItem
        Caption = 'CUENTA CORRIENTE'
        OnClick = CuentaCorriente1Click
      end
      object CargarFactura1: TMenuItem
        Caption = 'TRAER VENTA'
        Visible = False
      end
      object AnularVenta1: TMenuItem
        Caption = 'ANULAR VENTA'
        OnClick = AnularVenta1Click
      end
      object AsignarCobrador1: TMenuItem
        Caption = 'ASIGNAR COBRADOR'
        Visible = False
      end
      object Aumentarporporcentaje1: TMenuItem
        Caption = 'AUMENTAR POR PORCENTAJE'
        OnClick = Aumentarporporcentaje1Click
      end
      object ReimprimirVenta1: TMenuItem
        Caption = 'RE IMPRIMIR VENTA'
        Visible = False
        OnClick = ReimprimirVenta1Click
      end
      object DevolverMercadera1: TMenuItem
        Caption = 'DEVOLUCION'
        Visible = False
      end
      object Retenciones1: TMenuItem
        Caption = 'RETENCION'
        Visible = False
      end
    end
    object CREDITOS1: TMenuItem
      Caption = 'CREDITOS'
      object CREARCREDITO1: TMenuItem
        Caption = 'CREAR CREDITO'
        OnClick = CrearCredito1Click
      end
      object COMPRAR2: TMenuItem
        Caption = 'COMPRAR'
      end
      object RENDICION2: TMenuItem
        Caption = 'RENDICION'
        object COBRADOR2: TMenuItem
          Caption = 'CARTON'
          OnClick = COBRADOR2Click
        end
        object RENDICIONDECOBRADORES1: TMenuItem
          Caption = 'COBRADOR'
        end
        object RENDICIONDECLIENTES1: TMenuItem
          Caption = 'CLIENTE'
        end
        object RENDICIONDECUOTAS1: TMenuItem
          Caption = 'CUOTA'
        end
      end
      object NOTADECREDITO1: TMenuItem
        Caption = 'NOTA DE CREDITO'
        OnClick = NOTADECREDITO1Click
      end
      object IMPRIMIRCARTON1: TMenuItem
        Caption = 'GENERAR CARTON'
        OnClick = IMPRIMIRCARTON1Click
      end
    end
    object CONTABILIDAD1: TMenuItem
      Caption = 'CONTABILIDAD'
      object PAGODEIVA1: TMenuItem
        Caption = 'PAGO DE IVA'
        OnClick = PAGODEIVA1Click
      end
      object APORTEDECAPITAL1: TMenuItem
        Caption = 'APORTE DE CAPITAL'
        OnClick = APORTEDECAPITAL1Click
      end
      object ABM2: TMenuItem
        Caption = 'ABM'
        object CUENTAS1: TMenuItem
          Caption = 'CUENTAS'
          OnClick = CUENTAS1Click
        end
        object CAPITULOS1: TMenuItem
          Caption = 'CAPITULOS'
          OnClick = CAPITULOS1Click
        end
        object RUBROS1: TMenuItem
          Caption = 'RUBROS'
          OnClick = RUBROS1Click
        end
        object IPODEGASTO1: TMenuItem
          Caption = 'TIPO DE GASTO'
          OnClick = IPODEGASTO1Click
        end
        object SOCIOS1: TMenuItem
          Caption = 'SOCIOS'
          OnClick = SOCIOS1Click
        end
      end
      object LIBROS1: TMenuItem
        Caption = 'LIBROS'
        object DIARIO1: TMenuItem
          Caption = 'DIARIO'
          OnClick = DIARIO1Click
        end
        object IVAVENTAS1: TMenuItem
          Caption = 'IVA VENTAS'
          OnClick = IVAVENTAS1Click
        end
        object IVACOMPRAS1: TMenuItem
          Caption = 'IVA COMPRAS'
          OnClick = IVACOMPRAS1Click
        end
      end
    end
    object COBRANZA1: TMenuItem
      Caption = 'COBRANZA'
      object REGISTRO1: TMenuItem
        Caption = 'REGISTRO'
        OnClick = REGISTRO1Click
      end
      object GESTION1: TMenuItem
        Caption = 'GESTION'
        object EMPRANOS1: TMenuItem
          Caption = 'TEMPRANA'
          OnClick = EMPRANOS1Click
        end
        object EXTRAJUDICIAL1: TMenuItem
          Caption = 'EXTRA JUDICIAL'
          OnClick = EXTRAJUDICIAL1Click
        end
        object JUDICIAL1: TMenuItem
          Caption = 'JUDICIAL'
          OnClick = JUDICIAL1Click
        end
        object INCOBRABLE1: TMenuItem
          Caption = 'INCOBRABLE'
          OnClick = INCOBRABLE1Click
        end
      end
    end
    object Pagos1: TMenuItem
      Caption = 'PAGOS'
      object PagosaProveedores1: TMenuItem
        Caption = 'PROVEEDORES'
        OnClick = PagosaProveedores1Click
      end
      object PagoaCobradores1: TMenuItem
        Caption = 'COBRADORES'
        Visible = False
        OnClick = PagoaCobradores1Click
      end
      object PagoaVendedores1: TMenuItem
        Caption = 'VENDEDORES'
        Visible = False
        OnClick = PagoaVendedores1Click
      end
    end
    object ABM1: TMenuItem
      Caption = 'ABM'
      object Productos: TMenuItem
        Caption = 'ARTICULO'
        OnClick = ProductosClick
      end
      object Proveedores: TMenuItem
        Caption = 'PROVEEDOR'
        OnClick = ProveedoresClick
      end
      object Clientes: TMenuItem
        Caption = 'CLIENTE'
        OnClick = ClientesClick
      end
      object PLANES1: TMenuItem
        Caption = 'PLANES'
        OnClick = PLANES1Click
      end
      object Vendedores: TMenuItem
        Caption = 'VENDEDOR'
        OnClick = VendedoresClick
      end
      object Cobradores: TMenuItem
        Caption = 'COBRADOR'
        OnClick = CobradoresClick
      end
      object Rubro: TMenuItem
        Caption = 'RUBRO'
        OnClick = RubroClick
      end
      object Categoria: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = CategoriaClick
      end
      object SubCategorias: TMenuItem
        Caption = 'SUBCATEGORIA'
        Visible = False
        OnClick = SubCategoriasClick
      end
      object Bancos: TMenuItem
        Caption = 'BANCOS'
        Visible = False
      end
      object IngresosBrutos: TMenuItem
        Caption = 'IIBB'
        OnClick = IngresosBrutosClick
      end
    end
    object Listados1: TMenuItem
      Caption = 'LISTADO'
      object Productos1: TMenuItem
        Caption = 'STOCK'
        OnClick = Productos1Click
      end
      object Caja2: TMenuItem
        Caption = 'CAJA'
        OnClick = Caja2Click
      end
      object Ganancias1: TMenuItem
        Caption = 'GANANCIAS'
        OnClick = Ganancias1Click
      end
      object Pedido1: TMenuItem
        Caption = 'PEDIDOS'
        OnClick = Pedido1Click
      end
      object ListadePrecios1: TMenuItem
        Caption = 'PRECIOS'
        OnClick = ListadePrecios1Click
      end
      object Clientes1: TMenuItem
        Caption = 'CLIENTES'
        OnClick = Clientes1Click
      end
      object Proveedores1: TMenuItem
        Caption = 'PROVEEDORES'
        Visible = False
      end
      object Cheques2: TMenuItem
        Caption = 'CHEQUES'
        Visible = False
        object EnCartera1: TMenuItem
          Caption = 'EN CARTERA'
        end
        object Entregados1: TMenuItem
          Caption = 'ENTREGADOS'
          OnClick = Entregados1Click
        end
      end
      object RENDICION1: TMenuItem
        Caption = 'RENDICION'
        object COBRADOR1: TMenuItem
          Caption = 'COBRADOR'
          OnClick = COBRADOR1Click
        end
        object CLIENTE1: TMenuItem
          Caption = 'CLIENTE'
          OnClick = CLIENTE1Click
        end
      end
      object ESTADODECUENTA1: TMenuItem
        Caption = 'ESTADO DE CUENTA'
        OnClick = ESTADODECUENTA1Click
      end
      object COMPRAS1: TMenuItem
        Caption = 'COMPRAS'
        OnClick = COMPRAS1Click
      end
      object VENTAS1: TMenuItem
        Caption = 'VENTAS'
        OnClick = VENTAS1Click
      end
    end
    object Configuracion1: TMenuItem
      Caption = 'CONFIGURACION'
      object Empresa1: TMenuItem
        Caption = 'EMPRESA'
        OnClick = Empresa1Click
      end
      object Login1: TMenuItem
        Caption = 'USUARIOS'
        OnClick = Login1Click
      end
      object Sistema1: TMenuItem
        Caption = 'SISTEMA'
        OnClick = Sistema1Click
      end
      object VaciarBasedeDatos1: TMenuItem
        Caption = 'RESTAURAR SISTEMA'
        OnClick = VaciarBasedeDatos1Click
      end
      object BACKUPCopiadeSeguridad1: TMenuItem
        Caption = 'COPIA DE SEGURIDAD'
        Visible = False
        OnClick = BACKUPCopiadeSeguridad1Click
      end
      object MIGRAR1: TMenuItem
        Caption = 'MIGRAR'
        Hint = 'MIGRAR DESDE VERSIONES ANTERIORES'
        OnClick = MIGRAR1Click
      end
      object LICENCIA1: TMenuItem
        Caption = 'LICENCIA'
        OnClick = LICENCIA1Click
      end
    end
    object N1: TMenuItem
      Caption = 'SALIR'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '?'
      object Ayuda1: TMenuItem
        Caption = 'Ayuda'
        OnClick = Ayuda1Click
      end
      object Acercade1: TMenuItem
        Caption = 'Acerca de...'
        OnClick = Acercade1Click
      end
    end
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 'DeGsoft'
    Icon.Data = {
      0000010001003030000001002000A82500001600000028000000300000006000
      0000010020000000000080250000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000001C0000
      0055000000550000003800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      005500000055000000550000001C000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000E2000000AA00000055000000000000000000000000000000000000
      00000000000000000000000000000000000000000055000000E2000000FF0000
      00FF000000FF000000FF000000E2000000710000000000000000000000000000
      00000000000000000000000000000000000000000038000000C6000000FF0000
      00FF000000FF000000FF000000FF000000C60000003800000000000000000000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000E20000003800000000000000000000
      0000000000000000000000000000000000AA000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000003800000000000000000000
      000000000000000000000000000000000071000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF00000071000000000000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF00000055000000000000
      0000000000000000000000000071000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000710000000000000000000000000000
      000000000000000000000000008D000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000550000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000380000
      0000000000000000001C000000FF000000FF000000FF000000FF000000FF0000
      00E2000000AA000000FF000000AA000000000000000000000000000000000000
      00000000000000000055000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000E20000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000E20000
      00000000000000000055000000FF000000FF000000FF000000FF000000E20000
      0002000000050000003E00000008030200050301000100000000000000000000
      000000000000000000E2000000FF000000FF000000FF000000FF000000FF0000
      00FF000000AA000000AA000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000055000000550000
      0071000000C6000000FF000000FF000000FF000000FF000000FF000000FF0000
      005500000000000000AA000000FF000000FF000000FF000000FF000000720000
      003E0000006100000066010100680302006603020063020100600101005A0B07
      000200000055000000FF000000FF000000FF000000FF000000FF000000AA0000
      00000000000000000000000000AA000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00000000000000000055000000FF000000FF000000FF000000FF000000FF0000
      00AA00000000000000AA000000FF000000FF000000FF000000FF0000005A0000
      00B1000000FF000000FF000000FF000000FF000000FF000000FF000000FF3D27
      000C000000AA000000FF000000FF000000FF000000FF000000E2000000000000
      000000000055000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00000000000000000000000000AA000000FF000000FF000000FF000000FF0000
      00FF00000001000000AB000000FF000000FF000000FF000000FF0000005E0000
      00B4000000FF000000FF000000FF000000FF000000FF000000FF000000FF5738
      0037000000E3000000FF000000FF000000FF000000FF00000071000000000000
      000000000055000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000055000000FF000000FF000000FF000000FF0000
      00FF0000000B0000005F000000FF000000FF000000FF000000FF000000CA0100
      0021070400352316007A000000FF000000FF000000FF000000FF170E00EE5C3B
      016A000000FF000000FF000000FF000000FF000000FF0101005B100A00030000
      000000000055000000FF000000FF000000FF000000FF000000FF000000C60000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000055000000FF000000FF000000FF000000FF0000
      00FF0000001F02010024000000E7000000FF000000FF000000FF000000FF0000
      00B60302007A070400E1000000FF000000FF000000FF000000FF452D01E55D3C
      0288000000FF000000FF000000FF000000FF000000FF110B006E432A000E2316
      000300000055000000FF000000FF000000FF000000FF000000FF0000001C0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      000000000000000000000000008D000000FF000000FF000000FF000000FF0000
      00FF03010031120B0047150D0098000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF211500FD8C5A01DF613F
      02A0000000FF000000FF000000FF000000FF000000FF180F00D2744A02525134
      01292719000D0A06000100000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00000000000000000055000000FF000000FF000000FF000000FF000000FF0000
      00B80F0A004434210073613E01AB342201EB000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF110B00FF875601FB915D02EF7048
      02C0090600D0000000FF000000FF000000FF000000FF000000FF513502C7794E
      026A4B30012D180F000A00000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF0000005500000055000000550000
      0071000000C6000000FF000000FF000000FF000000FF000000FF000000FF0000
      0073271900615C3C01A5845502DA976102F7784D02FC201400FC000000FF0000
      00FF000000FF000000FF000000FF452C00FE9A6301FE996201FD986102F98958
      02E5362301DD000000FF000000FF000000FF000000FF000000FF000000FF3F29
      01D1442C02711F14001C00000000000000710000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000E50000
      002B38240076774C02C6955F03EF9B6402FD9C6502FF9C6502FE8B5A03FC6742
      03FC664203FA674202FB9B6402FC9C6402FE9C6502FF9C6402FE9B6403FD9B64
      03FD8A5903FB120B00FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000E2000000290000
      00243421016F724902BF925E03EB9C6503FC9E6603FF9E6604FE9E6604FE9E66
      04FD9D6604FD9D6603FD9D6603FE9D6604FE9E6604FF9E6604FE9E6604FE9E66
      04FE9E6604FD694403FE000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000E20000001C000000070000
      001B231600545738029B825403D59A6404F69F6705FE9F6705FF9F6705FE9F67
      04FE9F6704FD9E6704FB9D6605F89D6605F59D6605F59D6605F69D6604F89E66
      04FC9E6604FD9F6704FE352201FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000E20000008D0000000200000003000000080000
      00170E0900353723016F6C4603B5946004EBA06805FCA16905FFA16905FEA069
      05FD9F6805F99E6805E99D6706D09A6506BF956205BA8F5D05C18C5C05D2925F
      05E99D6605F9A06805FEA16905FF482F02FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00AA000000AA000000AA000000AA000000AA000000AA000000AA000000AA0000
      00AA000000710000003800000001000000050000000B00000010010000160402
      002509050033281A005C5F3D03A18E5C05DEA06805F9A26A05FEA16A05FEA069
      06F79D6706E0956206B38B5B067884560552774D0347674403565F3E037F6E48
      04B78E5D05E39D6606F6A16906FDA26A05FF7E5304FF301F02F8000000FF0000
      00FF000000FF000000FF000000FF000000C60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000070000001700000020040100280C0700351A11
      004926190059412A017D6D4704B5936006E5A26A07FAA46C07FEA26A07FA9F68
      07DF946106A1734C045C482F022E39250118322001132A1B011D2819013B3824
      026B634103A78A5B05DBA06906F8A46C07FEA46C07FE9B6707EF7D5205C33725
      02A118100189110B00711F14012F3B270208160F000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000E0000002704030035190F004E382402724F34
      038E5C3D039E6E4904B6875906D79C6608F2A46C09FDA56C09FDA26A08EF9663
      07BD774E0564432C0219100A0003000000000000000000000004010000120E09
      00303522016B734B05BB9B6608EEA56C09FCA66D09FEA16909F88F5E07E27A50
      06C0734B059A7E52067887580759714A06363F29031100000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00010000000000000002000000110101002B100A0044422B027F875A07D19F6A
      09EFA06A09F2A26B09F5A36C09F9A56D09FCA66D09FEA66D09FAA26B08D88557
      0793452C03400E090008000000000000000000000000000000040100000F0301
      0020181000465E3D049D925F08DEA56C09F9A76D09FEA76D09FDA56C09FBA46B
      09F7A26A09F2A26A0AECA06A0AD5986509917A5107313C270301000000000000
      00000000000000000002010000030101000101010003010000090200000E0603
      000D0905000808050006020100110603002B1D12004D5236038F966309E2AB72
      0BFDAB710BFDAA710BFEA9700AFFA9700AFFA86F0AFFA66E0AF8A36C09CA8357
      077C3E2903300805000600000000000000000000000000000004000000110000
      0021110B003F5035048D875908D0A46C0AF5A9700AFEA9700AFFA9700AFFAA70
      0AFFA9700BFEA86F0BFDA66E0AEA9F6909A682570740402B0308000000000000
      00020000000C00000011060300110E09000F0E0900120905001907040020120B
      00262417002B2F1F0230291B022F1F15012B2D1D01465C3C048C9B650AE4AC72
      0CFFAC720CFFAB720CFFAB720CFFAB720CFFAA710CFFA86F0BF7A56D0AC78458
      08773F29032D0805000500000000000000000000000000000007000000160000
      0026100B00404D340488855809CCA56D0AF5AB720BFEAB720CFFAB720CFFAB72
      0CFFAA710CFEA9700CFCA76F0BE9A06A0AA683570840412B0309000000000000
      0009000000230000002B0D08002B281A01282A1C022C18100031100B00372619
      014B5135046D7B51068A7E5407755538042D432C032C603F05739C670BDEAF75
      0DFFAF750DFFAE750DFFAD740CFFAC730CFFAC730CFFAB720BF8A76F0ACE8659
      08833F2A0334080500060000000000000000000000020000000B0000001E0000
      002D130D0043573905928F5E0AD5A86F0BF7AD730BFEAD740CFFAC730CFFAB72
      0CFFAA710DFEA9700DFAA76F0CE2A16B0B978458082F00000000000000000000
      0008000000230F09003E34220364664407927B5208AA62410697402A0376472F
      047D754E08AC99660BCE885A09AA4D33044E2C1C0225402A0233764F07668056
      098F7B5209A8835809C396640AE0A76F0CF5AD730DFDAD740DFBAA720CE79966
      0AAD6E4A07523624030D0D070001010000050000000F0000001B000000280604
      0035251800596E4907AE9F6A0BE9AC730CFBAE740DFEAC720DFBA9710CECA971
      0CD2A8700CB5A7700C969E6A0C6E7C53083D422B041100000000000000000000
      000A00000022170F00474830057F84580AC4A26C0CE893620BD8764F08B9764F
      09BA94630BDBA9710CF08E5F09C8513604703B2703454C33043A6A4706425639
      064F422C04614F3404836F4B07B193630BDCAA720DF7B0760EFDAE740DF6A56F
      0CD48C5E0A8F5A3B054B2115012A0905001E030100210402002D0F0A003E281A
      025C5538058F8B5D0AD0AB720CF7AF750DFEAF750EFEAC730EE69C680CBA8458
      098B714B07636B47074363420625442E040C160F000200000000000000000000
      0012030100271D13014C4C330585885B0BCBA9720EF3AD750EF9AA720EF5AA73
      0EF5AD750EF9AD740DF792620AD762420699684507847A510879764F07663523
      033F0E0900301A110049452E047E7C5309BEA66F0DF0B2780EFEB1770EFDAD74
      0EF59D690CDD764E08AD402A04721E14014D110B0141170F014A312102676040
      069B94630AD7A9720DF2B0760EFDB1770EFFAF750EFFAD730FCC8B5D0B7E5136
      063B221601140E0900070B070003000000000000000000000000000000000502
      002D2115014D36240267583B06918C5E0BCEAB730FF5B1780FFDB1780FFCB178
      0FFBB2780FFBB0770FFBA7710EF097660CDB9B680CD5A16C0CCF92620BB7432D
      056C120C003F21170156583B069590610BD4AD740FF6B37910FFB37910FEB178
      10FCAC730FF69F6A0DE58B5C0BCD7A520ABA744F0AB478520AB985590BC79967
      0DDDAC730EF3B2770FFBB37810FEB27910FFB27710FFAE750FE4A06C0DA07E55
      0A4C49310512000000000000000000000000000000000000000000000000281A
      035C583B078E6C4908A580550ABD9C690EDFAD750FEBAC740FD89E6B0DBA8D5F
      0CAC82580BB68D5F0CD0A46F0EEAAE750FF5B1770FF8AE750EF097660CD5442E
      057C2518025B452E057E7A520AB9A46F0EE9B37810FBB57A11FFB57A11FEB57A
      11FEB47911FDB27810FAAF7610F6AB730FF1A9720FEFAB7410F1AE7610F5B278
      10FAB47910FCB57A11FDB57A11FEB57A11FFB57A11FFB27810F5AE750FC59967
      0D77634207312115020A00000000000000000000000000000000000000004D33
      06808A5D0CC4A36E0EE2AA730FEEAF7610F2AE7510D79F6B0E9B7E550A5E5539
      07443E2905595538068D8B5E0BCAAD7510F3B37A10FAAA730FE98A5D0CBF3926
      046C3926046F6E4A09A89A680EDAB27810F6B77C11FEB77C12FFB77C12FFB77C
      12FFB77C12FFB77C12FFB67C12FEB67B12FDB67B12FDB67C12FDB77C12FEB77C
      12FFB67B12FFB67B12FFB67B12FFB77C12FFB77C12FFB57A11FDB37910DF9F6C
      0EA1674509542217031700000000000000000000000000000000000000003A26
      046682570BB8A5700FE4B27810F7B37911F2A9720FB4885C0B5E533706262418
      021C120C0030241802565E3F0796A5700EE7B27910F39F6C0EC5734D0A762A1C
      0340402B046D7F560BB8A67110E7B67C12FBB87D13FFB87D13FFB87D12FFB97E
      12FFB87D12FFB87D12FFB87D12FFB87D13FFB87D13FFB77D13FFB67C12FFB67C
      12FFB57C11FFB67C11FFB77C12FFB87D13FFB87D13FFB77C12FFB57A11E9A06D
      0FB2674609642217031E00000000000000000000000000000000000000001A11
      01464931057A7E550CB7A36F10E5B07811ECA06C0EA5714C0A4A3725041E0F0A
      011C0503002B130C00434B330581A36E0FE3B57B11F5A57010CE84590B8B4E34
      0757543807687F550BA1A26E10D7B57B12F7B87E13FCB57C12F5A77210E19566
      0ECD8D600DC89A690EDAB17911F4B97E13FDB97E14FEB87D13FDB67C12F9B178
      11E3A7710FBDA6700FC2AB7410DAB57B12F6B87D13FEB77C13FBB57A12DBA16D
      0F996847094E2317031500000000000000000000000000000000000000000604
      003423170252644309999B690ED8AF7711EB9C6A0FB26B48096434230438120C
      012F0D090039231702545A3D0890A77110E6B87C13FAB37912EEA4700FCD855A
      0C8E6A480965714D097491630EA6AE7711D4B57C12E0AD7611CD8B5E0CA46142
      08804F36067B6E4B0AA7A47010E4B87D13FABA7F15FDB97E14FBB47B12EFA26E
      0FBB83580C657C540B698E600C97AB7410CEB67C12E5B57B12DFAD7510B19263
      0D685A3D07291D14020800000000000000000000000000000000000000000000
      0030462F067783590DBAA97412E6B67C13F4A87211D97F560CA44A330671291C
      03572C1E025E533807868A5D0DC1B07712F1B87D13FDB77C12FBB47A11EAA670
      10A96D490A5E5539073E77510B51A36F0F79AF77118D9D6B0F6E6D4A0A473826
      0436231802424D34067E95660ED0B47B13F3BB8015FBBA7F14F6B17812DE885C
      0D97402B052E352404215D3E083F9B690F6DB179119AB47B12909A690F5F6544
      092D2E1F030D0B0700010000000000000000000000000000000000000000110B
      012175500B9AA67111DAB97E14F5BC8015FBB67C13F49F6C10DB7E550CB76846
      0AA06D4A0AA48B5F0DC4AD7611E9B77D13F0B77D13D2B67C12B6AC7511A1865B
      0D73472F06392D1E0317442D05166544092B6E4B0A3A60410922402B050E1E14
      0112120C00293A27056683590DB9AB7612E7BA8015F8BA8014EFAE7612C97952
      0C7B1B13011A0A0700052B1C030C5E400822714C0A46734E0B3E5B3E081F2F20
      040A0C0801010000000000000000000000000000000000000000000000002116
      020D7D550C85A06D11C2A57112DAA47012E0AA7412E8B07813EEAC7612EAA772
      12E4A87212E4B07813EEB97F14F8B87E13E6B57C129BA973115B895C0D3B452F
      0723170F010F0B070005110B00041A11010A1D13020E19110207140D00030D09
      00090D09001C3121044D76500C98A47112D2B77E15EBBA8014DFAE7712AB7952
      0C5B19110112030200010A060001191001071D1302111E14020F180F01070C07
      000200000000000000000000000000000000000000000000000000000000110B
      010263430945724D0B74644409885B3E09907D550DB7A97312E6BB8015F9B87E
      14F7B47B14F2B77D14F6BC8015FCBA7F14E4B1791390895D0E4147300711150E
      0102000000000000000000000000000000000000000000000000000000000302
      00020A06000C31210429744F0B649F6D10AAB17913CDB57B13BCAB74127A7751
      0C2F191101090000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003322040F37250527281A0238281A02455F400988A06D11D3B37B14EAA16E
      12D48F620FBD9E6C11C9BB8015E9BA7F15DBAE77138B724D0B3C1A11020B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000050300012318030C5238082D6C4A0B6376510C7F79520C70744F0B3D5137
      080C110A00020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000C0800020F0A010B140D0115271A032662430A6E9E6D11B8A77312C07F57
      0E8F573B08626A480A739B6A10AB9A6A11A891630F625F410922150F01050000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000008050002130C010A191102171C13031E1C13031A1B12020E130D
      0203000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000105040004160F0111503608468D600F77986810746B49
      0B4A332204252A1C032A452F0748452F0748402C06282A1C040C090600010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000060300032D1E041C5B3E093166450A2B4730
      0717191002060000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000007050004100B0008120C01070D08
      0004040200010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FE1FFF0F0000040FF807F80300000403F003F00100000401E007E00000000400
      C00FC00000000400C003C00000000400400000E0000007C040000180000007E0
      00000180000007E000000080000007E000000000000007E00000001F000007C0
      0000001F00000000000000170000000000000007000000000000000700000000
      00000007000000000000000700000000000000070000FFE0000000030000FFC0
      000C00030000FE40001C00010000C000001C000100000000001C000100000000
      0018000300000000000000030000000000000003000000000000000F00000000
      0000003F000000000000001F000000000000001F000000000000001F00000000
      0000001F000000000000001F000000000000001F000000000000003F00000000
      0000007F000000007F003FFF00008000FF803FFF00008000FFC07FFF0000C000
      FFFFFFFF0000F03FFFFFFFFF0000F83FFFFFFFFF0000FFFFFFFFFFFF0000FFFF
      FFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000}
    Visible = True
    Left = 720
  end
end
