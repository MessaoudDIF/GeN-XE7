unit FullMainF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TeEngine, Series, ComCtrls, Grids,
  DBGrids,
  Menus, DB, jpeg, DataModule, shellapi, OleCtrls, SHDocVw, UrlMon;

type

  EExecAppError = class(Exception);

  TFullMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ABM1: TMenuItem;
    Proveedores: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Operaciones1: TMenuItem;
    Vender1: TMenuItem;
    Comprar1: TMenuItem;
    Clientes: TMenuItem;
    Rubro: TMenuItem;
    Categoria: TMenuItem;
    SubCategorias: TMenuItem;
    Bancos: TMenuItem;
    IngresosBrutos: TMenuItem;
    Aumentarporporcentaje1: TMenuItem;
    Productos: TMenuItem;
    Listados1: TMenuItem;
    Cheques2: TMenuItem;
    Productos1: TMenuItem;
    AnularVenta1: TMenuItem;
    ReimprimirVenta1: TMenuItem;
    DevolverMercadera1: TMenuItem;
    ListadePrecios1: TMenuItem;
    Configuracion1: TMenuItem;
    Retenciones1: TMenuItem;
    Clientes1: TMenuItem;
    Proveedores1: TMenuItem;
    Caja2: TMenuItem;
    EnCartera1: TMenuItem;
    Entregados1: TMenuItem;
    CargarFactura1: TMenuItem;
    Pagos1: TMenuItem;
    PagosaProveedores1: TMenuItem;
    PagoaCobradores1: TMenuItem;
    PagoaVendedores1: TMenuItem;
    AsignarCobrador1: TMenuItem;
    Empresa1: TMenuItem;
    Sistema1: TMenuItem;
    Pedido1: TMenuItem;
    Ganancias1: TMenuItem;
    VaciarBasedeDatos1: TMenuItem;
    Vendedores: TMenuItem;
    Cobradores: TMenuItem;
    CrearPedido1: TMenuItem;
    CuentaCorriente1: TMenuItem;
    BACKUPCopiadeSeguridad1: TMenuItem;
    Login1: TMenuItem;
    TrayIcon1: TTrayIcon;
    WebBrowser1: TWebBrowser;
    CREDITOS1: TMenuItem;
    CREARCREDITO1: TMenuItem;
    RENDICION2: TMenuItem;
    NOTADECREDITO1: TMenuItem;
    IMPRIMIRCARTON1: TMenuItem;
    COMPRAR2: TMenuItem;
    PLANES1: TMenuItem;
    RENDICION1: TMenuItem;
    COBRADOR1: TMenuItem;
    CLIENTE1: TMenuItem;
    ESTADODECUENTA1: TMenuItem;
    COBRADOR2: TMenuItem;
    RENDICIONDECOBRADORES1: TMenuItem;
    RENDICIONDECLIENTES1: TMenuItem;
    RENDICIONDECUOTAS1: TMenuItem;
    CONTABILIDAD1: TMenuItem;
    PAGODEIVA1: TMenuItem;
    APORTEDECAPITAL1: TMenuItem;
    ABM2: TMenuItem;
    CUENTAS1: TMenuItem;
    CAPITULOS1: TMenuItem;
    RUBROS1: TMenuItem;
    IPODEGASTO1: TMenuItem;
    SOCIOS1: TMenuItem;
    LIBROS1: TMenuItem;
    DIARIO1: TMenuItem;
    IVAVENTAS1: TMenuItem;
    IVACOMPRAS1: TMenuItem;
    COBRANZA1: TMenuItem;
    REGISTRO1: TMenuItem;
    GESTION1: TMenuItem;
    EMPRANOS1: TMenuItem;
    EXTRAJUDICIAL1: TMenuItem;
    JUDICIAL1: TMenuItem;
    INCOBRABLE1: TMenuItem;
    Ayuda1: TMenuItem;
    Acercade1: TMenuItem;
    MIGRAR1: TMenuItem;
    LICENCIA1: TMenuItem;
    COMPRAS1: TMenuItem;
    VENTAS1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ProveedoresClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ProductosClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure RubroClick(Sender: TObject);
    procedure CategoriaClick(Sender: TObject);
    procedure Aumentarporporcentaje1Click(Sender: TObject);
    procedure AnularVenta1Click(Sender: TObject);
    procedure Comprar1Click(Sender: TObject);
    procedure Vender1Click(Sender: TObject);
    procedure ListadePrecios1Click(Sender: TObject);
    procedure ImpuestosyServicios1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Caja2Click(Sender: TObject);
    procedure Entregados1Click(Sender: TObject);
    procedure PlanesClick(Sender: TObject);
    procedure PagoaCobradores1Click(Sender: TObject);
    procedure RendiciondeCobrador1Click(Sender: TObject);
    procedure PagoaVendedores1Click(Sender: TObject);
    procedure RendicindeClientes1Click(Sender: TObject);
    procedure PagosdeServicios1Click(Sender: TObject);
    procedure Empresa1Click(Sender: TObject);
    procedure Pedido1Click(Sender: TObject);
    procedure Ganancias1Click(Sender: TObject);
    procedure Sistema1Click(Sender: TObject);
    procedure VaciarBasedeDatos1Click(Sender: TObject);
    procedure VendedoresClick(Sender: TObject);
    procedure CobradoresClick(Sender: TObject);
    procedure VerStock1Click(Sender: TObject);
    procedure CrearPedido1Click(Sender: TObject);
    procedure PagosaProveedores1Click(Sender: TObject);
    procedure CuentaCorriente1Click(Sender: TObject);
    procedure ReimprimirVenta1Click(Sender: TObject);
    procedure Licencia1Click(Sender: TObject);
    procedure Cuentas1Click(Sender: TObject);
    procedure LibroIVAVentas1Click(Sender: TObject);
    procedure LibroIVACompras1Click(Sender: TObject);
    procedure Productos1Click(Sender: TObject);
    procedure Caja3Click(Sender: TObject);
    procedure Creditos1Click(Sender: TObject);
    procedure Contable1Click(Sender: TObject);
    procedure Co1Click(Sender: TObject);
    procedure BACKUPCopiadeSeguridad1Click(Sender: TObject);
    procedure Stock1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure LibroDiario1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CrearCredito1Click(Sender: TObject);
    procedure RENDICIONDECOBRADORES1Click(Sender: TObject);
    procedure RENDICIONDECLIENTES1Click(Sender: TObject);
    procedure RENDICIONDECUOTAS1Click(Sender: TObject);
    procedure NOTADECREDITO1Click(Sender: TObject);
    procedure IMPRIMIRCARTON1Click(Sender: TObject);
    procedure PLANES1Click(Sender: TObject);
    procedure COBRADOR1Click(Sender: TObject);
    procedure CLIENTE1Click(Sender: TObject);
    procedure ESTADODECUENTA1Click(Sender: TObject);
    procedure COBRADOR2Click(Sender: TObject);
    procedure PAGODEIVA1Click(Sender: TObject);
    procedure APORTEDECAPITAL1Click(Sender: TObject);
    procedure CAPITULOS1Click(Sender: TObject);
    procedure RUBROS1Click(Sender: TObject);
    procedure IPODEGASTO1Click(Sender: TObject);
    procedure SOCIOS1Click(Sender: TObject);
    procedure DIARIO1Click(Sender: TObject);
    procedure IVAVENTAS1Click(Sender: TObject);
    procedure IVACOMPRAS1Click(Sender: TObject);
    procedure REGISTRO1Click(Sender: TObject);
    procedure EMPRANOS1Click(Sender: TObject);
    procedure EXTRAJUDICIAL1Click(Sender: TObject);
    procedure JUDICIAL1Click(Sender: TObject);
    procedure INCOBRABLE1Click(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure Ayuda1Click(Sender: TObject);
    procedure MIGRAR1Click(Sender: TObject);
    procedure IngresosBrutosClick(Sender: TObject);
    procedure COMPRAS1Click(Sender: TObject);
    procedure VENTAS1Click(Sender: TObject);
    procedure SubCategoriasClick(Sender: TObject);
    // function WinExecAndWait32(FileName:String; Visibility:integer):integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FullMainForm: TFullMainForm;

implementation

uses LoginF, VenderF, CrearCreditoF;

{$R *.dfm}

procedure TFullMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.DejarUsuario;
end;

procedure TFullMainForm.FormShow(Sender: TObject);
begin
  // CONECTAR BASE DE DATOS
  DM := TDM.Create(self);
  // CONTROL DE USUARIOS
  FLogin := TFLogin.Create(self);
  try
    FLogin.ShowModal;
  finally
    FLogin.Free;
  end;
  WebBrowser1.Navigate(path + 'ayuda\index.htm');
  if LoginOk <> True then
  begin
    ShowMessage('el usuario no coincide con la clave...');
    close;
  end
  else
  begin
    if Permiso < 3 then
      Configuracion1.Visible := False;
    if Permiso < 2 then
      CONTABILIDAD1.Visible := False;
    if Permiso < 1 then
    begin
      Listados1.Visible := False;
      ABM1.Visible := False;
      Pagos1.Visible := False;
      Comprar1.Visible := False;
      CuentaCorriente1.Visible := False;
      Aumentarporporcentaje1.Visible := False;
      AnularVenta1.Visible := False;
      ReimprimirVenta1.Visible := False;
      DevolverMercadera1.Visible := False;
      Retenciones1.Visible := False;
      CargarFactura1.Visible := False;
      AsignarCobrador1.Visible := False;
      CrearPedido1.Visible := False;
    end;
  end;
  FullMainForm.caption := 'DeGsoft GeN - ERP - [' + Empresa + '] - ' + Licencia +
    ' - [USUARIO: ' + Usuario + '] MODULO COMPLETO';
end;

procedure TFullMainForm.Cuentas1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CuentaContable.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.DIARIO1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroDiarioL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = VK_F1 then
    Ayuda1.Click;
end;

procedure TFullMainForm.ProveedoresClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Proveedor.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.N1Click(Sender: TObject);
begin
  close;
end;

procedure TFullMainForm.NOTADECREDITO1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'NotaCreditoPlan.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.BACKUPCopiadeSeguridad1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Backup.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Productos1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Stock.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ProductosClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Articulos.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ClientesClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Clientes.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RubroClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Rubro.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RUBROS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RubroContable.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CategoriaClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Categoria.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CLIENTE1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionClienteL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.APORTEDECAPITAL1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'AporteCapital.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Aumentarporporcentaje1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'IncrementarValor.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Ayuda1Click(Sender: TObject);
begin
  HlinkNavigateString(Nil, pChar(path + 'ayuda\index.htm'));
end;

procedure TFullMainForm.Acercade1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'about.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.AnularVenta1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'AnularVenta.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Comprar1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Comprar.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.COMPRAS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CompraL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Vender1Click(Sender: TObject);
begin
  // WinExec(PAnsiChar(AnsiString(Path+'Vender.exe')),SW_SHOWNORMAL);
  VenderForm := TVenderForm.Create(self);
  try
    VenderForm.ShowModal;
  finally
    VenderForm.Free;
  end;
end;

procedure TFullMainForm.VENTAS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'VentaL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.LibroIVACompras1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroIVACompras.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.LibroIVAVentas1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroIVAVentas.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Licencia1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Licencia.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ListadePrecios1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PreciosL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Login1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Usuarios.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.MIGRAR1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Migrar.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Contable1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'MenuContable.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.IMPRIMIRCARTON1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CartonCobranza.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ImpuestosyServicios1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'ImpuestoServicio.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.INCOBRABLE1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CobranzaIncobrable.exe')),
    SW_SHOWNORMAL);
end;

procedure TFullMainForm.IngresosBrutosClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'IngresosBrutos.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.IPODEGASTO1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'TipoGasto.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.IVACOMPRAS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroIVACompras.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.IVAVENTAS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroIVAVentas.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.JUDICIAL1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CobranzaJudicial.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Clientes1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'ClientesL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Caja2Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CajaL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Caja3Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Caja.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CAPITULOS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Capitulo.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Entregados1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Caja.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ESTADODECUENTA1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'EstadoCuentaL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.EXTRAJUDICIAL1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CobranzaExtrajudicial.exe')),
    SW_SHOWNORMAL);
end;

procedure TFullMainForm.PlanesClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Plan.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PagoaCobradores1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoCobrador.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RendiciondeCobrador1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoCobrador.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RENDICIONDECOBRADORES1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoCobrador.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RENDICIONDECUOTAS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionCliente.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PagoaVendedores1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoVendedor.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PAGODEIVA1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoIVA.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RendicindeClientes1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionCliente.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.RENDICIONDECLIENTES1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionClienteL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.LibroDiario1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'LibroDiarioL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PagosdeServicios1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoServicio.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.EMPRANOS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'GestionCobranza.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Empresa1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Empresa.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Pedido1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PedidoL.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PLANES1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Plan.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Ganancias1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'GananciaXvta.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Sistema1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Configuracion.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.SOCIOS1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Socio.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Stock1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'MenuStock.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.SubCategoriasClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'SubCategoria.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.VaciarBasedeDatos1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'VaciarBase.exe')), SW_SHOWNORMAL);
  close;
end;

procedure TFullMainForm.VendedoresClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Vendedor.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.Co1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'MenuGestionCobranza.exe')),
    SW_SHOWNORMAL);
end;

procedure TFullMainForm.COBRADOR1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionCobradorL.exe')),
    SW_SHOWNORMAL);
end;

procedure TFullMainForm.COBRADOR2Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'RendicionCarton.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CobradoresClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Cobrador.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.VerStock1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'Stock.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CrearCredito1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CrearCredito.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CrearPedido1Click(Sender: TObject);
begin
//  WinExec(PAnsiChar(AnsiString(path + 'CrearPedido.exe')), SW_SHOWNORMAL);
 CrearCreditoForm:=TCrearCreditoForm.Create(self);
 try
  CrearCreditoForm.ShowModal;
 finally
  CrearCreditoForm.Free;
 end;
end;

procedure TFullMainForm.Creditos1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'MenuCreditos.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.PagosaProveedores1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'PagoProveedor.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.CuentaCorriente1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CtaCte.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.REGISTRO1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'GestionCobranza.exe')), SW_SHOWNORMAL);
end;

procedure TFullMainForm.ReimprimirVenta1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'AnularVenta.exe')), SW_SHOWNORMAL);
end;

end.