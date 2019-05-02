unit AfipUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ExtDlgs, ShellApi, System.IOUtils;

type
  TAfipForm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    CSRButton: TButton;
    SaveTextFileDialog1: TSaveTextFileDialog;
    CRTButton: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Label38: TLabel;
    AyudaButton: TButton;
    Button1: TButton;
    PuntoVentaButton: TButton;
    OpensslButton: TButton;
    OpenDialog1: TOpenDialog;
    ProbarButton: TButton;
    SubscripcionButton: TButton;
    procedure CSRButtonClick(Sender: TObject);
    procedure CRTButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AyudaButtonClick(Sender: TObject);
    procedure PuntoVentaButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OpensslButtonClick(Sender: TObject);
    procedure ProbarButtonClick(Sender: TObject);
    procedure SubscripcionButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AfipForm: TAfipForm;

implementation

{$R *.dfm}

uses DataModule, EmpresaF, AfipDM;

procedure TAfipForm.AyudaButtonClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://www.afip.gob.ar/ws/documentacion/wsaa.asp',nil,nil,SW_NORMAL);
end;

procedure TAfipForm.Button1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://www.afip.gob.ar/ws/WSAA/wsaa_asociar_certificado_a_wsn_produccion.pdf',nil,nil,SW_NORMAL);
//  Close;
end;

procedure TAfipForm.CRTButtonClick(Sender: TObject);
var
  f : string;
begin
  OpenTextFileDialog1.Execute();
  f := OpenTextFileDialog1.FileName;
  if FileExists(f) then
  begin
    Memo1.Lines.LoadFromFile(f);
    Memo1.Lines.SaveToFile(Path+'db\certificado.crt');
  end;
end;

procedure TAfipForm.CSRButtonClick(Sender: TObject);
var
  key, csr, pfx, ruta, f : string;
  m : TStringList;
  subj_o,subj_cuit,subj_cn : string;
begin
  with DM do begin
    TraerConfig;
    if ((Empresa='') or (Titular='') or (CUIT='') or (PuntoVenta='1')) then begin
      ShowMessage('Por favor completar datos de empresa (Nombre, Titular, CUIT, Punto de Venta, etc.)');
      EmpresaForm := TEmpresaForm.Create(self);
      try
        EmpresaForm.ShowModal;
      finally
        EmpresaForm.Free;
      end
    end else begin
      subj_o := Titular;
      subj_cn := Empresa;
      subj_cuit := CUIT;
      ruta := Path + 'db\';
      if dm.existeOpenSSL() then
      begin
        key:=' genrsa -out "'+ruta+'MiClavePrivada" 2048';
        csr:=' req -new -key "'+ruta+'MiClavePrivada" -subj "/C=AR/O='+subj_o+'/CN='+subj_cn+'/serialNumber=CUIT '+subj_cuit+'" -out "'+ruta+'MiPedido.CSR"';
        // -subj "/C=AR/O=subj_o/CN=subj_cn/serialNumber=CUIT subj_cuit" -out pedido
        pfx:=' pkcs12 -export -inkey "'+ruta+'MiClavePrivada" -in "'+ruta+'certificado.crt" -out "'+ruta+'certificado.pfx"';
        Ejecutar(openssl+key);
        Sleep(1000);
        Ejecutar(openssl+csr);
        Sleep(1000);
        Memo1.Lines.LoadFromFile(ruta+'MiPedido.CSR');
        SaveTextFileDialog1.FileName:=System.IOUtils.TPath.GetDocumentsPath()+'\MiPedido.CSR';
        SaveTextFileDialog1.Execute();
        Memo1.Lines.SaveToFile(SaveTextFileDialog1.FileName);
        ShellExecute(Handle,'open','http://www.afip.gob.ar/ws/WSAA/wsaa_obtener_certificado_produccion.pdf',nil,nil,SW_NORMAL);
      end
      else
      begin
          ShowMessage('Seleccione el ejectutable de OpenSSL para continuar...');
          OpenTextFileDialog1.Execute();
          f := OpenTextFileDialog1.FileName;
          if not FileExists(f) then
          begin
            ShowMessage('Por favor instalar opensssl');
            OpensslButton.Click;
          end;
      end;
    end;
  end;
end;

procedure TAfipForm.FormCreate(Sender: TObject);
var
  r: string;
begin
  r := Path+'db\certificado.crt';
  if FileExists(r) then
    Memo1.Lines.LoadFromFile(r)
  else
    Memo1.Lines.add('No se encuentra certificado, por favor generarlo');
end;

procedure TAfipForm.OpensslButtonClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','https://slproweb.com/products/Win32OpenSSL.html',nil,nil,SW_NORMAL);
end;

procedure TAfipForm.ProbarButtonClick(Sender: TObject);
begin
  AfipDataModule := TAfipDataModule.Create(self);
  try
      AfipDataModule.Generar;
  finally
    AfipDataModule.Free;
  end;
  Memo1.Lines.LoadFromFile(ruta + 'TA.XML');
end;

procedure TAfipForm.PuntoVentaButtonClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','https://serviciosweb.afip.gob.ar/genericos/guiasPasoPaso/VerGuia.aspx?id=135',nil,nil,SW_NORMAL);
end;

procedure TAfipForm.SubscripcionButtonClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',
          'https://articulo.mercadolibre.com.ar/MLA-757192136-sistema-gen-facturacion-stock-monotributo-ingresos-brutos-_JM'
          ,nil,nil,SW_NORMAL);
end;

end.
