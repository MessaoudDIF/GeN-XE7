unit LibroIVAVentasF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ImprimirDM, ComCtrls, StdCtrls, Buttons, ExtCtrls, DataModule,
  Grids, DBGrids, OleCtrls, SHDocVw, jpeg, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TCuentasForm = class(TForm)
    DBGrid1: TDBGrid;
    DS: TDataSource;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Tabla: TIBQuery;
    TablaEmpresa: TIBStringField;
    TablaDesde: TIBStringField;
    TablaHasta: TIBStringField;
    TablaCODIGO: TIntegerField;
    TablaFECHA: TDateTimeField;
    TablaFACTURA: TIBStringField;
    TablaCLIENTE: TIBStringField;
    TablaCUIT: TIBStringField;
    TablaCONDICION: TIBStringField;
    TablaNG1: TFloatField;
    TablaNG2: TFloatField;
    TablaNG3: TFloatField;
    TablaIVA1: TFloatField;
    TablaIVA2: TFloatField;
    TablaIVA3: TFloatField;
    TablaOEIIBB: TFloatField;
    TablaIDERPYPAC: TFloatField;
    TablaITF: TFloatField;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    DTP1: TDateTimePicker;
    DTP2: TDateTimePicker;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure DTP1CloseUp(Sender: TObject);
    procedure DTP2CloseUp(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    Procedure EnvioRamTerminado;
    { Private declarations }
  public
    Cancela: Boolean;
    Reporte, Cuenta: String;
    { Public declarations }
  end;

type
  TCompartido = record
    Numero: Integer;
    Cadena: String[20];
  end;

  PCompartido = ^TCompartido;

var
  CuentasForm: TCuentasForm;
  Compartido: PCompartido;
  FicheroM: THandle;

implementation

{$R *.dfm}

Procedure TCuentasForm.EnvioRamTerminado;
begin
  UnmapViewOfFile(Compartido);
  CloseHandle(FicheroM);
end;

procedure TCuentasForm.FormCreate(Sender: TObject);
begin
  // DM := TDM.Create(Self);
  DM.ConfigQuery.Open;
  DTP2.DateTime := Now;
end;

procedure TCuentasForm.DTP1CloseUp(Sender: TObject);
begin
  If DTP1.Date > DTP2.Date then
  begin
    MessageDlg('Fecha de inicio no puede ser mayor que fecha de fin.', mtError,
      [mbOK], 0);
    DTP1.DateTime := DTP2.DateTime;
  end;
end;

procedure TCuentasForm.DTP2CloseUp(Sender: TObject);
begin
  If DTP2.Date < DTP1.Date then
  begin
    MessageDlg('Fecha de fin no puede ser menor que fecha de inicio.', mtError,
      [mbOK], 0);
    DTP2.DateTime := DTP1.DateTime;
  end;
end;

procedure TCuentasForm.BitBtn2Click(Sender: TObject);
begin
  Cancela := true;
  Close;
end;

procedure TCuentasForm.BitBtn1Click(Sender: TObject);
begin
  Tabla.SQL.Text := 'SELECT ' + '  ' +
    QuotedStr(DM.ConfigQuery.FieldByName('Nombre').AsString) + ' AS Empresa, ' +
    '  ' + QuotedStr(DateToStr(DTP1.Date)) + ' AS Desde,  ' + '  ' +
    QuotedStr(DateToStr(DTP2.Date)) + ' AS Hasta, ' +
    '  "LibroIVAventa".CODIGO, "LibroIVAventa".FECHA,    ' +
    '  "LibroIVAventa".FACTURA, "LibroIVAventa".CLIENTE,  ' +
    '  "LibroIVAventa".CUIT, "LibroIVAventa".CONDICION, ' +
    '  "LibroIVAventa".NG1, "LibroIVAventa".NG2,      ' +
    '  "LibroIVAventa".NG3, "LibroIVAventa".IVA1,    ' +
    '  "LibroIVAventa".IVA2, "LibroIVAventa".IVA3,     ' +
    '  "LibroIVAventa".OEIIBB, "LibroIVAventa".IDERPYPAC,  ' +
    '  "LibroIVAventa".ITF'
    +' FROM "LibroIVAventa"'
    + 'WHERE                ' +
    '  ("LibroIVAventa".FECHA >= ' + QuotedStr(DateToStr(DTP1.Date)) + ' ) AND '
    + '  ("LibroIVAventa".FECHA <= ' + QuotedStr(DateToStr(DTP2.Date)) + ' )   '
    + 'ORDER BY  ' + '  "LibroIVAventa".CODIGO' + '';
  Tabla.Open;
end;

procedure TCuentasForm.FormDestroy(Sender: TObject);
begin
  EnvioRamTerminado;
end;

procedure TCuentasForm.Image1Click(Sender: TObject);
begin
  ImprimirDataModule := TImprimirDataModule.Create(Self);
  ImprimirDataModule.CSV(Tabla.SQL.Text, 'LIBRO IVA VENTAS');
  ImprimirDataModule.Free;
end;

procedure TCuentasForm.BitBtn3Click(Sender: TObject);
begin
  if Tabla.Active = true then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(Self);
    ImprimirDataModule.SImpr(Tabla.SQL.Text, 'libroIVAVentas');
    ImprimirDataModule.Free;
  end;
end;

end.
