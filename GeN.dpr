program GeN;

uses
  Vcl.Forms,
  UFFormaPago in 'SubOperacion\FormaPago\Form\UFFormaPago.pas' {FFormaPago},
  UFClientes in 'ABM\Cliente\Form\UFClientes.pas' {FClientes},
  UFCategorias in 'ABM\Categoria\Form\UFCategorias.pas' {FCategorias},
  UFBuscaProve in 'Buscar\Proveedor\Form\UFBuscaProve.pas' {FBuscaProve},
  UFBuscaCliente in 'Buscar\Cliente\Form\UFBuscaCliente.pas' {FBuscaCliente},
  AgregarCantidad in 'SubOperacion\AgregarCantidad\Form\AgregarCantidad.pas' {AgregarCantidadForm},
  ListadoClientes in 'Listados\Clientes\Form\ListadoClientes.pas' {ListadoClientesForm},
  LibrosF in 'Listados\Libros\LibrosF.pas' {LibrosForm},
  LibroDiarioF in 'Listados\LibroDiario\Form\LibroDiarioF.pas' {LibroDiarioLForm},
  incremento in 'Operacion\IncrementarValorPorc\Form\incremento.pas' {IncrementoForm},
  ImprimirDM in 'DataModule\ImprimirDM.pas' {ImprimirDataModule: TDataModule},
  Hoja_Calculo in 'Exportar\Excel\Hoja_Calculo.pas',
  GananciasL in 'Listados\Ganancias\Form\GananciasL.pas' {GanaciaxVtaLForm},
  EmpresaF in 'ABM\Empresa\Form\EmpresaF.pas' {EmpresaForm},
  DataModule in 'DataModule\DataModule.pas' {DM: TDataModule},
  ConfiguracionF in 'Configuracion\Sistema\Form\ConfiguracionF.pas' {ConfiguracionForm},
  CajaLF in 'Listados\Caja\Form\CajaLF.pas' {CajaLForm},
  BuscarVendedor in 'Buscar\Vendedor\Form\BuscarVendedor.pas' {BuscarVendedorForm},
  UFBuscaArticulos in 'Buscar\Articulo\Form\UFBuscaArticulos.pas' {FBuscaArticulo},
  AnularVtaF in 'Operacion\AnularVenta\Form\AnularVtaF.pas' {FAnulaReimp},
  RubroF in 'ABM\Rubro\Form\RubroF.pas' {RubroForm},
  ProveedorF in 'ABM\Proveedor\Form\ProveedorF.pas' {ProveedorForm},
  Precios in 'Listados\Precios\Form\Precios.pas' {ListaPreciosForm},
  OperacionDM in 'DataModule\OperacionDM.pas' {OperacionDataModule: TDataModule},
  MigrarF in 'Operacion\Migrar\form\MigrarF.pas' {MigrarForm},
  VaciarBaseF in 'Operacion\VaciarBase\Form\VaciarBaseF.pas' {VaciarBaseForm},
  Unit1 in 'Exportar\Excel\Unit1.pas' {Form1},
  UFSelProdFact in 'SubOperacion\SelecionarPrecio\Form\UFSelProdFact.pas' {FSelProdFact},
  UFProductos in 'ABM\Articulo\Form\UFProductos.pas' {FProductos},
  OperacionF in 'Operacion\Operacion\Form\OperacionF.pas' {OperacionForm},
  ExportarExcelF in 'Exportar\Excel\Form\ExportarExcelF.pas' {Menu1},
  main in 'AcercaDe\form\main.pas' {mainForm},
  LoginF in 'SubOperacion\Login\Form\LoginF.pas' {FLogin},
  FullMainF in 'Menu\Full\Form\FullMainF.pas' {FullMainForm},
  BuscaCompra in 'buscar\compra\form\BuscaCompra.pas' {BuscaCompraForm},
  BuscaFactura in 'Buscar\Venta\Form\BuscaFactura.pas' {BuscaFacturaForm},
  MarcaF in 'ABM\Marca\Form\MarcaF.pas' {MarcaForm},
  AfipDM in 'DataModule\AfipDM.pas' {AfipDataModule: TDataModule},
  PagoIVAF in 'Operacion\PagoIVA\Form\PagoIVAF.pas' {PagoIVAForm},
  DescuentoF in 'SubOperacion\Descuento\Form\DescuentoF.pas' {DescuentoForm},
  VendedorF in 'ABM\Vendedor\Form\VendedorF.pas' {VendedorForm},
  AfipUnit in 'Configuracion\Afip\AfipUnit.pas' {AfipForm},
  LoginCms1 in 'DataModule\LoginCms1.pas',
  service in 'DataModule\service.pas',
  RestDM in 'DataModule\RestDM.pas' {DMR: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  udmMercadoLibre in 'DataModule\udmMercadoLibre.pas' {dmML: TDataModule},
  EditorReporteUnit in 'Report\EditorReporteUnit.pas' {fEditorReporte},
  ufRetPerc in 'SubOperacion\RetencionesPercepciones\ufRetPerc.pas' {fRetPerc},
  PagoF in 'Operacion\Pago\Form\PagoF.pas' {PagoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.Title := 'Civeloo GeN';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFullMainForm, FullMainForm);
  Application.CreateForm(TPagoForm, PagoForm);
  Application.Run;
end.
