﻿// ******************************************************************************
// * DeGsoft GeN                                                                *
// * ===========                                                                *
// * GeN(tm) : ERP Software (http://www.civeloo.com)                            *
// * Copyright (c) 2002-2019 by the Civeloo                                     *
// * For more information visit: http://www.civeloo.com                         *
// * This program is free software. You can redistribute it and/or modify       *
// * it under the terms of the GNU General Public License as published by       *
// * the Free Software Foundation; either version 3 of the License.             *
// ******************************************************************************

unit OperacionDM;

interface

uses
  SysUtils, Classes, DB, DataModule, ImprimirDM, Dialogs, Controls, DateUtils,
  IBX.IBCustomDataSet, IBX.IBQuery, Math, AfipDM, System.JSON, RestDM, System.Ansistrings;

type
  matriz = array of array of string;

  TOperacionDataModule = class(TDataModule)
    Q: TIBQuery;
    T: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    nro, comp, a, pagare, cae, vto, mensaje//, ptovta, tipocbte
    : string;
    i: integer;
    IIBB, cmv: Double;
    jsResponse: TJSONValue;
    function CalcularIVA(monto,porcentaje:Double):Double;
    function SacarIVA(monto,porcentaje:Double):Double;
    function ProcVTA(let, cod, fech, ven, cui, ctan: string; pre, pgr,impr: Boolean;
      cost, comv, impu, cheq, ch3q, cont, tot, sbt, des, tarj, otr, sal, pag,
      int, n10, n21, i10, i21, deud, ulc: Double):Boolean;
    Procedure ProcOPER(tipo, let, cod, fech, ven, cui, ctan: string;
      pre, pgr, impr: Boolean; cost, comv, impu, cheq, ch3q, cont, tot, sbt, des,
      tarj, otr, sal, pag, int, n10, n21, i10, i21, deud, ulc: Double);
    Procedure ProcCompra(let, cod, fech, ven, com, ctan,cui: string; pgr: Boolean;
      cost, impu, cheq, ch3q, cont, tot, sbt, des, tarj, otr, sal, pag, n10,
      n21, i10, i21, perc, deud: Double);
    Procedure ProcPlan(let, cod, ven, cui, ctan, cuoimp, cuocant, cob: string;
      fecha: TDateTime; pre, pgr: Boolean; cost, comv, impu, cheq, ch3q, cont,
      tot, sbt, des, tarj, otr, sal, pag, inte, n10, n21, i10, i21, deud,
      ulc: Double);
    Procedure ProcPresup(let, cod, fec, ven, cui, cno: string;
      pre, pgr: Boolean; cost, comv, impu, che, ch3q, cont, tot, sbt, des, tarj,
      otr, sal, pag, int, n10, n21, i10, i21, deud, ulc: Double);
    Procedure AnularVTA(nro: string);
    Procedure CtaCte(tipo, cod, ctan: string; pag, cheq, ch3q, cont, tarj,
      sald: Double);
    function existeEnTabla(tabla,codigo: string): Boolean;
    procedure insertarTabla2(tabla,codigo,desc: string);
    Procedure FormaPago(desc, vta, comp, ctac, pago, cont, cheq, chei, chen,
      ched, chedi, tarj, tarn, tarimp, otri, mone, meim, metc, sald, paga, fech,
      ch3q, ch3i, ch3n, ch3d, ch3di: string);
    Function ArtNuevo(prec, desc: string): string;
    procedure FactRem(codRem,let, cod, fech, ven, cui, ctan: string; pre, pgr,impr: Boolean;
      cost, comv, impu, cheq, ch3q, cont, tot, sbt, des, tarj, otr, sal, pag,
      int, n10, n21, i10, i21, deud, ulc: Double);
    Procedure Asiento(ctan, nro, fech, det, d, h: string);
    Procedure LibroDiario(oper, nro, let, cod, fech: string; pgr: Boolean;
      tot, pag, cheq, ch3q, cont, tarj, impu, deud, cmv, comv: Double);
    Procedure LibroIVAvta(fec, nro, cod, cui, n10, n21, i10, i21, tot: string);
    Procedure LibroIVACompra(fec, nro, cod, com, n10, n21, i10, i21, perc, tot: string);
    Function MesLetra(fech: TDate): string;
    Function CostMercVend(ulc, cost: Double): Double;
    procedure VarCos(cod, cant: string; cost: Double);
    procedure ExpCSV(sql: string);
    Procedure MovCaja(tipo, soc, imp, desc: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure CodigoBarra(cb: string);
    procedure BorrarArticulos;
    procedure ModificarArticulos(codigo, descripcion,
      ultcosto, costo, precio, precio1, precio2, disponible,
      porcentaje, impotros, unidad, tasa, iibb, ctanombre, ctatipo, ctaanticipo,ctaiibb,
      fecha, fechacompult, codigobarra,
      categoria, color, marca, proveedor, rubro, subcategoria : string);
    procedure ActualizarCantidadArticulo(codigo,cantidad:string);
    procedure DataSetToCsv(psRutaFichero : String);
    procedure WSFE(cbteFecha, let, concepto, docTipo, docNro, cbte, impNeto, impIva, impTotal, asocTipo, asocNro, n10, n21, i10, i21:string);
    function ObtenerNroComp(tipo:string):string;
    procedure ActualizarNroComp(tipo,comp: string);
  end;

var
  mat: matriz;
  OperacionDataModule: TOperacionDataModule;

const tipoIVA : array[1..3] of string = ('Responsable Monotributo','Responsable Inscripto','No Responsable');//,'Exento','S.R.L.','S.A.','Cooperativa');

implementation

{$R *.dfm}

Procedure TOperacionDataModule.MovCaja;
begin
  Q.sql.Text := 'INSERT INTO "MovCaja" (TIPO,SOCIO,IMPORTE,DESCRIPCION) ' +
    'VALUES (' + quotedstr(tipo) + ',' + soc + ',' + imp + ',' + quotedstr(desc)
    + '' + ')';
  Q.ExecSQL;
  // Insertar en la tabla LibroDiario
  LibroDiario(tipo + ' CAJA', '', '', soc, '', false, strtofloat(imp), 0, 0, 0,
    0, 0, 0, 0, 0, 0);
  Q.Transaction.CommitRetaining;
end;

Procedure TOperacionDataModule.ExpCSV;
begin
  T.sql.Text := sql;
  T.Open;
end;

Function TOperacionDataModule.ArtNuevo;
var
  nro: string;
begin
  nro := inttostr(DM.UltimoRegistro('"Articulo"', 'CODIGO'));
  Q.sql.Text := 'INSERT INTO "Articulo" (CODIGO, DESCRIPCION, COSTO, ULTCOSTO, '
    + ' PRECIO1, PRECIO2, PRECIO3, PRECIO4, ' +
    ' PRECIO5, PRECIO6, PRECIO, PORCENTAJE, ' +
    ' ULTPRECIO, MARCA, COLOR, CATEGORIA, ' +
    ' SUBCATEGORIA, UBICACION, UNIDAD, DISPONIBLE, ' +
    ' ENPRODUCCION, NOTAS, IVA, TASA, ' +
    ' IMPOTROS, IIBB, STOCKMINIMO, STOCKMAXIMO, ' +
    ' STOCKVENDIDO, FECHACOMPULT, LISTA, PROCEDENCIA, ' +
    ' CODIGOBARRA, RUBRO, PROVEEDOR, GARANTIA, ' +
    ' FECHA, PEDIDO, STOCK, EXISTENTE, ' +
    ' ACTUAL, MARCADOCONTADO, MARCADOLISTA, MARCADOFINAL, ' +
    ' PREPARADO, CTANOMBRE, CTATIPO, CTAANTICIPO, ' +
    ' CTAIIBB, ESTADO, VENCE, VENCIMIENTO) VALUES ' + ' (' + nro + ', ' +
    quotedstr(desc) + ', 0, 0, ' + ' ' + prec + ', ' + prec + ', ' + prec + ', '
    + prec + ', ' + ' ' + prec + ', ' + prec + ', ' + prec + ', 0, ' + ' ' +
    prec + ', 0, 0, 0, ' + ' 0, NULL, ''c/u'', 0, ' + ' NULL, NULL, NULL, 0, ' +
    ' 0, 1, NULL, NULL, ' + ' NULL, ' +
    quotedstr(FormatDateTime('mm/dd/yyyy hh:mm:ss', now)) + ', NULL, NULL, ' +
    ' '''', 0, 1, NULL, ' + ' ' +
    quotedstr(FormatDateTime('mm/dd/yyyy hh:mm:ss', now)) +
    ', NULL, NULL, NULL, ' + ' NULL, NULL, NULL, NULL, ' + ' NULL, 13, 13, 13, '
    + ' 66, NULL, NULL, NULL);';
  Q.ExecSQL;
  result := nro;
end;

procedure TOperacionDataModule.VarCos;

  function roundp(pp: Double): Double;
  begin
    if pp < 1 then
      result := (pp)
    else
      result := strtofloat(Format('%8.2f', [pp]));
  end;

var
  porc: Double;
  p1, p2, p3, p4, p5, p6, p: Double;
begin
  with dm do
  begin
    p1 := ConfigQuery.FieldByName('PP1').AsFloat / 100 + 1;
    p2 := ConfigQuery.FieldByName('PP2').AsFloat / 100 + 1;
    p3 := ConfigQuery.FieldByName('PP3').AsFloat / 100 + 1;
    p4 := ConfigQuery.FieldByName('PP4').AsFloat / 100 + 1;
    p5 := ConfigQuery.FieldByName('PP5').AsFloat / 100 + 1;
    p6 := ConfigQuery.FieldByName('PP6').AsFloat / 100 + 1;
    p := ConfigQuery.FieldByName('PP').AsFloat / 100 + 1;
  end;
  // VARIACION DE COSTO
  T.sql.Text := 'SELECT * FROM "Articulo" WHERE CODIGO=' + cod;
  T.Open;
  // PROCENTAJE DE VARIACION (costo * 100 / ultcosto) / 100
  if T.FieldByName('ULTCOSTO').AsFloat <> 0 then
    porc := ((cost * 100 / T.FieldByName('ULTCOSTO').AsFloat) / 100)
  else
    porc := 1;
  // REDONDEAR SOLO SI ES MAYOR QUE 1
  if T.FieldByName('PRECIO1').AsFloat <> 0 then
    p1 := roundp(T.FieldByName('PRECIO1').AsFloat * porc)
  else
    p := roundp(cost * p1);
  if T.FieldByName('PRECIO2').AsFloat <> 0 then
    p2 := roundp(T.FieldByName('PRECIO2').AsFloat * porc)
  else
    p := roundp(cost * p2);
  if T.FieldByName('PRECIO3').AsFloat <> 0 then
    p3 := roundp(T.FieldByName('PRECIO3').AsFloat * porc)
  else
    p := roundp(cost * p3);
  if T.FieldByName('PRECIO4').AsFloat <> 0 then
    p4 := roundp(T.FieldByName('PRECIO4').AsFloat * porc)
  else
    p := roundp(cost * p4);
  if T.FieldByName('PRECIO5').AsFloat <> 0 then
    p5 := roundp(T.FieldByName('PRECIO5').AsFloat * porc)
  else
    p := roundp(cost * p5);
  if T.FieldByName('PRECIO6').AsFloat <> 0 then
    p6 := roundp(T.FieldByName('PRECIO6').AsFloat * porc)
  else
    p := roundp(cost * p6);
  if T.FieldByName('PRECIO').AsFloat <> 0 then
    p := roundp(T.FieldByName('PRECIO').AsFloat * porc)
  else
    p := roundp(cost * p);
  //
  Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE + ' + cant +
    ', ULTCOSTO = COSTO ' + ', COSTO = ' + floattostr(cost) + ', PRECIO = ' +
    floattostr(p) + ', PRECIO1 = ' + floattostr(p1) + ', PRECIO2 = ' +
    floattostr(p2) + ', PRECIO3 = ' + floattostr(p3) + ', PRECIO4 = ' +
    floattostr(p4) + ', PRECIO5 = ' + floattostr(p5) + ', PRECIO6 = ' +
    floattostr(p6) + ' Where ' + ' CODIGO = ' + cod;
  Q.ExecSQL;
end;

Function TOperacionDataModule.CostMercVend;
begin
  // COSTO DE MERCADERIAS VENDIDAS
  if dm.ConfigQuery.FieldByName('CMV').AsString = 'PPP' then
    result := ((ulc + cost) / 2)
  else if dm.ConfigQuery.FieldByName('CMV').AsString = 'FIFO' then
    result := ulc
  else
    result := cost; // if cosMercaderiaVendida = 'LIFO' then
end;

Function TOperacionDataModule.MesLetra;
var
  mes: string;
begin
  mes := FormatDateTime('mm', fech);
  // fomula mes
  if mes = '01' then
    mes := 'Enero'
  else if mes = '02' then
    mes := 'Febrero'
  else if mes = '03' then
    mes := 'Marzo'
  else if mes = '04' then
    mes := 'Abril'
  else if mes = '05' then
    mes := 'Mayo'
  else if mes = '06' then
    mes := 'Junio'
  else if mes = '07' then
    mes := 'Julio'
  else if mes = '08' then
    mes := 'Agosto'
  else if mes = '09' then
    mes := 'Septiembre'
  else if mes = '10' then
    mes := 'Octubre'
  else if mes = '11' then
    mes := 'Noviembre'
  else if mes = '12' then
    mes := 'Diciembre';
  result := mes;
end;

Procedure TOperacionDataModule.ProcPlan;
var
  i, c, d, n, DiasCalculo: integer;
  Oculto, nro, mes, Dia, Ano, pagare, Tiempo, T2, codn, coddoc, coddirp,
    coddirt, fech: string;
  IIBB, cmv: Double;
  FechaVencimiento: TDate;
begin
  fech := FormatDateTime('mm/dd/yyyy hh:mm:ss', fecha);
  // INFORMACION DE CLIENTES
  T.sql.Text := 'SELECT * FROM "Cliente" WHERE CODIGO=' + cod;
  T.Open;
  codn := T.FieldByName('NOMBRE').AsString;
  coddoc := T.FieldByName('DOCUMENTO').AsString;
  coddirp := T.FieldByName('DIRECCION').AsString;
  coddirt := T.FieldByName('DIRECCIONCOMERCIAL').AsString;
  T.Close;
  if let = 'X' then
    Oculto := 'S';
  // + formula día mes año
  Dia := FormatDateTime('dd', fecha);
  mes := MesLetra(fecha);
  Ano := FormatDateTime('yyyy', fecha);
  nro := inttostr(DM.UltimoRegistro('"Venta"', 'CODIGO'));
  if nro = '1' then
    nro := inttostr(dm.ConfigQuery.FieldByName('NroFactura').AsInteger + 1);
  cmv := CostMercVend(ulc, cost);
  // INSERTA EN LA TABLA VENTA
  Q.sql.Text := 'Insert Into "Venta" (CODIGO, LETRA, CLIENTE, ' +
    ' SUBTOTAL, DESCUENTO, FECHA,' + ' IMPUESTO, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO' + ', PAGARE, COSTO, DEUDA, COMISION' +
    ') Values ' + '(' + nro + ', ' + quotedstr(let) + ', ' + cod + ', ' + ' ' +
    floattostr(sbt) + ', ' + floattostr(des) + ', ' + quotedstr(fech) + ', ' +
    floattostr(impu) + ', ' + floattostr(tot) + ', ' + floattostr(cont) + ', ' +
    floattostr(cheq) + ', ' + floattostr(tarj) + ', ' + floattostr(otr) + ', ' +
    floattostr(sal) + ', ' + floattostr(pag) + ',' + quotedstr(pagare) + ',' +
    floattostr(cmv) + ',' + floattostr(deud) + ',' + floattostr(comv) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de VENTAITEM
  for i := 1 to High(mat[0]) do
  begin
    // CALCULAR IIBB
    Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + quotedstr(mat[9, i]);
    Q.Open;
    if tot - impu > Q.FieldByName('MONTO').AsFloat then
      IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
        Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
    Q.sql.Text :=
      'Insert Into "VentaItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
      + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
      (mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
      quotedstr(mat[1, i]) + ');';
    Q.ExecSQL;
  end;
  // Insertar en la tabla de CtaCte
  Q.sql.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, CUOTAS, OPERACION,' +
    ' DESCUENTO, INTERES, FECHA, COBRADOR, RENDIDAS) Values (' + cod + ', ' +
    floattostr(sal) + ', ' + cuocant + ',' + nro + ', ' + floattostr(des) + ', '
    + floattostr(inte) + ', ' + quotedstr(fech) + ', ' + cob + ', 0' + ')';
  Q.ExecSQL;
  // Insertar en la tabla de CtaCte Item
  if sal > 0.04 then
  begin
    d := 0;
    FechaVencimiento := fecha;
    For i := 1 to High(mat[0]) do
    begin
      if mat[0, i] <> '1' then
        detalle := mat[1, i]
      else
        detalle := memo;
      For n := 1 to StrToInt(cuocant) do // ingreso de cuota
      begin
        FechaVencimiento := (fecha + (n * DiasCalculo)) + d;
        if DayOfTheWeek(FechaVencimiento) = 7 then
        begin
          FechaVencimiento := FechaVencimiento + 1;
          d := d + 1;
        end;
        Q.sql.Text := 'Insert Into "CtaCteItem" (CUOTA, OPERACION, CLIENTE,' +
          ' DESCRIPCION, IMPORTE, ' + ' VENCE, PAGADO) Values ' + '( ' +
          inttostr(n) + ', ' + nro + ',' + cod + ', ' + quotedstr(detalle) + ','
          + cuoimp + ', ' + quotedstr(FormatDateTime('mm/dd/yyyy',
          FechaVencimiento)) + ', 0)';
        Q.ExecSQL;
      end;
    end;
  end;
  // Insertar en RendidoVendedor
  if ven <> '' then
  begin
    comv := round(tot * (comv / 100));
    if comv = 0 then
      comv := 0;
    Q.sql.Text :=
      'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values' +
      ' (' + quotedstr(ven) + ', ' + nro + ', ' + Format('%8.2f', [comv]) + ', '
      + quotedstr(fech) + ')';
    Q.ExecSQL;
  end;
  // Actualizar la tabla de Articulos
  For i := 1 to High(mat[0]) do
  begin
    Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + mat[3, i]
      + ' Where ' + ' "Articulo".CODIGO = ' + (mat[0, i]);
    Q.ExecSQL;
  end;
  // Insertar en RendidoVendedor
  if ven <> '' then
  begin
    comv := round(tot * (comv / 100));
    if comv = 0 then
      comv := 0;
    Q.sql.Text :=
      'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values' +
      ' (' + quotedstr(ven) + ', ' + nro + ', ' + Format('%8.2f', [comv]) + ', '
      + quotedstr(fech) + ')';
    Q.ExecSQL;
  end;
  // Insertar en la tabla de Contrato
  if DiasCalculo = 7 then
  begin
    Tiempo := 'semanas';
    T2 := 'semanales';
  end
  else if DiasCalculo = 1 then
  begin
    Tiempo := 'd�as';
    T2 := 'diarios';
  end;
  // CONTRATO
  Q.sql.Text := 'Insert Into "Contrato" (NUMERO, DIA, MESCRITO, CANONES,' +
    ' DNOMBRE, DDTIPO, DDOCUMENTO, DDOMICILIO,' +
    ' TOMADOR, TNOMBRE, TDOCUMENTO, ' + ' TDOMICILIO, TDTRABAJO, BIEN,' +
    ' TIEMPO, T2, CIMPORTE, IMPORTETOTAL, FECHA) Values' + ' (' + nro + ', ' +
    quotedstr(Dia) + ', ' + quotedstr(mes) + ', ' + cuocant + ',' + ' ' +
    quotedstr(dm.ConfigQuery.FieldByName('Titular').AsString) + ', ''DNI'', ' +
    quotedstr(dm.ConfigQuery.FieldByName('Documento').AsString) + ', ' +
    quotedstr(dm.ConfigQuery.FieldByName('DireccionComercial').AsString) + ',' +
    ' ' + quotedstr(cod) + ', ' + quotedstr(codn) + ', ' + quotedstr(coddoc) +
    ',' + ' ' + quotedstr(coddirp) + ', ' + quotedstr(coddirt) + ', ' +
    quotedstr(mat[1, 1]) + ',' + ' ' + quotedstr(Tiempo) + ', ' + quotedstr(T2)
    + ', ' + cuoimp + ', ' + floattostr(tot) + ', ' + quotedstr(fech) +
    '' + ')';
  Q.ExecSQL;
  // Actualizar la tabla de Articulos
  For i := 1 to High(mat[0]) do
  begin
    Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + mat[3, i]
      + ' Where ' + ' "Articulo".CODIGO = ' + (mat[0, i]);
    Q.ExecSQL;
  end;
  // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA VENTAS
  if (let = 'A') or (let = 'B') then
    LibroIVAvta(fech, nro, cod, cui, floattostr(n10), floattostr(n21),
      floattostr(i10), floattostr(i21), floattostr(tot)); // en blanco
  // Insertar en la tabla LibroDiario
  LibroDiario('VENTA', nro, let, cod, fech, pgr, tot, pag, cheq, ch3q, cont,
    tarj, impu, deud, cmv, comv);
  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
  // IMPRIMIR
  if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(self);
    // VTA
    with ImprimirDataModule do
    begin
      Impr(vta(nro, let), '');
      ImprimirDataModule.Free;
      // Planes
      ImprimirDataModule := TImprimirDataModule.Create(self);
      Impr(Contrato(nro, let), 'ContratoLeasing');
      ImprimirDataModule.Free;
      // Planilla de Cobrador
      ImprimirDataModule := TImprimirDataModule.Create(self);
      Impr(PlanillaCobrador(nro, ''), 'Carton');
      ImprimirDataModule.Free;
    end;
  end;
end;

Procedure TOperacionDataModule.CtaCte;
var
  nro: integer;
  new: Boolean;
begin
  new := false;
  // CONSULTAR SI YA TIENE CTACTE
  Q.sql.Text := 'SELECT * FROM "CtaCte" WHERE ' + tipo + ' = ' + cod;
  Q.Open;
  if Q.RecordCount = 0 then
    new := True;
  // Insertar en la tabla de CtaCte
  if new = false then
    Q.sql.Text := 'Update "CtaCte" Set SALDO = SALDO - ' + floattostr(pag) +
      ' Where ' + tipo + ' = ' + cod
  else
    Q.sql.Text := 'Insert Into "CtaCte" (' + tipo + ', SALDO) Values (' + cod +
      ',' + floattostr(sald) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de CtaCte Item
  begin
    Q.sql.Text := 'Insert Into "CtaCteItem" (' + tipo +
      ', DESCRIPCION, PAGADO) Values' + '( ' + cod + ',''Entrega de Dinero'',' +
      floattostr(pag) + ')';
    Q.ExecSQL;
  end;
  // --CONTABILIDAD***************************************************************
  LibroDiario(tipo, '0', '', cod, fecha, false, 0, pag, cheq, ch3q, cont,
    tarj, 0, 0, 0, 0);
  // --CONTABILIDAD **************************************************************
  Q.Transaction.CommitRetaining;
end;

procedure TOperacionDataModule.DataModuleCreate(Sender: TObject);
begin
  dm.ConfigQuery.Open;
  Oculto := '0';
end;

Procedure TOperacionDataModule.LibroIVAvta; // Insertar en el Libro IVA Ventas
begin
  Q.sql.Text :=
    'Insert Into "LibroIVAventa" (FECHA, FACTURA, CLIENTE, CUIT, NG1, NG2, IVA1, IVA2, ITF) Values ( '
    + quotedstr(fec) + ', ' + quotedstr(nro) + ', ' + quotedstr(cod) + ', ' +
    quotedstr(cui) + ', ' + n10 + ', ' + n21 + ', ' + (i10) + ', ' + (i21) +
    ', ' + (tot) + ')';
  Q.ExecSQL;
end;

Procedure TOperacionDataModule.LibroIVACompra;
// Insertar en el Libro IVA COMPRAS
begin
  Q.sql.Text :=
    'Insert Into "LibroIVAcompra" (FECHA, FACTURA, PROVEEDOR, CUIT, NG1, NG2, IVA1, IVA2, IDERPYPAC, ITF) Values ( '
    + quotedstr(fec) + ', ' + quotedstr(nro) + ', ' + quotedstr(cod) + ', ' +
    quotedstr(com) + ', ' + n10 + ', ' + n21 + ', ' + (i10) + ', ' + (i21) + ', ' + (perc) +
    ', ' + (tot) + ')';
  Q.ExecSQL;
end;

Procedure TOperacionDataModule.Asiento; // ASIENTO CONTABLE
begin
  if fech = '' then
    fech := FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
  T.sql.Text := 'select * from "Cuenta" where "Cuenta".CODIGO=' + ctan;
  T.Open;
  Q.sql.Text :=
    'Insert Into "LibroDiario" (ASIENTO, FECHA, LEYENDA, JERARQUIA, CUENTA, DEBE, HABER, OCULTO)'
    + ' Values ' + '( ' + (nro) + ', ' + quotedstr(fech) + ', ' + quotedstr(det)
    + ', ' + quotedstr(T.FieldByName('Jerarquia').AsString) + ', ' +
    quotedstr(T.FieldByName('DESCRIPCION').AsString) + ', ' + d + ', ' + h +
    ', ' + quotedstr(Oculto) + ' )';
  Q.ExecSQL;
end;

Procedure TOperacionDataModule.AnularVTA;
var
  let, cod, fech, ven, cui, cno, a, cli, asocNro: string;
  pre, pgr: Boolean;
  cost, com, impu, cheq, cont, tot, sbt, des, tarj, otr, sal, pag, int, n10, n21,
    i10, i21, deud, ulc, comv: Double;
begin
  DM.FormatearFecha;
  cod := inttostr(DM.UltimoRegistro('"Operacion"', 'CODIGO'));
  // Verificar que la factura Exista y que no este anulada
  T.sql.Text := 'Select * From "Venta" Where CODIGO = ' + nro;
  T.Open;
  IF T.RecordCount = 0 then
  begin
    MessageDlg(' no existe.', mtError, [mbOK], 0);
    T.Close;
    Exit;
  end;
  if T.FieldByName('ANULADA').AsString = 'S' then
  begin
    MessageDlg(' ya esta anulada.', mtError, [mbOK], 0);
    T.Close;
    Exit;
  end;
  FormatSettings.ShortDateFormat := 'mm';
  If (DateToStr(now) <> DateToStr(T.Fields[2].AsDateTime)) then
  begin
    MessageDlg(' no se puede anular por ser de un periodo anterior', mtError,
      [mbOK], 0);
    T.Close;
    Exit;
  end;
  if MessageDlg('Está seguro que desea anular la venta ' + nro + '?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    fech := FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
    cli := T.FieldByName('CLIENTE').AsString;
    ven := T.FieldByName('VENDEDOR').AsString;
    if ven='' then ven:='0';
    let := T.FieldByName('LETRA').AsString;
    asocNro := T.FieldByName('COMPROBANTE').AsString;
    sal := T.FieldByName('SALDO').AsFloat;
    cont := T.FieldByName('CONTADO').AsFloat;
    pag := T.FieldByName('PAGADO').AsFloat;
    tot := T.FieldByName('TOTAL').AsFloat;
    cheq := T.FieldByName('CHEQUE').AsFloat;
    tarj := T.FieldByName('TARJETA').AsFloat;
    impu := T.FieldByName('IMPUESTO').AsFloat;
    comv := T.FieldByName('COSTO').AsFloat;
    deud := T.FieldByName('DEUDA').AsFloat;
    com := T.FieldByName('COMISION').AsFloat;
    des := T.FieldByName('DESCUENTO').AsFloat;
    tot := T.FieldByName('TOTAL').AsFloat;
    if T.FieldByName('PAGARE').AsString = 's' then
      pgr := True;
    T.Close;
    // +++TRAER CLIENTE
    T.sql.Text := 'select * from "Cliente" where CODIGO=' + cli;
    T.Open;
    cno := T.FieldByName('CTANOMBRE').AsString;
    cui := T.FieldByName('CUIT').AsString;
    if cui='' then cui := T.FieldByName('DOCUMENTO').AsString;
    T.Close;
    // ---
    // ---Nota de credito electronica
    with dm do begin
      if (reporte = 'FElectronica') or (reporte = 'TElectronica') then
      begin
        LeerINI;
        comp:=ObtenerNroComp('NC'+let);
        WSFE( fech, 'NC'+let, '1', '96', cui, comp, FloatToStr(sbt), FloatToStr(impu), floattostr(tot), let, asocNro, FloatToStr(n10), FloatToStr(n21), FloatToStr(i10), FloatToStr(i21));
        if cae = '' then Exit;//if mensaje <> 'Ok' then Exit;
        if comp<>'' then ActualizarNroComp('NC'+let,comp);
      end;
    end;
    // INSERTA EN LA TABLA OPERACION
  Q.sql.Text :=
    'Insert Into "Operacion" (COMPROBANTE, TERMINOS, CODIGO, TIPO, LETRA'+
    ', CLIENTE, VENDEDOR, SUBTOTAL' +
    ', DESCUENTO, FECHA, IMPUESTO, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO, PAGARE, COSTO, DEUDA, COMISION, DESCRIPCION' +
    ') Values ' + '(' +QuotedStr(comp)+ ', ' + quotedstr(vto) + ', ' + (cod) + ', ' + quotedstr('NC'+let) + ', ' + quotedstr(let) +
    ', ' + cli + ', ' + ven + ', ' + ' ' + floattostr(sbt) + ', ' +
    floattostr(des) + ', ' + quotedstr(fech) + ', ' + floattostr(impu) + ', ' +
    floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(cheq) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ',' + quotedstr(pagare) + ',' + floattostr(cmv) + ',' +
    floattostr(deud) + ',' + floattostr(comv) + ',' + QuotedStr(cae) + ')';
  Q.ExecSQL;
// Insertar en la tabla de OPERACIONITEM
  T.SQL.Text := 'Select * From "VentaItem" Where CODIGO = ' + nro;
  T.Open;
  T.First;
  while not T.Eof do
  begin
    Q.sql.Text :=
      'Insert Into "OperacionItem" (OPERACION, ARTICULO, CANTIDAD'+
      ', PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
      + ' ( ' + cod + ', ' + T.FieldByName('ARTICULO').AsString + ', ' + T.FieldByName('CANTIDAD').AsString
      + ',' + T.FieldByName('PRECIO').AsString + ', ' + T.FieldByName('IMPUESTO').AsString + ', ' + nro + ', ' +
      QuotedStr(T.FieldByName('DESCRIPCION').AsString) + ');';
    Q.ExecSQL;
    T.Next;
  end;

    // Borrar los Items de la factura de la tabla "VentaItem"
//    Q.sql.Text := 'DELETE FROM "VentaItem" WHERE "VentaItem".OPERACION=' + nro;
//    Q.ExecSQL;
    // Borrar los Items de la factura de la tabla "CtaCteItem"
    Q.sql.Text :=
      'DELETE FROM "CtaCteItem" WHERE "CtaCteItem".OPERACION=' + nro;
    Q.ExecSQL;
    // ACTUALIZAR SALDOS
    Q.sql.Text := 'Update "CtaCte" Set SALDO = SALDO - ' + floattostr(sal) +
      ' Where CLIENTE = ' + cli;
    Q.ExecSQL;

    // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA VENTAS
    if (let = 'A') or (let = 'B') then//  if let <> 'X' then
    LibroIVAvta(fech, nro, cod, cui, floattostr(-n10), floattostr(-n21),
      floattostr(-i10), floattostr(-i21), floattostr(-tot)); // en blanco
    // en blanco
    // Insertar en la tabla LibroDiario
    a := inttostr(DM.UltimoRegistro('"LibroDiario"', 'ASIENTO')); // GENERAR INDICE

    // ------------------------------------------------------------------------------
    // VENTAS
    Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString, a, fech,
      (nro + ' - ' + let + ' - ' + cod), floattostr(tot), '0');
    // renglon  - VENTAS
    // si es factura A
    if let = 'A' then
      Asiento(dm.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString, a, fech,
        (nro + ' - ' + let + ' - ' + cod), floattostr(impu), '0');
    // renglon  - IVA DEBITO FISCAL
    // PAGO DE CUENTA CORRIENTE
    if ((pag) > (tot - deud)) then
      Asiento(cno, a, fech, (nro + ' - ' + let + ' - ' + cod + ' - ' + cui),
        floattostr(pag - (tot - deud)), '0'); // renglon  - DEUDORES POR VENTA
    // a
    // PAGO CON
    // CAJA (EFECTIVO)
    if (cont) > 0.04 then
      Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
        (nro + ' - ' + let + ' - ' + cod), '0', floattostr(pag));
    // DSXVTA (CUENTA CORRIENTE)
    if (sal > 0.04) AND (pgr <> True) then
      Asiento(cno, a, fech, (nro + ' - ' + let + ' - ' + cod), '0',
        floattostr(sal));
    // DOC A COBRAR (CON DOCUMENTOS (PAGARE))
    if (pag < tot) AND (pgr = True) then
      Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
        fech, (nro + ' - ' + let + ' - ' + cod), floattostr(sal), '0');
    // VALOR AL COBRO (PAGO CON CHEQUE)
    if (cheq) > 0.04 then
      Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a, fech,
        (nro + ' - ' + let + ' - ' + cod), '0', floattostr(cheq));
    // -----------------------------------1------------------------------------------
    // MERCADERIAS DE REVENTA
    Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a, fech,
      (nro + ' - ' + let + ' - ' + cod), floattostr(cmv), '0');
    // a
    // CMV
    Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString, a, fech,
      (nro + ' - ' + let + ' - ' + cod), '0', floattostr(cmv));
    // -----------------------------------2------------------------------------------
    if com > 0 then
    begin
      // COMISION VENDEDOR A PAGAR
      Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar').AsString,
        a, fech, (nro + ' - ' + let + ' - ' + cod), floattostr(com), '0');
      // a
      // COMISION VENDEDOR
      Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString, a,
        fech, (nro + ' - ' + let + ' - ' + cod), '0', floattostr(com));
    end;
    // -----------------------------------3------------------------------------------
    // CONTABILIDAD---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Marcar la Factura como anulada y poner los saldos en cero
    Q.sql.Text := 'Update "Venta" set ANULADA = ''S'' where CODIGO = ' + nro;
    Q.ExecSQL;
    Q.Transaction.CommitRetaining;
    // IMPRIMIR
    if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
    begin
      ImprimirDataModule := TImprimirDataModule.Create(self);
      if reporte = 'FElectronica' then reporte:='NCElectronica'
      else
        if reporte = 'TElectronica' then reporte:='NCTElectronica'
        else
          if reporte = 'CTicket' then reporte:='NCTicket'
          else
            if reporte = 'COriginal' then reporte:='CNCredito';
      with ImprimirDataModule do
        Impr(oper(cod, 'NC'+let, let), reporte);
      ImprimirDataModule.Free;
    end;
  end;
end;

Procedure TOperacionDataModule.ProcPresup; // PROCESA UN PRESUPUESTO
var
  nro, a: string;
  i: integer;
  IIBB, cmv: Double;
begin
  nro := inttostr(DM.UltimoRegistro('"Presupuesto"', 'CODIGO'));

  // INSERTA EN LA TABLA PRESUPUESTO
  Q.sql.Text := 'Insert Into "Presupuesto" (CODIGO, LETRA, CLIENTE, ' +
    ' SUBTOTAL, DESCUENTO, FECHA,' + ' IMPUESTO, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO' + ') Values ' + '( ' + (nro) + ', ' +
    quotedstr(let) + ', ' + cod + ', ' + ' ' + floattostr(sbt) + ', ' +
    floattostr(des) + ', ' + quotedstr(fec) + ', ' + floattostr(impu) + ', ' +
    floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(che) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ')';
  Q.ExecSQL;

  // Insertar en la tabla de PRESUPUESTOITEM
  for i := 1 to High(mat[0]) do
  begin
    // CALCULAR IIBB
//    Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + quotedstr(mat[9, i]);
//    Q.Open;
//    if tot - impu > Q.FieldByName('MONTO').AsFloat then
//      IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
//        Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
    Q.sql.Text :=
      'Insert Into "PresupuestoItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
      + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
      (mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
      quotedstr(mat[1, i]) + ');';
    Q.ExecSQL;
  end;

  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
  // IMPRIMIR
  if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(self);
    ImprimirDataModule.Impr(ImprimirDataModule.pre(nro, let), 'Presupuesto');
    ImprimirDataModule.Free;
  end;

end;

function TOperacionDataModule.ProcVTA; // PROCESA UNA VENTA
var
  i : integer;
//  nro, comp, a, pagare, cae, vto, mensaje, ptovta, tipocbte: string;
//  IIBB, cmv: Double;
//  jsResponse: TJSONValue;
  ctaCte : boolean;
begin
  //  if webUpd='True' then RestDataModule := TRestDataModule.Create(self);
  DM.FormatearFecha;
  pagare := '0';
  nro := inttostr(DM.UltimoRegistro('"Venta"', 'CODIGO'));
  comp:=ObtenerNroComp(let);
  if pgr then
    pagare := 'S';
  cmv := CostMercVend(ulc, cost);
 // CALCULAR IIBB
  Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + IngresosBrutos;
  Q.Open;
  //  if tot - impu > Q.FieldByName('MONTO').AsFloat then
  //    IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
  //      Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
  if let = 'C' then
    begin
//      tipocbte:='11';
      IIBB := tot * (Q.FieldByName('PORCENTAJE').AsFloat/100)
    end
  else
    IIBB := (tot - impu) * (Q.FieldByName('PORCENTAJE').AsFloat/100);
  if (reporte = 'FElectronica') or (reporte = 'TElectronica') then
  begin
    WSFE(fech, let, '1', '96', cui, comp,  FloatToStr(sbt), FloatToStr(impu), floattostr(tot), '0', '0', FloatToStr(n10), FloatToStr(n21), FloatToStr(i10), FloatToStr(i21));
    if cae = '' then exit;
  end;
  //actualiza el nro de factura
  if comp<>'' then ActualizarNroComp(let,comp);
  // INSERTA EN LA TABLA VENTA
  Q.SQL.Text := 'Insert Into "Venta" (COMPROBANTE, TERMINOS, CODIGO, LETRA, CLIENTE, ' +
    ' SUBTOTAL, DESCUENTO, FECHA'+
    ', IMPUESTO, IVA1, IVA2'+
    ', IIBB, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO' + ', PAGARE, COSTO, DEUDA, COMISION, DESCRIPCION' +
    ') Values ' + '('+QuotedStr(comp)+', ' + quotedstr(vto) + ', ' + (nro) + ', ' +
    quotedstr(let) + ', ' + cod + ', ' +
    floattostr(sbt) + ', ' + floattostr(des) + ', ' + quotedstr(fech) + ', ' +
    floattostr(impu) + ', ' + floattostr(i10) + ', ' + floattostr(i21) + ', ' +
    floattostr(IIBB) + ', ' + floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(cheq) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ', ' + quotedstr(pagare) + ', ' + floattostr(cmv) + ', ' +
    floattostr(deud) + ',' + floattostr(comv) + ', ' + QuotedStr(cae) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de VENTAITEM
  if mat <> nil then
    for i := 1 to High(mat[0]) do
    begin
      // CALCULAR IIBB
  //    Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + quotedstr(mat[9, i]);
  //    Q.Open;
  //    if tot - impu > Q.FieldByName('MONTO').AsFloat then
  //      IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
  //        Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
      if (mat[1, i]= 'Deuda CtaCte') then
        ctaCte := True;
      Q.SQL.Text :=
        'Insert Into "VentaItem" (OPERACION, ARTICULO, CANTIDAD, COSTO, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
        + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
        (mat[7, i]) + ', ' +(mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
        quotedstr(mat[1, i]) + ');';
      Q.ExecSQL;
    end;

  if ctaCte then
  begin
    Q.SQL.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
        ', FECHA = ' + quotedstr(fech) + ' Where CLIENTE = ' + cod;
    Q.ExecSQL;
  end;

  // Insertar en la tabla de CtaCte
  if (sal > 0.05) then
  begin
    Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE = ' + cod;
    Q.Open;
    if (Q.RecordCount > 0) and (sal < 0.05) then
      Q.SQL.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
        ', FECHA = ' + quotedstr(fech) + ' Where CLIENTE = ' + cod
    else
      Q.SQL.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, OPERACION,' +
        ' DESCUENTO, INTERES, FECHA, RENDIDAS) Values (' + cod + ', ' +
        floattostr(sal) + ', ' + nro + ', ' + floattostr(des) + ', ' +
        floattostr(int) + ', ' + quotedstr(fech) + ', 0' + ')';
      Q.ExecSQL;
    // Insertar en la tabla de CtaCte Item
    if sal > 0.04 then
    begin
      For i := 1 to High(mat[0]) do
      begin
        if mat[0, i] <> '1' then
          detalle := mat[1, i]
        else
          detalle := memo;
        Q.sql.Text := 'Insert Into "CtaCteItem" (OPERACION, CLIENTE,' +
          ' DESCRIPCION, IMPORTE, ' + ' PAGADO) Values ' + '( ' + nro + ',' +
          cod + ', ' + quotedstr(detalle) + ',' + (mat[5, i]) + ', 0)';
        Q.ExecSQL;
      end;
    end;
  end;
  // Insertar en RendidoVendedor
  if ven <> '' then
  begin
    comv := round(tot * (comv / 100));
    if comv = 0 then
      comv := 0;
    Q.sql.Text :=
      'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values' +
      ' (' + quotedstr(ven) + ', ' + nro + ', ' + Format('%8.2f', [comv]) + ', '
      + quotedstr(fech) + ')';
    Q.ExecSQL;
  end;
  // Actualizar la tabla de Articulos
  if mat <> nil then
    for i := 1 to High(mat[0]) do
    begin
      OperacionDataModule.ActualizarCantidadArticulo(mat[0, i], mat[3, i])
  //    Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + mat[3, i]
  //      + ' Where "Articulo".CODIGO = ' + (mat[0, i]);
  //    Q.ExecSQL;
    end;
  // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA VENTAS
  if (let = 'A') or (let = 'B') then//  if let <> 'X' then
    LibroIVAvta(fech, nro, cod, cui, floattostr(n10), floattostr(n21),
      floattostr(i10), floattostr(i21), floattostr(tot));
  // Insertar en la tabla LibroDiario
  LibroDiario('VENTA', nro, let, cod, fech, pgr, tot, pag, cheq, ch3q, cont,
    tarj, impu, deud, cmv, comv);
  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
//  if webUpd='True' then RestDataModule.CrearOrden;
  // IMPRIMIR
  if impr then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(self);
    with ImprimirDataModule do
      Impr(vta(nro, let), let);
    ImprimirDataModule.Free;
  end;
  result := true;
end;

Procedure TOperacionDataModule.ProcOPER; // PROCESA UNA OPERACION
var
  nro, a, pagare: string;
  i: integer;
  IIBB, cmv: Double;
begin
  pagare := '0';
  nro := inttostr(DM.UltimoRegistro('"Operacion"', 'CODIGO'));
//  if nro = '1' then nro := inttostr(dm.ConfigQuery.FieldByName('NroFactura').AsInteger + 1);
  if pgr then
    pagare := 'S';
  cmv := CostMercVend(ulc, cost);
  // INSERTA EN LA TABLA OPERACION
  Q.sql.Text :=
    'Insert Into "Operacion" (CODIGO, TIPO, LETRA, CLIENTE, VENDEDOR, ' +
    ' SUBTOTAL, DESCUENTO, FECHA,' + ' IMPUESTO, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO' + ', PAGARE, COSTO, DEUDA, COMISION' +
    ') Values ' + '(' + (nro) + ', ' + quotedstr(tipo) + ', ' + quotedstr(let) +
    ', ' + cod + ', ' + ven + ', ' + ' ' + floattostr(sbt) + ', ' +
    floattostr(des) + ', ' + quotedstr(fech) + ', ' + floattostr(impu) + ', ' +
    floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(cheq) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ',' + quotedstr(pagare) + ',' + floattostr(cmv) + ',' +
    floattostr(deud) + ',' + floattostr(comv) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de OPERACIONITEM
  for i := 1 to High(mat[0]) do
  begin
    Q.sql.Text :=
      'Insert Into "OperacionItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
      + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
      (mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
      quotedstr(mat[1, i]) + ');';
    Q.ExecSQL;
  end;
  // Insertar en la tabla de CtaCte
  if (sal > 0.05) then
  begin
    Q.sql.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE = ' + cod;
    Q.Open;
    if (Q.RecordCount > 0) and (sal < 0.05) then
      Q.sql.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
        ', FECHA = ' + quotedstr(fech) + ' Where CLIENTE = ' + cod
    else
      Q.sql.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, OPERACION,' +
        ' DESCUENTO, INTERES, FECHA, RENDIDAS) Values (' + cod + ', ' +
        floattostr(sal) + ', ' + nro + ', ' + floattostr(des) + ', ' +
        floattostr(int) + ', ' + quotedstr(fech) + ', 0' + ')';
    Q.ExecSQL;
    // Insertar en la tabla de CtaCte Item
    if sal > 0.04 then
    begin
      For i := 1 to High(mat[0]) do
      begin
        if mat[0, i] <> '1' then
          detalle := mat[1, i]
        else
          detalle := memo;
        Q.sql.Text := 'Insert Into "CtaCteItem" (OPERACION, CLIENTE,' +
          ' DESCRIPCION, IMPORTE, ' + ' PAGADO) Values ' + '( ' + nro + ',' +
          cod + ', ' + quotedstr(detalle) + ',' + (mat[5, i]) + ', 0)';
        Q.ExecSQL;
      end;
    end;
  end;
  // Insertar en RendidoVendedor
  if ven <> '' then
  begin
    comv := round(tot * (comv / 100));
    if comv = 0 then
      comv := 0;
    Q.sql.Text :=
      'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values' +
      ' (' + quotedstr(ven) + ', ' + nro + ', ' + Format('%8.2f', [comv]) + ', '
      + quotedstr(fech) + ')';
    Q.ExecSQL;
  end;
  // Actualizar la tabla de Articulos
  For i := 1 to High(mat[0]) do
  begin
    Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + mat[3, i]
      + ' Where ' + ' "Articulo".CODIGO = ' + (mat[0, i]);
    Q.ExecSQL;
  end;
  // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA VENTAS
  if (let = 'A') or (let = 'B') then
    LibroIVAvta(fech, nro, cod, cui, floattostr(n10), floattostr(n21),
      floattostr(i10), floattostr(i21), floattostr(tot)); // en blanco
  // Insertar en la tabla LibroDiario
  LibroDiario(tipo, nro, let, cod, fech, pgr, tot, pag, cheq, ch3q, cont,
    tarj, impu, deud, cmv, comv);
  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
  // IMPRIMIR
  if impr then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(self);
    with ImprimirDataModule do
      Impr(oper(nro, tipo, let), 'CTicket');
    ImprimirDataModule.Free;
  end;
end;

Procedure TOperacionDataModule.ProcCompra; // PROCESA UNA COMPRA
var
  nro, a, pultc: string;
  i: integer;
  IIBB, cmv: Double;
begin
  cmv := 0;
  nro := inttostr(DM.UltimoRegistro('"Compra"', 'CODIGO'));
  // INSERTA EN LA TABLA COMPRA
  Q.sql.Text := 'Insert Into "Compra" (CODIGO, LETRA, PROVEEDOR, ' +
    ' SUBTOTAL, DESCUENTO, FECHA,' + ' IMPUESTO, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO,' + ' COMPROBANTE) Values ' + '(' + (nro) +
    ', ' + quotedstr(let) + ', ' + cod + ', ' + ' ' + floattostr(sbt) + ', ' +
    floattostr(des) + ', ' + quotedstr(fech) + ', ' + floattostr(impu) + ', ' +
    floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(cheq) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ', ' + quotedstr(com) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de COMPRAITEM
  for i := 1 to High(mat[0]) do
  begin
    Q.sql.Text :=
      'Insert Into "CompraItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
      + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
      (mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
      quotedstr(mat[1, i]) + ');';
    Q.ExecSQL;
  end;
  // Insertar en la tabla de CtaCte
  if (sal > 0.04) then
  begin
    Q.sql.Text := 'SELECT * FROM "CtaCte" WHERE PROVEEDOR = ' + cod;
    Q.Open;
    if (Q.RecordCount > 0) and (sal < 0.05) then
      Q.sql.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
        ', FECHA = ' + quotedstr(fech) + ' Where PROVEEDOR = ' + cod
    else
      Q.sql.Text := 'Insert Into "CtaCte" (PROVEEDOR, SALDO, OPERACION,' +
        ' DESCUENTO, FECHA) Values (' + cod + ', ' + floattostr(sal) + ', ' +
        nro + ', ' + floattostr(des) + ', ' + // FloatToStr(inte)+', '+
        quotedstr(fech) + // ', 0'+
        ')';
    Q.ExecSQL;
    // Insertar en la tabla de CtaCte Item
    if sal > 0.04 then
    begin
      For i := 1 to High(mat[0]) do
      begin
        if mat[0, i] <> '1' then
          detalle := mat[1, i]
        else
          detalle := memo;
        Q.sql.Text := 'Insert Into "CtaCteItem" (OPERACION, PROVEEDOR,' +
          ' DESCRIPCION, IMPORTE, ' + ' PAGADO) Values ' + '( ' + nro + ',' +
          cod + ', ' + quotedstr(detalle) + ',' + (mat[5, i]) + ', 0)';
        Q.ExecSQL;
      end;
    end;
  end;
  // Actualizar la tabla de Articulos
  For i := 1 to High(mat[0]) do
  begin
    VarCos(mat[0, i], mat[3, i], strtofloat(mat[4, i]));
  end;
  // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA COMPRAS
  if let = 'A' then//  if let <> 'X' then
    LibroIVACompra(fech, nro, cod, cui, floattostr(n10), floattostr(n21),
      floattostr(i10), floattostr(i21), floattostr(perc), floattostr(tot)); // en blanco
  // Insertar en la tabla LibroDiario
  a := inttostr(DM.UltimoRegistro('"LibroDiario"', 'ASIENTO')); // GENERAR INDICE
  LibroDiario('COMPRA', nro, let, cod, fech, pgr, tot, pag, cheq, ch3q, cont,
    tarj, impu, deud, cmv, 0);
  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
end;

Procedure TOperacionDataModule.LibroDiario;
var
  ctan, ctaan, cui, a, tabl: string;
  sal: Double;
begin
  sal := tot - pag;
  a := floattostr(DM.UltimoRegistro('"LibroDiario"', 'ASIENTO'));
  if (oper = 'CLIENTE') or (oper = 'VENTA') or (oper = 'PED') then
    tabl := 'Cliente'
  else if (oper = 'PROVEEDOR') or (oper = 'COMPRA') then
    tabl := 'Proveedor'
  else if (oper = 'RETIRO CAJA') or (oper = 'SOCIO') then
    tabl := 'Socio';

  T.sql.Text := 'SELECT * FROM "' + tabl + '" WHERE CODIGO=' + cod;
  T.Open;
  ctan := T.FieldByName('CTANOMBRE').AsString;
  ctaan := T.FieldByName('CTAANTICIPO').AsString;
  cui := T.FieldByName('CUIT').AsString;
  T.Close;
  // SI ES COMPRA
  if oper = 'COMPRA' then
  begin
    // renglon  - MERCADERIAS DE REVENTA
    Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a, fech,
      (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), floattostr(tot), '0');
    // si es factura A
    if let = 'A' then
    begin
      Asiento(dm.ConfigQuery.FieldByName('CtaIVACreditoFiscal').AsString, a,
        fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
        floattostr(impu), '0'); // renglon  - IVA DEBITO FISCAL
      tot := tot - impu;
    end;
    // renglon  - PROVEEDOR
    if (pag < tot) AND (pgr <> True) then
      Asiento(ctan, a, fech, (oper + ' n ' + nro + ' - ' + let + ' - ' + cod +
        ' - ' + cui), '0', floattostr(sal)); // DSXVTA
    // renglon  - OBLIGACIONES A PAGAR
    if (pag < tot) AND (pgr = True) then
      Asiento(dm.ConfigQuery.FieldByName('CtaObligacionAPagar').AsString, a,
        fech, (oper + ' - ' + let + ' - ' + cod), '0', floattostr(sal));
    // renglon  - ANTICIPO A PROVEEDORES
    if sal < 0 then
      Asiento(ctaan, a, fech, (oper + ' n ' + nro + ' - ' + let + ' - ' + cod +
        ' - ' + cui), floattostr(sal), '0'); // DSXVTA
    // VALOR AL COBRO (PAGO CON CHEQUE3ros)
    if (ch3q) > 0.04 then
      Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a, fech,
        (oper + ' - ' + let + ' - ' + cod), '0', floattostr(ch3q));
    // renglon  - BANCO XX CUENTA CORRIENTE //PAGO CON CHEQUE PROPIO
    if (cheq) > 0.04 then
      Asiento(dm.ConfigQuery.FieldByName('CtaBanco').AsString, a, fech,
        (oper + ' - ' + let + ' - ' + cod), '0', floattostr(cheq));
    // renglon  - CAJA //PAGO CON EFECTIVO
    if cont > 0.04 then
      Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
        (oper + ' - ' + let + ' - ' + cod), '0', floattostr(cont));
    Exit;
  end
  else // SI ES DEUDA A PROVEEDORES
    if oper = 'PROVEEDOR' then
    begin
      // PAGO CON
      // CAJA (EFECTIVO)
      if (cont) > 0.04 then
        Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
          (oper + ' - ' + let + ' - ' + cod), floattostr(pag), '0');
      // DSXVTA (CUENTA CORRIENTE)
      if (sal > 0.04) AND (pgr <> True) then
        Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod),
          floattostr(sal), '0');
      // DOC A COBRAR (CON DOCUMENTOS (PAGARE))
      if (pag < tot) AND (pgr = True) then
        Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
          fech, (oper + ' - ' + let + ' - ' + cod), '0', floattostr(sal));
      // VALOR AL COBRO (PAGO CON CHEQUE)
      if (cheq) > 0.04 then
        Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a, fech,
          (oper + ' - ' + let + ' - ' + cod), floattostr(cheq), '0');
      // a
      // PAGO DE CUENTA CORRIENTE
      if ((pag) > (tot - deud)) then
        Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
          '0', floattostr(pag - (tot - deud))); // renglon  - DEUDORES POR VENTA
      Exit;
    end
    else // SI ES CTACTE DE CLIENTES
      if oper = 'CLIENTE' then
      begin
        // PAGO DE CUENTA CORRIENTE
        if ((pag) > (tot - deud)) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), floattostr(pag - (tot - deud)), '0');
        // renglon  - DEUDORES POR VENTA
        // a
        // PAGO CON
        // CAJA (EFECTIVO)
        if (cont) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod), '0', floattostr(pag));
        // DSXVTA (CUENTA CORRIENTE)
        if (sal > 0.04) AND (pgr <> True) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod), '0',
            floattostr(sal));
        // DOC A COBRAR (CON DOCUMENTOS (PAGARE))
        if (pag < tot) AND (pgr = True) then
          Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod), floattostr(sal), '0');
        // VALOR AL COBRO (PAGO CON CHEQUE)
        if (cheq) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod), '0', floattostr(cheq));
        Exit;
      end
      else if oper = 'VENTA' then // SI ES VENTA
      begin
        // -----------------------------------0-----------------------------------------
        // PAGO CON EFECTIVO
        if (cont) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), floattostr(pag),
            '0'); // CAJA
        // CUENTA CORRIENTE
        if ((pag) < tot) AND (pgr <> True) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), floattostr(sal), '0'); // DSXVTA
        // CON DOCUMENTOS (PAGARE)
        if (pag < tot) AND (pgr = True) then
          Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(sal), '0'); // DOC A COBRAR
        // PAGO CON CHEQUE
        if (cheq) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(cheq), '0'); // VALOR AL COBRO
        // a
        // PAGO DE CUENTA CORRIENTE
        if ((pag) > (tot - deud)) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), '0', floattostr(pag - (tot - deud)));
        // renglon  - DEUDORES POR VENTA
        // si es factura A
        if let = 'A' then
        begin
          Asiento(dm.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
            floattostr(impu)); // renglon  - IVA DEBITO FISCAL
          tot := tot - impu;
        end;
        // VENTAS
        if oper <> 'CtaCte' then
        begin
          Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
            floattostr(tot)); // renglon  - VENTAS
          // -----------------------------------1-----------------------------------------
          // COSTO DE MERCADERIAS VENDIDAS
          if cmv > 0 then
          begin
            // CMV
            Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString, a, fech,
              (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(cmv), '0');
            // a
            // renglon  - MERCADERIAS DE REVENTA
            Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a,
              fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
              floattostr(cmv));
          end;
          // -----------------------------------2-----------------------------------------
          // COMISION DE VENDEDORES
          if comv > 0 then
          begin
            // renglon  - COMISION VENDEDOR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString,
              a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(comv), '0');
            // a
            // renglon  - COMISION VENDEDOR A PAGAR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar')
              .AsString, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
              cui), '0', floattostr(comv));
          end;
          // -----------------------------------3-----------------------------------------
        end;
      end
      else if oper = 'RETIRO CAJA' then
      begin // RETIRO DE CAJA
        // renglon  - SOCIO XX
        Asiento(ctaan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
          cui), floattostr(tot), '0');
        // a
        // renglon  - CAJA
        Asiento(dm.ConfigQuery.FieldByName('CTACAJA').AsString, a, fech,
          (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
          floattostr(tot));
      end
      else if oper = 'PED' then // SI ES VENTA
      begin
        // -----------------------------------0-----------------------------------------
        // PAGO CON EFECTIVO
        if (cont) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), floattostr(pag),
            '0'); // CAJA
        // CUENTA CORRIENTE
        if ((pag) < tot) AND (pgr <> True) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), floattostr(sal), '0'); // DSXVTA
        // CON DOCUMENTOS (PAGARE)
        if (pag < tot) AND (pgr = True) then
          Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(sal), '0'); // DOC A COBRAR
        // PAGO CON CHEQUE
        if (cheq) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(cheq), '0'); // VALOR AL COBRO
        // a
        // PAGO DE CUENTA CORRIENTE
        if ((pag) > (tot - deud)) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), '0', floattostr(pag - (tot - deud)));
        // renglon  - DEUDORES POR VENTA
        // si es factura A
//        if let = 'A' then
//        begin
//          Asiento(dm.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString, a,
//            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
//            floattostr(impu)); // renglon  - IVA DEBITO FISCAL
//          tot := tot - impu;
//        end;
        // VENTAS
        if oper <> 'CtaCte' then
        begin
          Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
            floattostr(tot)); // renglon  - VENTAS
          // -----------------------------------1-----------------------------------------
          // COSTO DE MERCADERIAS VENDIDAS
          if cmv > 0 then
          begin
            // CMV
            Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString, a, fech,
              (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(cmv), '0');
            // a
            // renglon  - MERCADERIAS DE REVENTA
            Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a,
              fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
              floattostr(cmv));
          end;
          // -----------------------------------2-----------------------------------------
          // COMISION DE VENDEDORES
          if comv > 0 then
          begin
            // renglon  - COMISION VENDEDOR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString,
              a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(comv), '0');
            // a
            // renglon  - COMISION VENDEDOR A PAGAR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar')
              .AsString, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
              cui), '0', floattostr(comv));
          end;
          // -----------------------------------3-----------------------------------------
        end;
      end
      {else if oper = 'PEDIDO' then // SI ES VENTA
      begin
        // -----------------------------------0-----------------------------------------
        // PAGO CON EFECTIVO
        if (cont) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), floattostr(pag),
            '0'); // CAJA
        // CUENTA CORRIENTE
        if ((pag) < tot) AND (pgr <> True) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), floattostr(sal), '0'); // DSXVTA
        // CON DOCUMENTOS (PAGARE)
        if (pag < tot) AND (pgr = True) then
          Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(sal), '0'); // DOC A COBRAR
        // PAGO CON CHEQUE
        if (cheq) > 0.04 then
          Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a,
            fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
            floattostr(cheq), '0'); // VALOR AL COBRO
        // a
        // PAGO DE CUENTA CORRIENTE
        if ((pag) > (tot - deud)) then
          Asiento(ctan, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
            cui), '0', floattostr(pag - (tot - deud)));
        // VENTAS
          Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString, a, fech,
            (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
            floattostr(tot)); // renglon  - VENTAS
          // -----------------------------------1-----------------------------------------
          // COSTO DE MERCADERIAS VENDIDAS
          if cmv > 0 then
          begin
            // CMV
            Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString, a, fech,
              (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(cmv), '0');
            // a
            // renglon  - MERCADERIAS DE REVENTA
            Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a,
              fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui), '0',
              floattostr(cmv));
          end;
          // -----------------------------------2-----------------------------------------
          // COMISION DE VENDEDORES
          if comv > 0 then
          begin
            // renglon  - COMISION VENDEDOR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString,
              a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(comv), '0');
            // a
            // renglon  - COMISION VENDEDOR A PAGAR
            Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar')
              .AsString, a, fech, (oper + ' - ' + let + ' - ' + cod + ' - ' +
              cui), '0', floattostr(comv));
          end;
          // -----------------------------------3-----------------------------------------
      end}
      ;
end;

Procedure TOperacionDataModule.FormaPago;
begin
  Q.sql.Text := 'INSERT INTO "FormaPago"' +
    ' (DESCRIPCION, VENTA, COMPRA, CTACTE, PAGO, CONTADO, CHEQUE, CHEIMP, CHENRO, CHEDET, CHEDIA, TARJETA, TARNRO, TARIMP, OTRIMP, MONEDAEXTRANJERA, MEIMPORTE, METIPOCAMBIO, SALDO, PAGADO, CHEQUE3RO, CH3IMP, CH3NRO, CH3DET, CH3DIA) '
    + ' VALUES' + ' (' + quotedstr(desc) + ',' + vta + ',' + comp + ',' + ctac +
    ',' + pago + ',' + cont + ',' + cheq + ',' + chei + ',' + quotedstr(chen) +
    ',' + quotedstr(ched) + ',' + quotedstr(chedi) + ',' + tarj + ',' +
    quotedstr(tarn) + ',' + tarimp + ',' + otri + ',' + mone + ',' + meim + ','
    + metc + ',' + sald + ',' + paga + ',' + ch3q + ',' + ch3i + ',' +
    quotedstr(ch3n) + ',' + quotedstr(ch3d) + ',' + ch3di + ') ' + '';
  Q.ExecSQL;
end;

Procedure TOperacionDataModule.CodigoBarra;
begin
  ImprimirDataModule := TImprimirDataModule.Create(self);
  with ImprimirDataModule do
    Impr(EAN(cb), 'codebar');
  ImprimirDataModule.Free;
end;

procedure TOperacionDataModule.insertarTabla2;
begin
  Q.SQL.Text := 'INSERT INTO "'+tabla+'" (CODIGO,DESCRIPCION) VALUES ('
  + codigo + ',' + QuotedStr(desc) + ')';
  Q.ExecSQL;
  Q.Transaction.CommitRetaining;
end;

function TOperacionDataModule.existeEnTabla;
begin
//    try
//      T.SQL.Text := 'SELECT * FROM "' + tabla + '" WHERE ' + codigo;
//      T.Open;
//      result := (T.RecordCount<>0);
//    finally
//      result := false;
//    end;
  TRY
    T.SQL.Text := 'SELECT * FROM "' + tabla + '" WHERE ' + codigo;
    T.open;
    TRY
      result := (T.RecordCount<>0);
    FINALLY
    { Esta línea se ejecuta SIEMPRE, haya o no excepción. }
      T.close ;
    END;
  EXCEPT
    On Error: EDatabaseError DO
//      ShowMessage ('Error al cargar los datos: '+Error.Message);
    result := false;
//    ON Error: Exception DO
//      ShowMessage ('Excepción: '+Error.Message);
  END;
end;

procedure TOperacionDataModule.BorrarArticulos;
begin
  with T do
  begin
    SQL.Text := 'DELETE FROM "Articulo" ;';
    ExecSQL;
    SQL.Text :=
    ' DELETE FROM "Rubro" ;';
    ExecSQL;
    SQL.Text :=
    ' DELETE FROM "SubCategoria" ;';
    ExecSQL;
    SQL.Text :=
    ' DELETE FROM "Categoria" ;';
    ExecSQL;
    Transaction.CommitRetaining;
    insertarTabla2('Rubro','0','Sin Rubro');
    insertarTabla2('SubCategoria','0','SinSubCategoría');
    insertarTabla2('Categoria','0','Sin Categoría');
    T.Close;
  end;
end;

procedure TOperacionDataModule.ModificarArticulos;
var
  existe : Boolean;
  ganancia : double;
 { codigo, descripcion,
  ultcosto, costo, precio, precio1, precio2, disponible,
  porcentaje, impotros, unidad, tasa, iibb, ctanombre, ctatipo, ctaanticipo,ctaiibb,
  fecha, fechacompult, codigobarra,
  categoria, color, marca, proveedor, rubro, subcategoria : string;
}
  Numero :Integer;
begin
//  if not TryStrToInt(categoria, Numero) then
  categoria := '0';
//  if not TryStrToInt(proveedor, Numero) then
  proveedor := '1';
//  if not TryStrToInt(subcategoria, Numero) then
  subcategoria := '0';
//  if not TryStrToInt(rubro, Numero) then
  rubro := '0';
  if fecha = '' then fecha := DateToStr(now);
  if fechacompult = '' then fechacompult := fecha;
  if tasa = '' then tasa := '21';
  if porcentaje = '' then porcentaje := FloatToStr(dm.ConfigQuery.FieldByName('PP').AsFloat);
  porcentaje := StringReplace(porcentaje, ',', '.',[]);
  if disponible = '' then disponible := '1';
  tasa := StringReplace(tasa, ',', '.',[]);
  if tasa = '10.5' then tasa := '105';
  precio := StringReplace(precio, ',', '.',[]);
  ganancia := StrToFloat(precio)/(StrToFloat(tasa)/100+1);
  costo := FloatToStrF( ( ganancia/(StrToFloat(porcentaje)/100+1) ), ffFixed, 16, 2 );
//  ultcosto := costo;
  //if descripcion = nil then descripcion := '';
//  if codigobarra <> '' then existe := existeEnTabla('Articulo','CODIGOBARRA='+QuotedStr(codigobarra))
//  if descripcion <> '' then existe := existeEnTabla('Articulo','DESCRIPCION='+QuotedStr(descripcion))
  if codigo <> '' then existe := existeEnTabla('Articulo','CODIGO='+(codigo))
    else
      existe := false;
  if not ( existe ) then
  begin
    Q.SQL.Text := 'INSERT INTO "Articulo" ('
    + ' CODIGO '
    + ', DESCRIPCION '
    + ', ULTCOSTO, COSTO, PRECIO'
//    +', PRECIO1, PRECIO2'
    + ', DISPONIBLE'
    + ', PORCENTAJE, IMPOTROS, UNIDAD, TASA, IIBB, CTANOMBRE, CTATIPO, CTAANTICIPO, CTAIIBB '
    + ', FECHA, FECHACOMPULT, CODIGOBARRA'
    + ', CATEGORIA, COLOR, MARCA, PROVEEDOR, RUBRO, SUBCATEGORIA'
    + ' ) VALUES ( '
    + (codigo) + ', '
    + QuotedStr(descripcion)
    + ', '+ costo +', ' + costo + ', ' + precio
//    + ', ' + precio1 + ', ' + precio2
    + ', ' + disponible
    + ', '+ porcentaje +', 5, ''c/u'', '+ tasa +', 1, 13, 13, 13, 66'
    + ', '+ QuotedStr(fecha) +', ' + QuotedStr(fechacompult) + ', ' + QuotedStr(codigobarra)
    + ', '+ categoria +', 0, 0, '+ proveedor +', '+ rubro +', '+ subcategoria +' )';
//            D.ExecSQL;
  end
    else
      Q.SQL.Text := 'UPDATE "Articulo" SET'
      +' DESCRIPCION = ' + QuotedStr(descripcion)
      +', ULTCOSTO = COSTO'
      +', COSTO = ' + costo
      +', PRECIO = ' + precio
//      +', PRECIO1 = ' + precio1
//      +', PRECIO2 = ' + precio2
      +', DISPONIBLE = ' + disponible
      +', PORCENTAJE = ' + porcentaje
//              +', IMPOTROS = 5' +
//              +', UNIDAD = ''c/u''' +
      +', TASA = ' + tasa
//              +', IIBB = 1' +
//              +', CTANOMBRE = 13' +
//              +', CTATIPO = 13' +
//              +', CTAANTICIPO = 13' +
//              +', CTAIIBB = 66' +
      +', FECHACOMPULT = FECHA'
      +', FECHA = ' + QuotedStr(fecha)
      +', CODIGOBARRA = ' + QuotedStr(codigobarra)
//      +', CATEGORIA = ' + categoria
//              +', COLOR = 0' +
//              +', MARCA = 0' +
//      +', PROVEEDOR = ' + proveedor
//      +', RUBRO = ' + rubro
//      +', SUBCATEGORIA = ' + subcategoria
      +' WHERE '
      +' CODIGO ='+ (codigo);
//      +' CODIGOBARRA = ' + QuotedStr(codigobarra);
//        +' DESCRIPCION = ' + QuotedStr(descripcion);
    Q.ExecSQL;
//    Q.Transaction.CommitRetaining;
end;

procedure TOperacionDataModule.ActualizarCantidadArticulo;
begin
  Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + cantidad
    + ' Where "Articulo".CODIGO = ' + codigo;
  Q.ExecSQL;
  if webUpd='True' then
    with RestDataModule do
    begin
      JAline_items.AddElement( Jline_items( codigo, cantidad ) );
    end;
end;

procedure TOperacionDataModule.DataSetToCsv;
var
  i : Integer;
  voFichero : TStringList;
  vsLinea : String;
  vsBookMark : TBookmark;
begin
  vsBookMark := Q.Bookmark;
  voFichero := nil;
  try
    voFichero := TStringList.Create;
    // Ponemos la cabecera
    vsLinea := '';
    for i := 0 to Q.FieldCount - 1 do
      if Q.Fields[i].Visible then
        vsLinea := vsLinea + '"' + Q.Fields[i].DisplayName + '",';
    voFichero.Add(vsLinea);
    // Insertamos los registros
    Q.DisableControls;
    Q.First;
    while not Q.Eof do
    begin
      vsLinea := '';
      for i := 0 to Q.FieldCount - 1 do
        if Q.Fields[i].Visible then
          vsLinea := vsLinea + '"' + Q.Fields[i].AsString + '",';
      voFichero.Add(vsLinea);
      Q.Next;
    end;
    // Lo guardamos en disco
    voFichero.SaveToFile(psRutaFichero);
  finally
    FreeAndNil(voFichero);
    Q.Bookmark := vsBookMark;
    Q.EnableControls;
  end;
end;

procedure TOperacionDataModule.WSFE;
begin
  AfipDataModule := TAfipDataModule.Create(self);
  try
    with AfipDataModule do
    begin
      jsResponse := FacturaAfip( cbteFecha, dm.TraerTipoCbte(let), concepto,
      docTipo, docNro, cbte, impNeto, impTotal,
      '0', ImpIva, '0', '0', '1',
      dm.TraerTipoCbte(asocTipo), asocNro,
      '1', '0', '0', '0',
      n10, n21, i10, i21,//'0', '0', '0',
      'PES', 'impuesto', 'null',
      'null', 'null', '', '', '', '');
      if jsResponse = nil then
        exit
      else
      begin
        cae := jsResponse.GetValue<String>('cae');
        comp := jsResponse.GetValue<String>('nro');
        vto := jsResponse.GetValue<String>('vto');
        mensaje := jsResponse.GetValue<String>('mensaje');
      end;
    end;
  finally
    AfipDataModule.Free;
  end;
end;

function  TOperacionDataModule.CalcularIVA;
begin
  if porcentaje = 105 then porcentaje := 10.5;
//  Result := monto + (monto * (porcentaje / 100));
  Result := monto*(porcentaje/100+1);
end;

function  TOperacionDataModule.SacarIVA;
begin
  if porcentaje = 105 then porcentaje := 10.5;
  Result := monto-monto/(porcentaje/100+1);
end;

{ FACTURA UN REMITO }
procedure TOperacionDataModule.FactRem;
var
  i : integer;
  ctaCte : boolean;
begin
  DM.FormatearFecha;
  pagare := '0';
  nro := inttostr(DM.UltimoRegistro('"Venta"', 'CODIGO'));
  comp := ObtenerNroComp(let);
  if pgr then
    pagare := 'S';
  cmv := CostMercVend(ulc, cost);
 // CALCULAR IIBB
  Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + IngresosBrutos;
  Q.Open;
  //  if tot - impu > Q.FieldByName('MONTO').AsFloat then
  //    IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
  //      Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
  if let = 'C' then
    begin
//      tipocbte:='11';
      IIBB := tot * (Q.FieldByName('PORCENTAJE').AsFloat/100)
    end
  else
    IIBB := (tot - impu) * (Q.FieldByName('PORCENTAJE').AsFloat/100);
  if (reporte = 'FElectronica') or (reporte = 'TElectronica') then
  begin
    WSFE(fech, let, '1', '96', cui, comp,  FloatToStr(sbt), FloatToStr(impu), floattostr(tot), '0', '0', FloatToStr(n10), FloatToStr(n21), FloatToStr(i10), FloatToStr(i21));
    if cae = '' then exit;
  end;
  //actualiza el nro de factura
  if comp<>'' then ActualizarNroComp(let,comp);
  // INSERTA EN LA TABLA VENTA
  Q.SQL.Text := 'Insert Into "Venta" ( COMPROBANTE, REMITO, TERMINOS, CODIGO'+
    ', LETRA, CLIENTE ' +
    ', SUBTOTAL, DESCUENTO, FECHA'+
    ', IMPUESTO, IVA1, IVA2'+
    ', IIBB, TOTAL, CONTADO, CHEQUE,' +
    ' TARJETA, OTROS, SALDO, PAGADO' + ', PAGARE, COSTO, DEUDA, COMISION, DESCRIPCION'+
    ') Values ' + '('+QuotedStr(comp)+', '+QuotedStr(codRem)+', '+QuotedStr(vto)+', '+nro+', '+
    quotedstr(let) + ', ' + cod + ', ' +
    floattostr(sbt) + ', ' + floattostr(des) + ', ' + quotedstr(fech) + ', ' +
    floattostr(impu) + ', ' + floattostr(i10) + ', ' + floattostr(i21) + ', ' +
    floattostr(IIBB) + ', ' + floattostr(tot) + ', ' + floattostr(cont) + ', ' + floattostr(cheq) + ', ' +
    floattostr(tarj) + ', ' + floattostr(otr) + ', ' + floattostr(sal) + ', ' +
    floattostr(pag) + ', ' + quotedstr(pagare) + ', ' + floattostr(cmv) + ', ' +
    floattostr(deud) + ',' + floattostr(comv) + ', ' + QuotedStr(cae) + ')';
  Q.ExecSQL;
  // Insertar en la tabla de VENTAITEM
  if mat <> nil then
    for i := 1 to High(mat[0]) do
    begin
      // CALCULAR IIBB
  //    Q.sql.Text := 'SELECT * FROM "IIBB" WHERE CODIGO=' + quotedstr(mat[9, i]);
  //    Q.Open;
  //    if tot - impu > Q.FieldByName('MONTO').AsFloat then
  //      IIBB := (tot - impu) * (Q.FieldByName('COEF1').AsFloat *
  //        Q.FieldByName('COEF2').AsFloat * Q.FieldByName('PORCENTAJE').AsFloat);
      if (mat[1, i]= 'Deuda CtaCte') then
        ctaCte := True;
      Q.SQL.Text :=
        'Insert Into "VentaItem" (OPERACION, ARTICULO, CANTIDAD, COSTO, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'
        + ' ( ' + nro + ', ' + (mat[0, i]) + ', ' + (mat[3, i]) + ', ' +
        (mat[7, i]) + ', ' +(mat[4, i]) + ', ' + mat[6, i] + ', ' + nro + ', ' +
        quotedstr(mat[1, i]) + ');';
      Q.ExecSQL;
    end;

  Q.SQL.Text := 'Update "Operacion" Set ANULADA = ''S'' Where CODIGO = '+QuotedStr(codRem);
  Q.ExecSQL;

//  if ctaCte then
//  begin
//    Q.SQL.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
//        ', FECHA = ' + quotedstr(fech) + ' Where CLIENTE = ' + cod;
//    Q.ExecSQL;
//  end;
//
//  // Insertar en la tabla de CtaCte
//  if (sal > 0.05) then
//  begin
//    Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE = ' + cod;
//    Q.Open;
//    if (Q.RecordCount > 0) and (sal < 0.05) then
//      Q.SQL.Text := 'Update "CtaCte" Set SALDO = ' + floattostr(sal) +
//        ', FECHA = ' + quotedstr(fech) + ' Where CLIENTE = ' + cod
//    else
//      Q.SQL.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, OPERACION,' +
//        ' DESCUENTO, INTERES, FECHA, RENDIDAS) Values (' + cod + ', ' +
//        floattostr(sal) + ', ' + nro + ', ' + floattostr(des) + ', ' +
//        floattostr(int) + ', ' + quotedstr(fech) + ', 0' + ')';
//      Q.ExecSQL;
//    // Insertar en la tabla de CtaCte Item
//    if sal > 0.04 then
//    begin
//      For i := 1 to High(mat[0]) do
//      begin
//        if mat[0, i] <> '1' then
//          detalle := mat[1, i]
//        else
//          detalle := memo;
//        Q.sql.Text := 'Insert Into "CtaCteItem" (OPERACION, CLIENTE,' +
//          ' DESCRIPCION, IMPORTE, ' + ' PAGADO) Values ' + '( ' + nro + ',' +
//          cod + ', ' + quotedstr(detalle) + ',' + (mat[5, i]) + ', 0)';
//        Q.ExecSQL;
//      end;
//    end;
//  end;
  // Insertar en RendidoVendedor
//  if ven <> '' then
//  begin
//    comv := round(tot * (comv / 100));
//    if comv = 0 then
//      comv := 0;
//    Q.sql.Text :=
//      'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values' +
//      ' (' + quotedstr(ven) + ', ' + nro + ', ' + Format('%8.2f', [comv]) + ', '
//      + quotedstr(fech) + ')';
//    Q.ExecSQL;
//  end;
  // Actualizar la tabla de Articulos
//  if mat <> nil then
//    for i := 1 to High(mat[0]) do
//    begin
//      OperacionDataModule.ActualizarCantidadArticulo(mat[0, i], mat[3, i])
//      Q.sql.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - ' + mat[3, i]
//        + ' Where "Articulo".CODIGO = ' + (mat[0, i]);
//      Q.ExecSQL;
//    end;
  // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // LIBRO IVA VENTAS
  if (let = 'A') or (let = 'B') then//  if let <> 'X' then
    LibroIVAvta(fech, nro, cod, cui, floattostr(n10), floattostr(n21),
      floattostr(i10), floattostr(i21), floattostr(tot)); // en blanco
  // Insertar en la tabla LibroDiario
  LibroDiario('VENTA', nro, let, cod, fech, pgr, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0);
  // Completa la Transaccion
  Q.Transaction.CommitRetaining;
//  if webUpd='True' then RestDataModule.CrearOrden;
  // IMPRIMIR
  if impr then
  begin
    ImprimirDataModule := TImprimirDataModule.Create(self);
    with ImprimirDataModule do
      Impr(vta(nro, let), let);
    ImprimirDataModule.Free;
  end;
end;

function TOperacionDataModule.ObtenerNroComp;
begin
  case IndexStr(tipo, ['A', 'NCA', 'B', 'NCB', 'C','NCC' ]) of
    0 : result := NroA;
    1 : result := NroNCA;
    2 : result := NroB;
    3 : result := NroNCB;
    4 : result := NroC;
    5 : result := NroNCC;
    else result := IntToStr( dm.ObtenerConfig('NroFactura') );
  end;
 if result='' then result:='0';
 result := IntToStr(StrToInt(result)+1);
end;

procedure TOperacionDataModule.ActualizarNroComp;
begin
    case IndexStr(tipo, ['A', 'NCA', 'B', 'NCB', 'C','NCC' ]) of
      0 : NroA := comp;
      1 : NroNCA := comp;
      2 : NroB := comp;
      3 : NroNCB := comp;
      4 : NroC := comp;
      5 : NroNCC := comp;
      else
      begin
        Q.SQL.Text := 'Update "Config" Set NroFactura ='+comp;
        Q.ExecSQL;
      end;
    end;
      DM.EscribirINI;
end;

end.
