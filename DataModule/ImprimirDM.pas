unit ImprimirDM;

interface

uses
  SysUtils, Classes, DataModule, Dialogs, frxClass, frxCrypt, frxGZip,
  frxGradient, frxChBox, frxRich, frxOLE, frxChart, frxExportCSV, frxExportHTML,
  frxExportPDF, frxDMPExport, frxBarcode, frxDBSet, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TImprimirDataModule = class(TDataModule)
    Query: TIBQuery;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxCSVExport1: TfrxCSVExport;
    frxChartObject1: TfrxChartObject;
    frxOLEObject1: TfrxOLEObject;
    frxRichObject1: TfrxRichObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxDotMatrixExport2: TfrxDotMatrixExport;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxCrypt1: TfrxCrypt;
    FirebirdConnection: TFDConnection;
    VentasFDQuery1: TFDQuery;
    FDQuery1: TFDQuery;
    Function VTA(nro, let: string): string;
    Function OPER(nro, let: string): string;
    Function PRE(nro, let: string): string;
    Function PlanillaCobrador(nro, let: string): string;
    Function Contrato(nro, let: string): string;
    Function EAN(nro: string): string;
    Procedure Impr(vsql, reporte: string);
    Procedure CSV(sql, n: string);
    Procedure SImpr(vsql, reporte: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImprimirDataModule: TImprimirDataModule;

implementation

{$R *.dfm}

Procedure TImprimirDataModule.SImpr;
begin
  Query.sql.Text := vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(Path + 'rpt\' + reporte + '.fr3');
    try
      ShowReport(True);
    finally
      Free;
    end;
  end;
end;

Procedure TImprimirDataModule.CSV; // exporta consulta a excel
var
  m: TStringList;
  g: TSaveDialog;
  CSV: TextFile;
  col: string;
  // ? f,c :integer;
  c: integer;
begin
  Query.sql.Text := sql;
  Query.Open;
  try
    m := TStringList.Create;
    g := TSaveDialog.Create(Self);
  finally
    g.Filter := 'Ficheros Excel (*.csv)|*.csv|Todos los ficheros|*.*';
    g.Title := n;
    g.DefaultExt := 'csv';
    g.FileName := n;
    // ingresa los campos
    for c := 0 to Query.FieldCount - 1 do // columnas
    begin
      col := col + '"' + Query.Fields.Fields[c].DisplayName + '",';
    end;
    m.Append(col);
    // ingresa el contenido
    while not Query.Eof do // filas
    begin
      col := '';
      for c := 0 to Query.FieldCount - 1 do // columnas
      begin
        col := col + '"' + Query.Fields.Fields[c].AsString + '",';
      end;
      m.Append(col);
      Query.Next;
    end;
    if g.Execute then
    begin
      assignFile(CSV, g.FileName);
      rewrite(CSV);
      write(CSV, m.Text);
      closeFile(CSV);
    end;
  end;
  m.Free;
  g.Free;
end;

procedure TImprimirDataModule.DataModuleCreate(Sender: TObject);
begin
  DM.ConfigQuery.Open;
end;

procedure TImprimirDataModule.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
begin
  //if Sender.Name = 'LOGO' then
   // begin
//       TfrxPictureView(Sender).Visible := True;
//       TfrxPictureView(Sender).Picture.LoadFromFile(path + 'img\empresa.BMP');
    //end;
end;

procedure TImprimirDataModule.Impr;
var
   Pict,Pict2,Pict3,Pict4: TfrxPictureView;
begin
  if reporte = '' then
    reporte := dm.ConfigQuery.FieldByName('Reporte').AsString;
  Query.sql.Text := 'SELECT '
  + QuotedStr(dm.ConfigQuery.FieldByName('NOMBRE').AsString)+ ' As Empresa,'
  + QuotedStr(dm.ConfigQuery.FieldByName('CODIGOAREA').AsString)+ ' As ECODIGOAREA,'
  + QuotedStr(dm.ConfigQuery.FieldByName('TELEFONO').AsString)+ ' As ETELEFONO,'
  + QuotedStr(dm.ConfigQuery.FieldByName('DIRECCIONCOMERCIAL').AsString)+ ' As EDIRECCIONCOMERCIAL,'
  + QuotedStr(dm.ConfigQuery.FieldByName('CP').AsString)+ ' As ECP,'
  + QuotedStr(dm.ConfigQuery.FieldByName('DEPARTAMENTO').AsString)+ ' As EDEPARTAMENTO,'
  + QuotedStr(dm.ConfigQuery.FieldByName('PROVINCIA').AsString)+ ' As EPROVINCIA,'
  + vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(Path + 'rpt\' + reporte + '.fr3');
    if (reporte = 'COriginal') or (reporte = 'Presupuesto' ) then
    begin
    //Pict:= frReport1.FindObject('MyImage') as TfrxPictureView;
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(pict) then Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end else if reporte = 'CDuplicado' then
    begin
      pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(pict) then Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(pict2) then Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end else if reporte = 'CTriplicado' then
    begin
      pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(pict) then Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(pict2) then Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(pict3) then Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end else if reporte = 'CCuadriplicado' then
    begin
      pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(pict) then Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(pict2) then Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(pict3) then Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
      pict4 := TfrxPictureView(frxReport1.FindObject('Picture4'));
      if Assigned(pict4) then Pict4.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end;
    try
      ShowReport(True);
    finally
      Free;
//      FreeAndNil(pict);
    end;
  end;
end;

Function TImprimirDataModule.PRE;
begin
  Result := '  "Cliente".NOMBRE,' + '  "Cliente".TITULAR,' +
    '  "Cliente".DIRECCION,' + '  "Cliente".DIRECCIONCOMERCIAL,' +
    '  "Articulo".DESCRIPCION,' + '  "Articulo".UNIDAD,' +
    '  "PresupuestoItem".ARTICULO,' + '  "PresupuestoItem".CANTIDAD,' +
    '  "PresupuestoItem".PRECIO,' + '  "PresupuestoItem".OPERACION,' +
    '  ("PresupuestoItem".PRECIO * "PresupuestoItem".CANTIDAD ) as PREXCANT,' +
    '  "PresupuestoItem".SERVICIO,' +
    '  "PresupuestoItem".DESCRIPCION AS DESCR,' + '  "Presupuesto".CODIGO,' +
    '  "Presupuesto".LETRA,' + '  "Presupuesto".FECHA,' +
    '  "Presupuesto".COMPROBANTE,' + '  "Presupuesto".IVA3,' +
    '  "Presupuesto".TOTAL,' + '  "Presupuesto".CONTADO,' +
    '  "Presupuesto".CLIENTE,' + '  "Presupuesto".SUBTOTAL,' +
    '  "Presupuesto".DESCUENTO,' + '  "Presupuesto".IMPUESTO,' +
    '  "Presupuesto".IVA2,' + '  "Presupuesto".IVA1,' +
    '  "Presupuesto".EXCENTO,' + '  "Presupuesto".SALDO,' +
    '  "Presupuesto".PAGADO' + ' FROM' + '  "Presupuesto"' +
    '  INNER JOIN "PresupuestoItem" ON ("Presupuesto".CODIGO = "PresupuestoItem".OPERACION)'
    + '  INNER JOIN "Articulo" ON ("PresupuestoItem".ARTICULO = "Articulo".CODIGO)'
    + '  INNER JOIN "Cliente" ON ("Presupuesto".CLIENTE = "Cliente".CODIGO)' +
    '  WHERE' + '  ("Presupuesto".CODIGO = ' + nro + '  ) AND' +
    '  ("Presupuesto".LETRA = ' + QuotedStr(let) + '  )' + '';
end;

Function TImprimirDataModule.VTA;
begin
  Result := '  "Cliente".NOMBRE,' + '  "Cliente".TITULAR,' +
    '  "Cliente".DIRECCION,' + '  "Cliente".DIRECCIONCOMERCIAL,' +
    '  "Articulo".DESCRIPCION,' +  '  "Articulo".UNIDAD,' +
    '  "VentaItem".ARTICULO,' + '  "VentaItem".CANTIDAD,' +
    '  "VentaItem".PRECIO,' + '  "VentaItem".OPERACION,' +
    '  ("VentaItem".PRECIO * "VentaItem".CANTIDAD ) as PREXCANT,' +
    '  "VentaItem".SERVICIO,' + '  "VentaItem".DESCRIPCION AS DESCR,' +
    '  "Venta".CODIGO,' + '  "Venta".LETRA,' + '  "Venta".FECHA,' +
    '  "Venta".COMPROBANTE,' + '  "Venta".IVA3,' + '  "Venta".TOTAL,' +
    '  "Venta".CONTADO,' + '  "Venta".CLIENTE,' + '  "Venta".SUBTOTAL,' +
    '  "Venta".DESCUENTO,' + '  "Venta".IMPUESTO,' + '  "Venta".IVA2,' +
    '  "Venta".IVA1,' + '  "Venta".EXCENTO,' + '  "Venta".SALDO,' +
    '  "Venta".PAGADO' + ' FROM' + '  "Venta"' +
    '  INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OPERACION)' +
    '  INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo".CODIGO)' +
    '  INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIGO)' + ' WHERE'
    + '  ("Venta".CODIGO = ' + nro + ' ) AND' + '  ("Venta".LETRA = ' +
    QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.OPER;
begin
  Result := '  "Cliente".NOMBRE,' + '  "Cliente".TITULAR,' +
    '  "Cliente".DIRECCION,' + '  "Cliente".DIRECCIONCOMERCIAL,' +
    '  "Articulo".DESCRIPCION,' + '  "Articulo".UNIDAD,' +
    '  "OperacionItem".ARTICULO,' + '  "OperacionItem".CANTIDAD,' +
    '  "OperacionItem".PRECIO,' + '  "OperacionItem".OPERACION,' +
    '  ("OperacionItem".PRECIO * "OperacionItem".CANTIDAD ) as PREXCANT,' +
    '  "OperacionItem".SERVICIO,' + '  "OperacionItem".DESCRIPCION AS DESCR,' +
    '  "Operacion".CODIGO,' + '  "Operacion".LETRA,' + '  "Operacion".FECHA,' +
    '  "Operacion".COMPROBANTE,' + '  "Operacion".IVA3,' +
    '  "Operacion".TOTAL,' + '  "Operacion".CONTADO,' + '  "Operacion".CLIENTE,'
    + '  "Operacion".SUBTOTAL,' + '  "Operacion".DESCUENTO,' +
    '  "Operacion".IMPUESTO,' + '  "Operacion".IVA2,' + '  "Operacion".IVA1,' +
    '  "Operacion".EXCENTO,' + '  "Operacion".SALDO,' + '  "Operacion".PAGADO' +
    ' FROM' + '  "Operacion"' +
    '  INNER JOIN "OperacionItem" ON ("Operacion".CODIGO = "OperacionItem".OPERACION)'
    + '  INNER JOIN "Articulo" ON ("OperacionItem".ARTICULO = "Articulo".CODIGO)'
    + '  INNER JOIN "Cliente" ON ("Operacion".CLIENTE = "Cliente".CODIGO)' +
    ' WHERE' + '  ("Operacion".CODIGO = ' + nro + ' ) AND' +
    '  ("Operacion".LETRA = ' + QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.PlanillaCobrador;
begin
  Result := '"Cobrador".NOMBRE AS COBRADOR, "Cliente".ZONA,'
    +' "CtaCte".FECHA, "CtaCte".SALDO, "Cliente".NOMBRE AS CLIENTE,'
    +' "CtaCteItem".IMPORTE, "CtaCte".ARTICULO as CB, "CtaCteItem".VENCE,'
    +' "CtaCteItem".CUOTA, "CtaCte".OPERACION'
    +' FROM "CtaCte"'
    +' INNER JOIN "CtaCteItem" ON ("CtaCte".CLIENTE = "CtaCteItem".CLIENTE) AND ("CtaCte".OPERACION = "CtaCteItem".OPERACION)'
    +' INNER JOIN "Cliente" ON ("CtaCteItem".CLIENTE = "Cliente".CODIGO)'
    +' INNER JOIN "Cobrador" ON ("CtaCte".COBRADOR = "Cobrador".CODIGO)'
    +' WHERE ("CtaCte".OPERACION = '+nro+')'
    +' ORDER BY "CtaCteItem".CUOTA';
end;

Function TImprimirDataModule.Contrato;
begin
  Result := 'CODIGO, NUMERO, FECHA, TIPO, DIA, DESCRITO, MES, MESCRITO, ANO, AESCRITO, '
    + 'CANONES, CIMPORTE, CIESCRITO, IMPORTETOTAL, ITESCRITO, TIEMPO, T2, BIEN, '
    + 'DADOR, DTIPO, DNOMBRE, DAPELLIDO, DDOCUMENTO, DDTIPO, DDOMICILIO, DDNUMERO, '
    + 'DCIUDAD, DPROVINCIA, DPAIS, TOMADOR, TTIPO, TNOMBRE, TAPELLIDO, TDOCUMENTO, '
    + 'TDTIPO, TDOMICILIO, TDTRABAJO, TCIUDAD, TPROVINCIA, TPAIS ' +
    'FROM "Contrato" WHERE NUMERO=' + nro;
end;

Function TImprimirDataModule.EAN;
begin
  Result := nro + 'as CODIGOBARRA FROM "Empresa"';
end;

end.
