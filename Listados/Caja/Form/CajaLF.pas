unit CajaLF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ComCtrls, StdCtrls, Buttons, ExtCtrls, DataModule, Grids,
  DBGrids, ImprimirDM, DBCtrls,
  IBCustomDataSet, IBQuery, OleCtrls, SHDocVw, jpeg;

type
  TCajaLForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    DTP1: TDateTimePicker;
    DTP2: TDateTimePicker;
    SiBitBtn: TBitBtn;
    Saldo: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Debe: TLabel;
    Haber: TLabel;
    DataSource: TDataSource;
    BitBtn3: TBitBtn;
    CuentaDataSource: TDataSource;
    DBGrid2: TDBGrid;
    Tabla: TIBQuery;
    CuentaT: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure DTP1CloseUp(Sender: TObject);
    procedure DTP2CloseUp(Sender: TObject);
    procedure SiBitBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
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
  CajaLForm: TCajaLForm;
  Compartido: PCompartido;
  FicheroM: THandle;

implementation

{$R *.dfm}

Procedure TCajaLForm.EnvioRamTerminado;
begin
  UnmapViewOfFile(Compartido);
  CloseHandle(FicheroM);
end;

procedure TCajaLForm.FormCreate(Sender: TObject);
begin
  DM := TDM.Create(self);
  CuentaT.Open;
  CuentaT.Last;
  DTP2.Date := Now + 1;
end;

procedure TCajaLForm.DTP1CloseUp(Sender: TObject);
begin
  If DTP1.Date > DTP2.Date then
  begin
    MessageDlg('Fecha de inicio no puede ser mayor que fecha de fin.', mtError,
      [mbOK], 0);
    DTP1.DateTime := DTP2.DateTime;
  end;
end;

procedure TCajaLForm.DTP2CloseUp(Sender: TObject);
begin
  If DTP2.Date < DTP1.Date then
  begin
    MessageDlg('Fecha de fin no puede ser menor que fecha de inicio.', mtError,
      [mbOK], 0);
    DTP2.DateTime := DTP1.DateTime;
  end;
end;

procedure TCajaLForm.SiBitBtnClick(Sender: TObject);
var
  i: Integer;
  caja: string;
begin
  Tabla.SQL.Text := 'SELECT DESCRIPCION FROM "Cuenta" WHERE CODIGO=' +
    DM.ConfigQuery.FieldByName('CTACAJA').AsString;
  Tabla.Open;
  caja := Tabla.FieldByName('DESCRIPCION').AsString;
  Debe.Caption := '0';
  Haber.Caption := '0';
  Saldo.Caption := '0';
  Tabla.SQL.Text := 'SELECT ' +
    '  ("LibroDiario".DEBE - "LibroDiario".HABER) AS SubTotal,' + '  ' +
    QuotedStr(DM.ConfigQuery.FieldByName('Nombre').AsString) + ' AS Empresa, ' +
    '  ' + QuotedStr(DateToStr(DTP1.Date)) + ' AS Desde,  ' + '  ' +
    QuotedStr(DateToStr(DTP2.Date)) + ' AS Hasta, ' +
    '  "LibroDiario".CODIGO,   ' + '  "LibroDiario".ASIENTO, ' +
    '  "LibroDiario".FECHA,   ' + '  "LibroDiario".LEYENDA,  ' +
    '  "LibroDiario".JERARQUIA, ' + '  "LibroDiario".CUENTA, ' +
    '  "LibroDiario".DEBE,  ' + '  "LibroDiario".HABER,  ' +
    '  "LibroDiario".OCULTO ' + ' FROM           ' + '  "LibroDiario"   ' +
    ' WHERE        ' + '  ("LibroDiario".FECHA >= ' +
    QuotedStr(DateToStr(DTP1.Date)) + ' ) AND ' + '  ("LibroDiario".FECHA <= ' +
    QuotedStr(DateToStr(DTP2.Date)) + ' ) AND  ' + '  ("LibroDiario".CUENTA = '
    + QuotedStr(caja) + ')  ' + ' ORDER BY     ' +
    '  "LibroDiario".CODIGO  ' + '';
  Tabla.Open;
  for i := 1 to Tabla.RecordCount do
  begin
    Debe.Caption := FloatToStr(StrToFloat(Debe.Caption) +
      Tabla.FieldByName('DEBE').AsFloat);
    Haber.Caption := FloatToStr(StrToFloat(Haber.Caption) +
      Tabla.FieldByName('HABER').AsFloat);
    Saldo.Caption := FloatToStr(StrToFloat(Debe.Caption) -
      StrToFloat(Haber.Caption));
    Tabla.Next;
  end;
end;

procedure TCajaLForm.FormDestroy(Sender: TObject);
begin
  EnvioRamTerminado;
end;

procedure TCajaLForm.BitBtn3Click(Sender: TObject);
begin
  ImprimirDataModule := TImprimirDataModule.Create(self);
  ImprimirDataModule.SImpr(Tabla.SQL.Text, 'LibroDiario');
  ImprimirDataModule.Free;
end;

end.
