//******************************************************************************
//* DeGsoft GeN                                                                *
//* ===========                                                                *
//* GeN(tm) : ERP Software (http://www.degsoft.com.ar/sistemas/GeN)            *
//* Copyright (c) 2002-2011 by the Degsoft                                     *
//* For more information visit: http://www.degsoft.com.ar                      *
//* This program is free software. You can redistribute it and/or modify       *
//* it under the terms of the GNU General Public License as published by       *
//* the Free Software Foundation; either version 3 of the License.             *
//******************************************************************************

unit OperacionDM;

interface

uses
  SysUtils, Classes, DB, DataModule, ImprimirDM, Dialogs, Controls, DateUtils,
  IBX.IBCustomDataSet, IBX.IBQuery;

type
  matriz=array of array of string;
  TOperacionDataModule = class(TDataModule)
    Q: TIBQuery;
    T: TIBQuery;
    Function  UltimoRegistro(t,c: String): integer;
    Procedure ProcVTA(let,cod,fech,ven,cui,ctan:string; pre,pgr:Boolean;cost,comv,impu,cheq,ch3q,cont,tot,sbt,des,tarj,otr,sal,pag,int,n10,n21,i10,i21,deud,ulc:Double);
    Procedure ProcOPER(tipo,let,cod,fech,ven,cui,ctan:string; pre,pgr:Boolean;cost,comv,impu,cheq,ch3q,cont,tot,sbt,des,tarj,otr,sal,pag,int,n10,n21,i10,i21,deud,ulc:Double);
    Procedure ProcCompra(let,cod,fech,ven,cui,ctan:string;pgr:Boolean;cost,impu,cheq,ch3q,cont,tot,sbt,des,tarj,otr,sal,pag,n10,n21,i10,i21,deud:Double);
    Procedure ProcPlan(let,cod,ven,cui,ctan,cuoimp,cuocant,cob:string; fecha:TDateTime; pre,pgr:Boolean;cost,comv,impu,cheq,ch3q,cont,tot,sbt,des,tarj,otr,sal,pag,inte,n10,n21,i10,i21,deud,ulc:Double);
    Procedure ProcPresup(let,cod,fec,ven,cui,cno:string; pre,pgr:Boolean;cost,comv,impu,che,ch3q,cont,tot,sbt,des,tarj,otr,sal,pag,int,n10,n21,i10,i21,deud,ulc:Double);
    Procedure AnularVTA(nro:string);
    Procedure CtaCte(tipo,cod,ctan :string; pag,cheq,ch3q,cont,tarj,sald :double);
    Procedure Asiento(ctan,nro,fech,det,d,h:string);
    Procedure LibroDiario(oper,nro,let,cod,fech :string; pgr :boolean; tot,pag,cheq,ch3q,cont,tarj,impu,deud,cmv,comv :double);
    Procedure LibroIVAvta(fec,nro,cod,cui,n10,n21,i10,i21,tot:string);
    Procedure LibroIVACompra(fec,nro,cod,cui,n10,n21,i10,i21,tot:string);
    Procedure FormaPago(desc,vta,comp,ctac,pago,cont,cheq,chei,chen,ched,chedi,tarj,tarn,tarimp,otri,mone,meim,metc,sald,paga,fech,ch3q,ch3i,ch3n,ch3d,ch3di :string);
    Function MesLetra(fech:TDate):string;
    Function CostMercVend(ulc,cost:Double):Double;
    procedure VarCos(cod,cant: string; cost:Double);
    Function ArtNuevo(prec,desc: string):string;
    procedure ExpCSV(sql:string);
    Procedure MovCaja(tipo,soc,imp,desc:string)                     ;
    procedure DataModuleCreate(Sender: TObject);
    Procedure CodigoBarra(cb:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mat:matriz;
  OperacionDataModule: TOperacionDataModule;

implementation

{$R *.dfm}

Procedure TOperacionDataModule.MovCaja;
begin
 q.SQL.Text:='INSERT INTO "MovCaja" (TIPO,SOCIO,IMPORTE,DESCRIPCION) '+
 'VALUES ('+quotedstr(tipo)+','+soc+','+imp+','+quotedstr(desc)+''+
 ')';
 q.ExecSQL;
 //Insertar en la tabla LibroDiario
 LibroDiario(tipo+' CAJA','','',soc,'',false,strtofloat(imp),0,0,0,0,0,0,0,0,0);
 q.Transaction.CommitRetaining;
end;

Procedure TOperacionDataModule.ExpCSV;
begin
 T.SQL.Text:=sql;
 T.Open;
end;

Function TOperacionDataModule.ArtNuevo;
var
 nro:string;
begin
 nro:=inttostr(UltimoRegistro('"Articulo"','CODIGO'));
 Q.SQL.Text:='INSERT INTO "Articulo" (CODIGO, DESCRIPCION, COSTO, ULTCOSTO, '+
 ' PRECIO1, PRECIO2, PRECIO3, PRECIO4, '+
 ' PRECIO5, PRECIO6, PRECIO, PORCENTAJE, '+
 ' ULTPRECIO, MARCA, COLOR, CATEGORIA, '+
 ' SUBCATEGORIA, UBICACION, UNIDAD, DISPONIBLE, '+
 ' ENPRODUCCION, NOTAS, IVA, TASA, '+
 ' IMPOTROS, IIBB, STOCKMINIMO, STOCKMAXIMO, '+
 ' STOCKVENDIDO, FECHACOMPULT, LISTA, PROCEDENCIA, '+
 ' CODIGOBARRA, RUBRO, PROVEEDOR, GARANTIA, '+
 ' FECHA, PEDIDO, STOCK, EXISTENTE, '+
 ' ACTUAL, MARCADOCONTADO, MARCADOLISTA, MARCADOFINAL, '+
 ' PREPARADO, CTANOMBRE, CTATIPO, CTAANTICIPO, '+
 ' CTAIIBB, ESTADO, VENCE, VENCIMIENTO) VALUES '+
 ' ('+nro+', '+quotedstr(desc)+', 0, 0, '+
 ' '+prec+', '+prec+', '+prec+', '+prec+', '+
 ' '+prec+', '+prec+', '+prec+', 0, '+
 ' '+prec+', 0, 0, 0, '+
 ' 0, NULL, ''c/u'', 0, '+
 ' NULL, NULL, NULL, 0, '+
 ' 0, 1, NULL, NULL, '+
 ' NULL, '+quotedstr(FormatDateTime('mm/dd/yyyy hh:mm:ss',now))+', NULL, NULL, '+
 ' '''', 0, 1, NULL, '+
 ' '+quotedstr(FormatDateTime('mm/dd/yyyy hh:mm:ss',now))+', NULL, NULL, NULL, '+
 ' NULL, NULL, NULL, NULL, '+
 ' NULL, 13, 13, 13, '+
 ' 66, NULL, NULL, NULL);';
 Q.ExecSQL;
 result:=nro;
end;

procedure TOperacionDataModule.VarCos;

function roundp(pp:double):double;
begin
if pp < 1 then result:=(pp) else result:=StrToFloat(Format('%8.2f',[pp]));
end;

var porc :double;
    p1,p2,p3,p4,p5,p6, p :Double;
begin
 with dm do
  begin
   p1:=ConfigQuery.FieldByName('PP1').AsFloat/100+1;
   p2:=ConfigQuery.FieldByName('PP2').AsFloat/100+1;
   p3:=ConfigQuery.FieldByName('PP3').AsFloat/100+1;
   p4:=ConfigQuery.FieldByName('PP4').AsFloat/100+1;
   p5:=ConfigQuery.FieldByName('PP5').AsFloat/100+1;
   p6:=ConfigQuery.FieldByName('PP6').AsFloat/100+1;
   p:=ConfigQuery.FieldByName('PP').AsFloat/100+1;
  end;
 //VARIACION DE COSTO
 T.SQL.Text:='SELECT * FROM "Articulo" WHERE CODIGO='+cod;
 T.Open;
 //PROCENTAJE DE VARIACION (costo * 100 / ultcosto) / 100
if T.FieldByName('ULTCOSTO').AsFloat <> 0 then porc:=((cost*100/T.FieldByName('ULTCOSTO').AsFloat)/100) else porc:=1;
 //REDONDEAR SOLO SI ES MAYOR QUE 1
 if T.FieldByName('PRECIO1').AsFloat <> 0 then p1:= roundp(T.FieldByName('PRECIO1').AsFloat*porc) else p:= roundp(cost*p1) ;
 if T.FieldByName('PRECIO2').AsFloat <> 0 then p2:= roundp(T.FieldByName('PRECIO2').AsFloat*porc) else p:= roundp(cost*p2) ;
 if T.FieldByName('PRECIO3').AsFloat <> 0 then p3:= roundp(T.FieldByName('PRECIO3').AsFloat*porc) else p:= roundp(cost*p3) ;
 if T.FieldByName('PRECIO4').AsFloat <> 0 then p4:= roundp(T.FieldByName('PRECIO4').AsFloat*porc) else p:= roundp(cost*p4) ;
 if T.FieldByName('PRECIO5').AsFloat <> 0 then p5:= roundp(T.FieldByName('PRECIO5').AsFloat*porc) else p:= roundp(cost*p5) ;
 if T.FieldByName('PRECIO6').AsFloat <> 0 then p6:= roundp(T.FieldByName('PRECIO6').AsFloat*porc) else p:= roundp(cost*p6) ;
 if T.FieldByName('PRECIO').AsFloat <> 0 then p:= roundp(T.FieldByName('PRECIO').AsFloat*porc) else p:= roundp(cost*p) ;
 //
 Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE + '+cant+
  ', ULTCOSTO = COSTO '+
  ', COSTO = '+floattostr(cost)+
  ', PRECIO = '+floattostr(p)+
  ', PRECIO1 = '+floattostr(p1)+
  ', PRECIO2 = '+floattostr(p2)+
  ', PRECIO3 = '+floattostr(p3)+
  ', PRECIO4 = '+floattostr(p4)+
  ', PRECIO5 = '+floattostr(p5)+
  ', PRECIO6 = '+floattostr(p6)+
  ' Where '+
  ' CODIGO = '+cod;
   Q.ExecSQL;
end;

Function TOperacionDataModule.CostMercVend;
begin
 //COSTO DE MERCADERIAS VENDIDAS
 if dm.ConfigQuery.FieldByName('CMV').AsString = 'PPP' then Result := ( (ulc + cost) / 2 )
  else if dm.ConfigQuery.FieldByName('CMV').AsString = 'FIFO' then Result := ulc
   else Result := cost;//if cosMercaderiaVendida = 'LIFO' then
end;

Function TOperacionDataModule.MesLetra;
var
 mes:string;
begin
 Mes := FormatDateTime('mm',fech);
 // fomula mes
 if Mes = '01' then Mes:='Enero'
  else     if Mes = '02'  then Mes:='Febrero'
   else     if Mes = '03'  then Mes:='Marzo'
    else     if Mes = '04'  then Mes:='Abril'
     else     if Mes = '05'  then Mes:='Mayo'
      else     if Mes = '06'  then Mes:='Junio'
       else     if Mes = '07'  then Mes:='Julio'
        else     if Mes = '08'  then Mes:='Agosto'
         else     if Mes = '09'  then Mes:='Septiembre'
          else     if Mes = '10' then Mes:='Octubre'
           else     if Mes = '11' then Mes:='Noviembre'
            else     if Mes = '12' then Mes:='Diciembre';
 result:=mes;
end;

Procedure TOperacionDataModule.ProcPlan;
var
 i, c, d, n, DiasCalculo: integer;
 Oculto, nro, Mes,Dia,Ano, pagare, Tiempo, T2, codn, coddoc, coddirp, coddirt,fech :string;
 IIBB,CMV:double;
 FechaVencimiento :TDate;
begin
 fech:=FormatDateTime('mm/dd/yyyy hh:mm:ss',fecha);
 //INFORMACION DE CLIENTES
 T.SQL.text:='SELECT * FROM "Cliente" WHERE CODIGO='+cod;
 T.Open;
 codn:=T.FieldByName('NOMBRE').AsString;
 coddoc:=T.FieldByName('DOCUMENTO').AsString;
 coddirp:=T.FieldByName('DIRECCION').AsString;
 coddirt:=T.FieldByName('DIRECCIONCOMERCIAL').AsString;
 T.Close;
 if let = 'X' then Oculto:='S';
 //+ formula d�a mes a�o
 Dia := FormatDateTime('dd',fecha);
 Mes := MesLetra(fecha);
 Ano := FormatDateTime('yyyy',fecha);
 nro:=IntToStr(UltimoRegistro('"Venta"','CODIGO'));
 if nro='1' then nro:=IntToStr(DM.ConfigQuery.FieldByName('NroFactura').AsInteger+1);
 CMV:=CostMercVend(ulc,cost);
 //INSERTA EN LA TABLA VENTA
 Q.SQL.Text := 'Insert Into "Venta" (CODIGO, LETRA, CLIENTE, '+
 ' SUBTOTAL, DESCUENTO, FECHA,'+
 ' IMPUESTO, TOTAL, CONTADO, CHEQUE,'+
 ' TARJETA, OTROS, SALDO, PAGADO'+
 ', PAGARE, COSTO, DEUDA, COMISION'+
 ') Values '+
 '('+nro+', '+QuotedStr(let)+', '+cod+', '+
 ' '+FloatToStr(sbt)+', '+FloatToStr(des)+', '+QuotedStr(fech)+', '+
 FloatToStr(impu)+', '+FloatToStr(tot)+', '+FloatToStr(cont)+', '+FloatToStr(cheq)+', '+
 FloatToStr(tarj)+', '+FloatToStr(otr)+', '+FloatToStr(sal)+', '+FloatToStr(pag)+
 ','+QuotedStr(pagare)+','+FloatToStr(CMV)+','+FloatToStr(deud)+','+FloatToStr(comv)+
 ')';
 Q.ExecSQL;
 //Insertar en la tabla de VENTAITEM
 for i := 1 to High(mat[0]) do
  begin
   //CALCULAR IIBB
   q.SQL.Text:='SELECT * FROM "IIBB" WHERE CODIGO='+QuotedStr(mat[9,i]);
   q.Open;
   if tot-impu > q.FieldByName('MONTO').AsFloat then IIBB:=(tot-impu) * (q.FieldByName('COEF1').AsFloat*q.FieldByName('COEF2').AsFloat*q.FieldByName('PORCENTAJE').AsFloat);
   Q.SQL.Text := 'Insert Into "VentaItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'+
   ' ( '+nro+', '+(mat[0,i])+', '+(mat[3,i])+', '+(mat[4,i])+', '+mat[6,i]+', '+nro+', '+QuotedStr( mat[1,i])+');';
   Q.ExecSQL;
  end;
 //Insertar en la tabla de CtaCte
 Q.SQL.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, CUOTAS, OPERACION,'+
 ' DESCUENTO, INTERES, FECHA, COBRADOR, RENDIDAS) Values ('+
 cod+', '+FloatToStr(sal)+', '+cuocant+','+nro+', '+
 FloatToStr(des)+', '+FloatToStr(inte)+', '+
 QuotedStr(fech)+', '+cob+', 0'+
 ')';
 Q.ExecSQL;
 //Insertar en la tabla de CtaCte Item
 if sal > 0.04 then
  begin
 d:=0;
 FechaVencimiento:=fecha;
 For i := 1 to High(mat[0]) do
  begin
   if mat[0,i] <> '1' then detalle:= mat[1,i] else detalle := memo;
    For n := 1 to StrToInt(cuocant) do //ingreso de cuota
     begin
      FechaVencimiento := ( fecha + (n*DiasCalculo) )+d;
      if DayOfTheWeek(FechaVencimiento)=7 then
       begin
        FechaVencimiento := FechaVencimiento+1;
        d:=d+1;
       end;
      Q.SQL.Text := 'Insert Into "CtaCteItem" (CUOTA, OPERACION, CLIENTE,'+
      ' DESCRIPCION, IMPORTE, '+
      ' VENCE, PAGADO) Values '+
      '( '+IntToStr(n)+', '+nro+','+cod+', '+
      QuotedStr(detalle)+','+cuoimp+', '+
      QuotedStr(FormatDateTime('mm/dd/yyyy',FechaVencimiento))+', 0)';
      Q.ExecSQL;
     end;
   end;
  end;
 //Insertar en RendidoVendedor
 if ven <> '' then
  begin
   comv:=  round(tot * (comv/100));
   if comv = 0 then comv := 0;
   Q.SQL.Text := 'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values'+
   ' ('+QuotedStr(ven)+', '+nro+', '+Format('%8.2f', [comv])+', '+QuotedStr(fech)+')';
   Q.ExecSQL;
  end;
 // Actualizar la tabla de Articulos
 For i := 1 to High(mat[0]) do
  begin
   Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - '+mat[3,i]+' Where '+
   ' "Articulo".CODIGO = '+(mat[0,i]);
   Q.ExecSQL;
  end;
 //Insertar en RendidoVendedor
  if ven <> '' then
   begin
    comv:=  round(tot * (comv/100));
    if comv = 0 then comv := 0;
    Q.SQL.Text := 'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values'+
    ' ('+QuotedStr(ven)+', '+nro+', '+Format('%8.2f', [comv])+', '+QuotedStr(fech)+')';
    Q.ExecSQL;
   end;
 // Insertar en la tabla de Contrato
 if DiasCalculo = 7 then
  begin
   Tiempo:='semanas';
   T2:='semanales';
  end
  else
   if DiasCalculo = 1 then
    begin
     Tiempo:='d�as';
     T2:='diarios';
    end;
 //CONTRATO
 Q.SQL.Text := 'Insert Into "Contrato" (NUMERO, DIA, MESCRITO, CANONES,'+
 ' DNOMBRE, DDTIPO, DDOCUMENTO, DDOMICILIO,'+
 ' TOMADOR, TNOMBRE, TDOCUMENTO, '+
 ' TDOMICILIO, TDTRABAJO, BIEN,'+
 ' TIEMPO, T2, CIMPORTE, IMPORTETOTAL, FECHA) Values'+
 ' ('+nro+', '+QuotedStr(Dia)+', '+QuotedStr(Mes)+', '+cuocant+','+
 ' '+QuotedStr(dm.ConfigQuery.FieldByName('Titular').AsString)+', ''DNI'', '+QuotedStr(dm.ConfigQuery.FieldByName('Documento').AsString)+', '+QuotedStr(dm.ConfigQuery.FieldByName('DireccionComercial').AsString)+','+
 ' '+QuotedStr(cod)+', '+QuotedStr(codn)+', '+QuotedStr(coddoc)+','+
 ' '+QuotedStr(coddirp)+', '+QuotedStr(coddirt)+', '+QuotedStr(mat[1,1])+','+
 ' '+QuotedStr(Tiempo)+', '+QuotedStr(T2)+', '+cuoimp+', '+FloatToStr(tot)+', '+QuotedStr(fech)+''+
 ')';
 Q.ExecSQL;
 // Actualizar la tabla de Articulos
 For i := 1 to High(mat[0]) do
  begin
   Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - '+mat[3,i]+' Where '+
   ' "Articulo".CODIGO = '+(mat[0,i]);
   Q.ExecSQL;
  end;
 //CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //LIBRO IVA VENTAS
 if let <> 'X' then LibroIVAvta(fech,nro,cod,cui,FloatToStr(n10),FloatToStr(n21),FloatToStr(i10),FloatToStr(i21),FloatToStr(tot));//en blanco
 //Insertar en la tabla LibroDiario
 LibroDiario('VENTA',nro,let,cod,fech,pgr,tot,pag,cheq,ch3q,cont,tarj,impu,deud,cmv,comv);
 // Completa la Transaccion
 Q.Transaction.CommitRetaining;
  //IMPRIMIR
 if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
   ImprimirDataModule := TImprimirDataModule.Create(self);
   //VTA
   with ImprimirDataModule do
   begin
     Impr( VTA(nro,let),'' );
   ImprimirDataModule.Free;
   //Planes
   ImprimirDataModule := TImprimirDataModule.Create(self);
     Impr( Contrato(nro,let),'ContratoLeasing' );
   ImprimirDataModule.Free;
   //Planilla de Cobrador
   ImprimirDataModule := TImprimirDataModule.Create(self);
     Impr( PlanillaCobrador(nro,''),'Carton' );
   ImprimirDataModule.Free;
   end;
  end;
end;

Procedure TOperacionDataModule.CtaCte;
var nro:integer;
    new:boolean;
begin
 new:=False;
 // CONSULTAR SI YA TIENE CTACTE
 Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE '+tipo+' = '+cod;
 Q.Open;
 if Q.RecordCount = 0 then New:=True;
 // Insertar en la tabla de CtaCte
 if New = False then Q.SQL.Text := 'Update "CtaCte" Set SALDO = SALDO - '+FloatToStr(pag)+' Where '+tipo+' = '+cod
  else Q.SQL.Text := 'Insert Into "CtaCte" ('+tipo+', SALDO) Values ('+cod+','+FloatToStr(sald)+')';
 Q.ExecSQL;
 // Insertar en la tabla de CtaCte Item
 begin
  Q.SQL.Text := 'Insert Into "CtaCteItem" ('+tipo+', DESCRIPCION, PAGADO) Values'+
                '( '+cod+',''Entrega de Dinero'','+FloatToStr(pag)+')';
  Q.ExecSQL;
 end;
 //--CONTABILIDAD***************************************************************
 LibroDiario(tipo,'0','',cod,Fecha,False,0,pag,cheq,ch3q,cont,tarj,0,0,0,0);
 //--CONTABILIDAD **************************************************************
 Q.Transaction.CommitRetaining;
end;

procedure TOperacionDataModule.DataModuleCreate(Sender: TObject);
begin
  DM.ConfigQuery.Open;
  Oculto:='0';
end;

Procedure TOperacionDataModule.LibroIVAvta;// Insertar en el Libro IVA Ventas
begin
 Q.SQL.Text := 'Insert Into "LibroIVAventa" (FECHA, FACTURA, CLIENTE, CUIT, NG1, NG2, IVA1, IVA2, ITF) Values ( '+
 QuotedStr(fec)+', '+QuotedStr(nro)+', '+QuotedStr(cod)+', '+QuotedStr(cui)+', '+n10+', '+n21+', '+(i10)+', '+(i21)+', '+(tot)+')' ;
 Q.ExecSQL;
end;

Procedure TOperacionDataModule.LibroIVACompra;// Insertar en el Libro IVA COMPRAS
begin
 Q.SQL.Text := 'Insert Into "LibroIVAcompra" (FECHA, FACTURA, PROVEEDOR, CUIT, NG1, NG2, IVA1, IVA2, ITF) Values ( '+
 QuotedStr(fec)+', '+QuotedStr(nro)+', '+QuotedStr(cod)+', '+QuotedStr(cui)+', '+n10+', '+n21+', '+(i10)+', '+(i21)+', '+(tot)+')' ;
 Q.ExecSQL;
end;

Procedure TOperacionDataModule.Asiento; //ASIENTO CONTABLE
begin
if fech='' then fech:=FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
 T.SQL.Text:='select * from "Cuenta" where "Cuenta".CODIGO='+ctan;
 T.Open;
 Q.SQL.Text := 'Insert Into "LibroDiario" (ASIENTO, FECHA, LEYENDA, JERARQUIA, CUENTA, DEBE, HABER, OCULTO)'+
 ' Values '+
 '( '+(nro)+', '+QuotedStr(fech)+', '+QuotedStr(det)+', '+QuotedStr(T.FieldByName('Jerarquia').AsString)+', '+QuotedStr(T.FieldByName('DESCRIPCION').AsString)+', '+d+', '+h+', '+QuotedStr(Oculto)+
 ' )';
 Q.ExecSQL;
end;

function TOperacionDataModule.UltimoRegistro;//OBTENER EL NUMERO DE INDICE
begin
Q.SQL.Text := 'Select Max('+c+') From'+t;
 Q.Open;
 Result:= Q.Fields[0].AsInteger+1;
 Q.Close;
end;

Procedure TOperacionDataModule.AnularVTA;
var
 let,cod,fec,ven,cui,cno ,a:string;
 pre,pgr :Boolean;
 cost,com,imp,che,cont,tot,sbt,des,tar,otr,sal,pag,int,n10,n21,i10,i21,deu,ulc ,CMV:Double;
begin
 //Verificar que la factura Exista y que no est� anulada
 T.SQL.Text := 'Select * From "Venta" Where CODIGO = '+nro;
 T.Open;
 IF T.RecordCount = 0 then
  begin
   MessageDlg(' no existe.',mtError,[mbOK],0);
   T.Close;
   Exit;
  end;
 if T.FieldByName('ANULADA').AsString = 'S' then
  begin
   MessageDlg(' ya est� anulada.',mtError,[mbOK],0);
   T.Close;
   Exit;
  end;
  FormatSettings.ShortDateFormat := 'mm';
 If (DateToStr(Now) <> DateToStr(T.Fields[2].AsDateTime)) then
  begin
   MessageDlg(' no se puede anular por ser de un periodo anterior',mtError,[mbOK],0);
   T.Close;
   Exit;
  end;
 if MessageDlg('�Est� seguro que desea anular la venta '+nro+'?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
   fec:=FormatDateTime('mm/dd/yyyy hh:mm:ss',Now);
   cod:=T.FieldByName('CLIENTE').AsString;
   let:=T.FieldByName('LETRA').AsString;
   sal:=T.FieldByName('SALDO').AsFloat;
   cont:=T.FieldByName('CONTADO').AsFloat;
   pag:=T.FieldByName('PAGADO').AsFloat;
   tot:=T.FieldByName('TOTAL').AsFloat;
   che:=T.FieldByName('CHEQUE').AsFloat;
   tar:=T.FieldByName('TARJETA').AsFloat;
   imp:=T.FieldByName('IMPUESTO').AsFloat;
   CMV:=T.FieldByName('COSTO').AsFloat;
   deu:=T.FieldByName('DEUDA').AsFloat;
   com:=T.FieldByName('COMISION').AsFloat;
   imp:=T.FieldByName('IMPUESTO').AsFloat;
   tot:=T.FieldByName('TOTAL').AsFloat;
   if T.FieldByName('PAGARE').AsString = 's' then pgr :=true;
   T.Close;
   //+++TRAER CLIENTE
   T.SQL.Text:='select * from "Cliente" where CODIGO='+cod;
   T.Open;
   cno:=T.FieldByName('CTANOMBRE').AsString;
   cui:=T.FieldByName('CUIT').AsString;
   T.Close;
   //---
   // Marcar la Factura como anulada y poner los saldos en cero
   Q.SQL.Text := 'Update "Venta" set ANULADA = ''S'' where CODIGO = '+nro;
   Q.ExecSQL;
   //Actualizar la cantidad disponible en la tabla de Articulos
   T.SQL.Text := 'SELECT ARTICULO, CANTIDAD FROM "VentaItem" WHERE OPERACION = '+nro;
   T.Open;
   While not T.Eof do
    begin
     Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = (DISPONIBLE + '+T.FieldByName('CANTIDAD').AsString+') Where '+
                   'CODIGO = '+T.FieldByName('ARTICULO').AsString;
     Q.ExecSQL;
     T.Next;
    end;
   T.Close;
   //Borrar los Items de la factura de la tabla "VentaItem"
   Q.SQL.Text := 'DELETE FROM "VentaItem" WHERE "VentaItem".OPERACION='+nro;
   Q.ExecSQL;
   //Borrar los Items de la factura de la tabla "VentaItem"
   Q.SQL.Text := 'DELETE FROM "CtaCteItem" WHERE "CtaCteItem".OPERACION='+nro;
   Q.ExecSQL;
   //ACTUALIZAR SALDOS
   Q.SQL.Text := 'Update "CtaCte" Set SALDO = SALDO - '+FloatToStr(sal)+' Where CLIENTE = '+cod;
   Q.ExecSQL;
   //CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // Insertar en el Libro IVA Ventas
   if let <> 'X' then LibroIVAvta(fec,nro,'...','ANULADA','0','0','0','0','0');//en blanco
   //Insertar en la tabla LibroDiario
   a:=inttostr(UltimoRegistro('"LibroDiario"','ASIENTO'));//GENERAR INDICE
   //------------------------------------------------------------------------------
   //VENTAS
   Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString,a,fec,(nro+' - '+let+' - '+cod),FloatToStr(tot),'0');// renglon  - VENTAS
   //si es factura A
   if let = 'A' then Asiento(DM.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString,a,fec,(nro+' - '+let+' - '+cod),FloatToStr(imp),'0');// renglon  - IVA DEBITO FISCAL
   //PAGO DE CUENTA CORRIENTE
   if ( ( pag ) > (tot-deu) ) then Asiento(cno,a,fec,(nro+' - '+let+' - '+cod+' - '+cui),FloatToStr( pag -(tot-deu)),'0' );// renglon  - DEUDORES POR VENTA
   //a
   //PAGO CON
   //CAJA (EFECTIVO)
   if (cont) > 0.04 then Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString,a,fec,(nro+' - '+let+' - '+cod),'0',FloatToStr(pag));
   //DSXVTA (CUENTA CORRIENTE)
   if (sal > 0.04) AND (pgr<>TRUE) then Asiento(cno,a,fec,(nro+' - '+let+' - '+cod),'0',FloatToStr(sal));
   //DOC A COBRAR (CON DOCUMENTOS (PAGARE))
   if (pag < tot) AND (pgr=TRUE) then Asiento(DM.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString,a,fec,(nro+' - '+let+' - '+cod),FloatToStr(sal),'0');
   //VALOR AL COBRO (PAGO CON CHEQUE)
   if (che) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaValorAlCobro').AsString,a,fec,(nro+' - '+let+' - '+cod),'0',FloatToStr(che));
   //-----------------------------------1------------------------------------------
   //MERCADERIAS DE REVENTA
   Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString,a,fec,(nro+' - '+let+' - '+cod),FloatToStr(CMV),'0');
   //a
   //CMV
   Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString,a,fec,(nro+' - '+let+' - '+cod), '0',FloatToStr(CMV));
   //-----------------------------------2------------------------------------------
   if com > 0 then
    begin
     //COMISION VENDEDOR A PAGAR
     Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar').AsString,a,fec,(nro+' - '+let+' - '+cod),FloatToStr(com),'0');
     //a
     //COMISION VENDEDOR
     Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString,a,fec,(nro+' - '+let+' - '+cod),'0',FloatToStr(com));
    end;
   //-----------------------------------3------------------------------------------
   //CONTABILIDAD---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Q.Transaction.CommitRetaining;
  end;
end;

Procedure TOperacionDataModule.ProcPresup;//PROCESA UN PRESUPUESTO
var
nro,a:string;
i:integer;
IIBB, CMV:Double;
begin
nro:=inttostr(UltimoRegistro('"Presupuesto"','CODIGO'));

//INSERTA EN LA TABLA PRESUPUESTO
Q.SQL.Text := 'Insert Into "Presupuesto" (CODIGO, LETRA, CLIENTE, '+
' SUBTOTAL, DESCUENTO, FECHA,'+
' IMPUESTO, TOTAL, CONTADO, CHEQUE,'+
' TARJETA, OTROS, SALDO, PAGADO'+
') Values '+
'( '+(nro)+', '+QuotedStr(let)+', '+cod+', '+
' '+FloatToStr(sbt)+', '+FloatToStr(des)+', '+QuotedStr(fec)+', '+
FloatToStr(impu)+', '+FloatToStr(tot)+', '+FloatToStr(cont)+', '+FloatToStr(che)+', '+
FloatToStr(tarj)+', '+FloatToStr(otr)+', '+FloatToStr(sal)+', '+FloatToStr(pag)+
')';
Q.ExecSQL;

// Insertar en la tabla de PRESUPUESTOITEM
for i := 1 to High(mat[0]) do
 begin
  //CALCULAR IIBB
  q.SQL.Text:='SELECT * FROM "IIBB" WHERE CODIGO='+QuotedStr(mat[9,i]);
  q.Open;
  if tot-impu > q.FieldByName('MONTO').AsFloat then IIBB:=(tot-impu) * (q.FieldByName('COEF1').AsFloat*q.FieldByName('COEF2').AsFloat*q.FieldByName('PORCENTAJE').AsFloat);
  Q.SQL.Text := 'Insert Into "PresupuestoItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'+
  ' ( '+nro+', '+(mat[0,i])+', '+(mat[3,i])+', '+(mat[4,i])+', '+mat[6,i]+', '+nro+', '+QuotedStr( mat[1,i])+');';
  Q.ExecSQL;
 end;

// Completa la Transaccion
Q.Transaction.CommitRetaining;
//IMPRIMIR
if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
 begin
  ImprimirDataModule := TImprimirDataModule.Create(self);
  ImprimirDataModule.Impr( ImprimirDataModule.PRE(nro,let),'Presupuesto' );
  ImprimirDataModule.Free;
 end;

end;

Procedure TOperacionDataModule.ProcVTA;//PROCESA UNA VENTA
var
 nro,a,pagare:string;
 i:integer;
 IIBB, CMV:Double;
begin
 pagare:='0';
 nro:=inttostr(UltimoRegistro('"Venta"','CODIGO'));
 if nro='1' then nro:=IntToStr(DM.ConfigQuery.FieldByName('NroFactura').AsInteger+1);
 if pgr then pagare:='S';
 CMV:=CostMercVend(ulc,cost);
 //INSERTA EN LA TABLA VENTA
 Q.SQL.Text := 'Insert Into "Venta" (CODIGO, LETRA, CLIENTE, '+
 ' SUBTOTAL, DESCUENTO, FECHA,'+
 ' IMPUESTO, TOTAL, CONTADO, CHEQUE,'+
 ' TARJETA, OTROS, SALDO, PAGADO'+
 ', PAGARE, COSTO, DEUDA, COMISION'+
 ') Values '+
 '('+(nro)+', '+QuotedStr(let)+', '+cod+', '+
 ' '+FloatToStr(sbt)+', '+FloatToStr(des)+', '+QuotedStr(fech)+', '+
 FloatToStr(impu)+', '+FloatToStr(tot)+', '+FloatToStr(cont)+', '+FloatToStr(cheq)+', '+
 FloatToStr(tarj)+', '+FloatToStr(otr)+', '+FloatToStr(sal)+', '+FloatToStr(pag)+
 ','+QuotedStr(pagare)+','+FloatToStr(CMV)+','+FloatToStr(deud)+','+FloatToStr(comv)+
 ')';
 Q.ExecSQL;
 //Insertar en la tabla de VENTAITEM
 for i := 1 to High(mat[0]) do
  begin
   //CALCULAR IIBB
   q.SQL.Text:='SELECT * FROM "IIBB" WHERE CODIGO='+QuotedStr(mat[9,i]);
   q.Open;
   if tot-impu > q.FieldByName('MONTO').AsFloat then IIBB:=(tot-impu) * (q.FieldByName('COEF1').AsFloat*q.FieldByName('COEF2').AsFloat*q.FieldByName('PORCENTAJE').AsFloat);
   Q.SQL.Text := 'Insert Into "VentaItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'+
   ' ( '+nro+', '+(mat[0,i])+', '+(mat[3,i])+', '+(mat[4,i])+', '+mat[6,i]+', '+nro+', '+QuotedStr( mat[1,i])+');';
   Q.ExecSQL;
  end;
 //Insertar en la tabla de CtaCte
 if (sal > 0.05) then
  begin
   Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE = '+cod;
   Q.open;
   if (Q.RecordCount > 0) and (sal < 0.05) then Q.SQL.Text := 'Update "CtaCte" Set SALDO = '+FloatToStr(sal)+', FECHA = '+QuotedStr(fech)+' Where CLIENTE = '+cod
    else Q.SQL.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, OPERACION,'+
     ' DESCUENTO, INTERES, FECHA, RENDIDAS) Values ('+
     cod+', '+FloatToStr(sal)+', '+nro+', '+
     FloatToStr(des)+', '+FloatToStr(int)+', '+
     QuotedStr(fech)+', 0'+
     ')';
     Q.ExecSQL;
  //Insertar en la tabla de CtaCte Item
  if sal > 0.04 then
   begin
    For i := 1 to High(mat[0]) do
     begin
      if mat[0,i] <> '1' then detalle:= mat[1,i] else detalle := memo;
      Q.SQL.Text := 'Insert Into "CtaCteItem" (OPERACION, CLIENTE,'+
      ' DESCRIPCION, IMPORTE, '+
      ' PAGADO) Values '+
      '( '+nro+','+cod+', '+
      QuotedStr(detalle)+','+(mat[5,i])+
      ', 0)';
      Q.ExecSQL;
     end;
   end;
 end;
 //Insertar en RendidoVendedor
  if ven <> '' then
   begin
    comv:=  round(tot * (comv/100));
    if comv = 0 then comv := 0;
    Q.SQL.Text := 'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values'+
    ' ('+QuotedStr(ven)+', '+nro+', '+Format('%8.2f', [comv])+', '+QuotedStr(fech)+')';
    Q.ExecSQL;
   end;
 // Actualizar la tabla de Articulos
 For i := 1 to High(mat[0]) do
  begin
   Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - '+mat[3,i]+' Where '+
   ' "Articulo".CODIGO = '+(mat[0,i]);
   Q.ExecSQL;
  end;
 //CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //LIBRO IVA VENTAS
 if let <> 'X' then LibroIVAvta(fech,nro,cod,cui,FloatToStr(n10),FloatToStr(n21),FloatToStr(i10),FloatToStr(i21),FloatToStr(tot));//en blanco
 //Insertar en la tabla LibroDiario
 LibroDiario('VENTA',nro,let,cod,fech,pgr,tot,pag,cheq,ch3q,cont,tarj,impu,deud,cmv,comv);
 // Completa la Transaccion
 Q.Transaction.CommitRetaining;
 //IMPRIMIR
 if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
   ImprimirDataModule := TImprimirDataModule.Create(self);
   with ImprimirDataModule do Impr( VTA(nro,let),'' );
   ImprimirDataModule.Free;
  end;
end;

Procedure TOperacionDataModule.ProcOPER;//PROCESA UNA OPERACION
var
 nro,a,pagare:string;
 i:integer;
 IIBB, CMV:Double;
begin
 pagare:='0';
 nro:=inttostr(UltimoRegistro('"Operacion"','CODIGO'));
 if nro='1' then nro:=IntToStr(DM.ConfigQuery.FieldByName('NroFactura').AsInteger+1);
 if pgr then pagare:='S';
 CMV:=CostMercVend(ulc,cost);
 //INSERTA EN LA TABLA OPERACION
 Q.SQL.Text := 'Insert Into "Operacion" (CODIGO, TIPO, LETRA, CLIENTE, VENDEDOR, '+
 ' SUBTOTAL, DESCUENTO, FECHA,'+
 ' IMPUESTO, TOTAL, CONTADO, CHEQUE,'+
 ' TARJETA, OTROS, SALDO, PAGADO'+
 ', PAGARE, COSTO, DEUDA, COMISION'+
 ') Values '+
 '('+(nro)+', '+QuotedStr(tipo)+', '+QuotedStr(let)+', '+cod+', '+ven+', '+
 ' '+FloatToStr(sbt)+', '+FloatToStr(des)+', '+QuotedStr(fech)+', '+
 FloatToStr(impu)+', '+FloatToStr(tot)+', '+FloatToStr(cont)+', '+FloatToStr(cheq)+', '+
 FloatToStr(tarj)+', '+FloatToStr(otr)+', '+FloatToStr(sal)+', '+FloatToStr(pag)+
 ','+QuotedStr(pagare)+','+FloatToStr(CMV)+','+FloatToStr(deud)+','+FloatToStr(comv)+
 ')';
 Q.ExecSQL;
 //Insertar en la tabla de OPERACIONITEM
 for i := 1 to High(mat[0]) do
  begin
   //CALCULAR IIBB
   q.SQL.Text:='SELECT * FROM "IIBB" WHERE CODIGO='+QuotedStr(mat[9,i]);
   q.Open;
   if tot-impu > q.FieldByName('MONTO').AsFloat then IIBB:=(tot-impu) * (q.FieldByName('COEF1').AsFloat*q.FieldByName('COEF2').AsFloat*q.FieldByName('PORCENTAJE').AsFloat);
   Q.SQL.Text := 'Insert Into "OperacionItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'+
   ' ( '+nro+', '+(mat[0,i])+', '+(mat[3,i])+', '+(mat[4,i])+', '+mat[6,i]+', '+nro+', '+QuotedStr( mat[1,i])+');';
   Q.ExecSQL;
  end;
 //Insertar en la tabla de CtaCte
 if (sal > 0.05) then
  begin
   Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE = '+cod;
   Q.open;
   if (Q.RecordCount > 0) and (sal < 0.05) then Q.SQL.Text := 'Update "CtaCte" Set SALDO = '+FloatToStr(sal)+', FECHA = '+QuotedStr(fech)+' Where CLIENTE = '+cod
    else Q.SQL.Text := 'Insert Into "CtaCte" (CLIENTE, SALDO, OPERACION,'+
     ' DESCUENTO, INTERES, FECHA, RENDIDAS) Values ('+
     cod+', '+FloatToStr(sal)+', '+nro+', '+
     FloatToStr(des)+', '+FloatToStr(int)+', '+
     QuotedStr(fech)+', 0'+
     ')';
     Q.ExecSQL;
  //Insertar en la tabla de CtaCte Item
  if sal > 0.04 then
   begin
    For i := 1 to High(mat[0]) do
     begin
      if mat[0,i] <> '1' then detalle:= mat[1,i] else detalle := memo;
      Q.SQL.Text := 'Insert Into "CtaCteItem" (OPERACION, CLIENTE,'+
      ' DESCRIPCION, IMPORTE, '+
      ' PAGADO) Values '+
      '( '+nro+','+cod+', '+
      QuotedStr(detalle)+','+(mat[5,i])+
      ', 0)';
      Q.ExecSQL;
     end;
   end;
 end;
 //Insertar en RendidoVendedor
  if ven <> '' then
   begin
    comv:=  round(tot * (comv/100));
    if comv = 0 then comv := 0;
    Q.SQL.Text := 'Insert Into "RendidoVendedor" (VENDEDOR, VENTA, IMPORTE, FECHA) Values'+
    ' ('+QuotedStr(ven)+', '+nro+', '+Format('%8.2f', [comv])+', '+QuotedStr(fech)+')';
    Q.ExecSQL;
   end;
 // Actualizar la tabla de Articulos
 For i := 1 to High(mat[0]) do
  begin
   Q.SQL.Text := 'Update "Articulo" Set DISPONIBLE = DISPONIBLE - '+mat[3,i]+' Where '+
   ' "Articulo".CODIGO = '+(mat[0,i]);
   Q.ExecSQL;
  end;
 //CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //LIBRO IVA VENTAS
 if let <> 'X' then LibroIVAvta(fech,nro,cod,cui,FloatToStr(n10),FloatToStr(n21),FloatToStr(i10),FloatToStr(i21),FloatToStr(tot));//en blanco
 //Insertar en la tabla LibroDiario
 LibroDiario('VENTA',nro,let,cod,fech,pgr,tot,pag,cheq,ch3q,cont,tarj,impu,deud,cmv,comv);
 // Completa la Transaccion
 Q.Transaction.CommitRetaining;
 //IMPRIMIR
 if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
   ImprimirDataModule := TImprimirDataModule.Create(self);
   with ImprimirDataModule do Impr( OPER(nro,let),'' );
   ImprimirDataModule.Free;
  end;
end;

Procedure TOperacionDataModule.ProcCompra;//PROCESA UNA COMPRA
var
 nro,a, pultc :string;
 i :integer;
 IIBB, CMV :Double;
begin
 CMV:=0;
 nro:=inttostr(UltimoRegistro('"Compra"','CODIGO'));
 //INSERTA EN LA TABLA COMPRA
 Q.SQL.Text := 'Insert Into "Compra" (CODIGO, LETRA, PROVEEDOR, '+
 ' SUBTOTAL, DESCUENTO, FECHA,'+
 ' IMPUESTO, TOTAL, CONTADO, CHEQUE,'+
 ' TARJETA, OTROS, SALDO, PAGADO,'+
 ' COMPROBANTE) Values '+
 '('+(nro)+', '+QuotedStr(let)+', '+cod+', '+
 ' '+FloatToStr(sbt)+', '+FloatToStr(des)+', '+QuotedStr(fech)+', '+
 FloatToStr(impu)+', '+FloatToStr(tot)+', '+FloatToStr(cont)+', '+FloatToStr(cheq)+', '+
 FloatToStr(tarj)+', '+FloatToStr(otr)+', '+FloatToStr(sal)+', '+FloatToStr(pag)+
 ', '+QuotedStr(cui)+')';
 Q.ExecSQL;
 //Insertar en la tabla de COMPRAITEM
 for i := 1 to High(mat[0]) do
  begin
   Q.SQL.Text := 'Insert Into "CompraItem" (OPERACION, ARTICULO, CANTIDAD, PRECIO, IMPUESTO, SERVICIO, DESCRIPCION) Values'+
   ' ( '+nro+', '+(mat[0,i])+', '+(mat[3,i])+', '+(mat[4,i])+', '+mat[6,i]+', '+nro+', '+QuotedStr( mat[1,i])+');';
   Q.ExecSQL;
  end;
 //Insertar en la tabla de CtaCte
 if (sal > 0.04) then
  begin
   Q.SQL.Text := 'SELECT * FROM "CtaCte" WHERE PROVEEDOR = '+cod;
   Q.open;
   if (Q.RecordCount > 0) and (sal < 0.05) then Q.SQL.Text := 'Update "CtaCte" Set SALDO = '+FloatToStr(sal)+', FECHA = '+QuotedStr(fech)+' Where PROVEEDOR = '+cod
    else Q.SQL.Text := 'Insert Into "CtaCte" (PROVEEDOR, SALDO, OPERACION,'+
     ' DESCUENTO, FECHA) Values ('+
     cod+', '+FloatToStr(sal)+', '+nro+', '+
     FloatToStr(des)+', '+//FloatToStr(inte)+', '+
     QuotedStr(fech)+//', 0'+
     ')';
     Q.ExecSQL;
   //Insertar en la tabla de CtaCte Item
   if sal > 0.04 then
    begin
     For i := 1 to High(mat[0]) do
      begin
       if mat[0,i] <> '1' then detalle:= mat[1,i] else detalle := memo;
       Q.SQL.Text := 'Insert Into "CtaCteItem" (OPERACION, PROVEEDOR,'+
       ' DESCRIPCION, IMPORTE, '+
       ' PAGADO) Values '+
       '( '+nro+','+cod+', '+
       QuotedStr(detalle)+','+(mat[5,i])+
       ', 0)';
       Q.ExecSQL;
      end;
    end;
 end;
 // Actualizar la tabla de Articulos
 For i := 1 to High(mat[0]) do
  begin
   VarCos(mat[0,i],mat[3,i],strtofloat(mat[4,i]));
  end;
 //CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //LIBRO IVA COMPRAS
 if let <> 'X' then LibroIVACompra(fech,nro,cod,cui,FloatToStr(n10),FloatToStr(n21),FloatToStr(i10),FloatToStr(i21),FloatToStr(tot));//en blanco
 //Insertar en la tabla LibroDiario
 a:=inttostr(UltimoRegistro('"LibroDiario"','ASIENTO'));//GENERAR INDICE
 LibroDiario('COMPRA',nro,let,cod,fech,pgr,tot,pag,cheq,ch3q,cont,tarj,impu,deud,cmv,0);
 // Completa la Transaccion
 Q.Transaction.CommitRetaining;
end;

Procedure TOperacionDataModule.LibroDiario;
var
 ctan, ctaan, cui, a, tabl :string;
 sal :double;
begin
 sal:=tot-pag;
 a:=FloatToStr(UltimoRegistro('"LibroDiario"','ASIENTO'));
 if (oper='CLIENTE') or (oper='VENTA') then tabl:='Cliente'
  else
   if (oper='PROVEEDOR') or (oper='COMPRA') then tabl:='Proveedor'
    else
     if (oper='RETIRO CAJA') or (oper='SOCIO') then tabl:='Socio';

 T.SQL.text:='SELECT * FROM "'+tabl+'" WHERE CODIGO='+cod;
 T.Open;
 ctan:=T.FieldByName('CTANOMBRE').AsString;
 ctaan:=T.FieldByName('CTAANTICIPO').AsString;
 cui:=T.FieldByName('CUIT').AsString;
 T.Close;
 //SI ES COMPRA
 if oper='COMPRA' then
  begin
   // renglon  - MERCADERIAS DE REVENTA
   Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(tot),'0');
   //si es factura A
   if let = 'A' then
    begin
     Asiento(DM.ConfigQuery.FieldByName('CtaIVACreditoFiscal').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(impu),'0');// renglon  - IVA DEBITO FISCAL
     tot:=tot-impu;
    end;
    //renglon  - PROVEEDOR
    if (pag < tot) AND (pgr<>TRUE) then Asiento(ctan,a,fech,(oper+' n� '+nro+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(sal)); //DSXVTA
    // renglon  - OBLIGACIONES A PAGAR
    if (pag < tot) AND (pgr=TRUE) then Asiento(DM.ConfigQuery.FieldByName('CtaObligacionAPagar').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(sal));
    // renglon  - ANTICIPO A PROVEEDORES
    if sal < 0 then Asiento(ctaan,a,fech,(oper+' n� '+nro+' - '+let+' - '+cod+' - '+cui),FloatToStr(sal),'0'); //DSXVTA
    //VALOR AL COBRO (PAGO CON CHEQUE3ros)
    if (ch3q) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaValorAlCobro').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(ch3q));
    // renglon  - BANCO XX CUENTA CORRIENTE //PAGO CON CHEQUE PROPIO
    if (cheq) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaBanco').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(cheq));
    // renglon  - CAJA //PAGO CON EFECTIVO
    if cont > 0.04 then Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(cont));
   Exit;
  end
 else//SI ES DEUDA A PROVEEDORES
 if oper='PROVEEDOR' then
  begin
   //PAGO CON
   //CAJA (EFECTIVO)
   if (cont) > 0.04 then Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString,a,fech,(oper+' - '+let+' - '+cod),FloatToStr(pag),'0');
   //DSXVTA (CUENTA CORRIENTE)
   if (sal > 0.04) AND (pgr<>TRUE) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod),FloatToStr(sal),'0');
   //DOC A COBRAR (CON DOCUMENTOS (PAGARE))
   if (pag < tot) AND (pgr=TRUE) then Asiento(DM.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(sal));
   //VALOR AL COBRO (PAGO CON CHEQUE)
   if (cheq) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaValorAlCobro').AsString,a,fech,(oper+' - '+let+' - '+cod),FloatToStr(cheq),'0');
   //a
   //PAGO DE CUENTA CORRIENTE
   if ( ( pag ) > (tot-deud) ) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr( pag -(tot-deud)));// renglon  - DEUDORES POR VENTA
  Exit;
  end
  else//SI ES CTACTE DE CLIENTES
 if oper='CLIENTE' then
  begin
   //PAGO DE CUENTA CORRIENTE
   if ( ( pag ) > (tot-deud) ) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr( pag -(tot-deud)),'0' );// renglon  - DEUDORES POR VENTA
   //a
   //PAGO CON
   //CAJA (EFECTIVO)
   if (cont) > 0.04 then Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(pag));
   //DSXVTA (CUENTA CORRIENTE)
   if (sal > 0.04) AND (pgr<>TRUE) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(sal));
   //DOC A COBRAR (CON DOCUMENTOS (PAGARE))
   if (pag < tot) AND (pgr=TRUE) then Asiento(DM.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString,a,fech,(oper+' - '+let+' - '+cod),FloatToStr(sal),'0');
   //VALOR AL COBRO (PAGO CON CHEQUE)
   if (cheq) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaValorAlCobro').AsString,a,fech,(oper+' - '+let+' - '+cod),'0',FloatToStr(cheq));
  Exit;
  end
  else
  if oper='VENTA' then//SI ES VENTA
   begin
 //-----------------------------------0-----------------------------------------
    //PAGO CON EFECTIVO
    if (cont) > 0.04 then Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(pag),'0');//CAJA
    //CUENTA CORRIENTE
    if ((pag) < tot) AND (pgr<>TRUE) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(sal),'0'); //DSXVTA
    //CON DOCUMENTOS (PAGARE)
    if (pag < tot) AND (pgr=TRUE) then Asiento(DM.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(sal),'0'); //DOC A COBRAR
    //PAGO CON CHEQUE
    if (cheq) > 0.04 then Asiento(DM.ConfigQuery.FieldByName('CtaValorAlCobro').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(cheq),'0'); //VALOR AL COBRO
    //a
    //PAGO DE CUENTA CORRIENTE
    if ( ( pag ) > (tot-deud) ) then Asiento(ctan,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr( pag -(tot-deud)) );// renglon  - DEUDORES POR VENTA
    //si es factura A
    if let = 'A' then
    begin
     Asiento(DM.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(impu));// renglon  - IVA DEBITO FISCAL
     tot:=tot-impu;
    end;
    //VENTAS
    if oper <> 'CtaCte' then
    begin
     Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(tot));// renglon  - VENTAS
 //-----------------------------------1-----------------------------------------
     //COSTO DE MERCADERIAS VENDIDAS
     if cmv > 0 then
      begin
       //CMV
       Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(cmv), '0');
       //a
       // renglon  - MERCADERIAS DE REVENTA
       Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(cmv));
      end;
 //-----------------------------------2-----------------------------------------
   //COMISION DE VENDEDORES
     if comv > 0 then
      begin
       // renglon  - COMISION VENDEDOR
       Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(comv),'0');
       //a
       // renglon  - COMISION VENDEDOR A PAGAR
       Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(comv));
      end;
 //-----------------------------------3-----------------------------------------
    end;
   end
   else if oper='RETIRO CAJA' then
    begin //RETIRO DE CAJA
     // renglon  - SOCIO XX
     Asiento(ctaan,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),FloatToStr(tot),'0');
     //a
     // renglon  - CAJA
     Asiento(dm.ConfigQuery.FieldByName('CTACAJA').AsString,a,fech,(oper+' - '+let+' - '+cod+' - '+cui),'0',FloatToStr(tot));
    end;
end;

Procedure TOperacionDataModule.FormaPago;
begin
 Q.SQL.Text := 'INSERT INTO "FormaPago"'+
 ' (DESCRIPCION, VENTA, COMPRA, CTACTE, PAGO, CONTADO, CHEQUE, CHEIMP, CHENRO, CHEDET, CHEDIA, TARJETA, TARNRO, TARIMP, OTRIMP, MONEDAEXTRANJERA, MEIMPORTE, METIPOCAMBIO, SALDO, PAGADO, CHEQUE3RO, CH3IMP, CH3NRO, CH3DET, CH3DIA) '+
 ' VALUES'+
 ' ('+QuotedStr(desc)+','+vta+','+comp+','+ctac+','+pago+','+cont+','+cheq+','+chei+','+QuotedStr(chen)+','+QuotedStr(ched)+','+QuotedStr(chedi)+','+tarj+','+QuotedStr(tarn)+','+tarimp+','+otri+','+mone+','+meim+','+metc+','+sald+','+paga+','+ch3q+','+ch3i+','+QuotedStr(ch3n)+','+QuotedStr(ch3d)+','+ch3di+') '+
 '';
 Q.ExecSQL;
end;

Procedure TOperacionDataModule.CodigoBarra;
begin
 ImprimirDataModule := TImprimirDataModule.Create(self);
 with ImprimirDataModule do Impr( EAN(cb),'codebar' );
 ImprimirDataModule.Free;
end;

end.

