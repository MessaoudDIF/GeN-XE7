unit UFProductos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, Grids, DBGrids, DB, ExtCtrls, StdCtrls, Mask,
  DBCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IBX.IBQuery,
  IBX.IBCustomDataSet, IBX.IBTable;

const
  EAN_izqA: array [0 .. 9] of PChar = ('0001101', '0011001', '0010011',
    '0111101', '0100011', '0110001', '0101111', '0111011', '0110111',
    '0001011');
  EAN_izqB: array [0 .. 9] of PChar = ('0100111', '0110011', '0011011',
    '0100001', '0011101', '0111001', '0000101', '0010001', '0001001',
    '0010111');
  EAN_dcha: array [0 .. 9] of PChar = ('1110010', '1100110', '1101100',
    '1000010', '1011100', '1001110', '1010000', '1000100', '1001000',
    '1110100');
  CodificaIzq: array [0 .. 9] of PChar = ('AAAAA', 'ABABB', 'ABBAB', 'ABBBA',
    'BAABB', 'BBAAB', 'BBBAA', 'BABAB', 'BABBA', 'BBABA');

type
  TFProductos = class(TForm)
    DataSource: TDataSource;
    DSTCat: TDataSource;
    DSTSubCat: TDataSource;
    DSMateriales: TDataSource;
    DSRubro: TDataSource;
    DSQProve: TDataSource;
    MarcaDataSource: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Label14: TLabel;
    Label23: TLabel;
    DescripcionDBEdit: TDBEdit;
    DBEdit1: TDBEdit;
    DBLookupComboBox4: TDBLookupComboBox;
    BitBtn13: TBitBtn;
    Label8: TLabel;
    Label19: TLabel;
    Label30: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    DBText1: TDBText;
    Label16: TLabel;
    Label28: TLabel;
    Label21: TLabel;
    FleteDBEdit: TDBEdit;
    CostoDBEdit: TDBEdit;
    Label4: TLabel;
    PrecioCtaCteDBEdit: TDBEdit;
    DBMemo1: TDBMemo;
    TabSheet2: TTabSheet;
    Label6: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    DBEdit6: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit9: TDBEdit;
    Label9: TLabel;
    DBEdit21: TDBEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    GanaciaDBEdit: TDBEdit;
    TabSheet4: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    Label3: TLabel;
    Label22: TLabel;
    Precio1DBEdit: TDBEdit;
    Precio2DBEdit: TDBEdit;
    Precio3DBEdit: TDBEdit;
    Precio6DBEdit: TDBEdit;
    Precio4DBEdit: TDBEdit;
    Precio5DBEdit: TDBEdit;
    DBText2: TDBText;
    TabSheet5: TTabSheet;
    CuentaDataSource: TDataSource;
    Label50: TLabel;
    CuentaDBLookupComboBox: TDBLookupComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    Label54: TLabel;
    Label53: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    RubroDBLookupComboBox: TDBLookupComboBox;
    RubroBitBtn: TBitBtn;
    MarcaDBLookupComboBox: TDBLookupComboBox;
    MarcaBitBtn: TBitBtn;
    CategoriaDBLookupComboBox: TDBLookupComboBox;
    CategoriaBitBtn: TBitBtn;
    Label29: TLabel;
    Tabla: TIBTable;
    CategoriaT: TIBTable;
    SubCategoriaT: TIBTable;
    RubroT: TIBTable;
    MaterialT: TIBTable;
    QTemp: TIBQuery;
    Usuario: TIBQuery;
    DSUsuarios: TDataSource;
    CuentaQuery: TIBQuery;
    MarcaT: TIBTable;
    ProveedorT: TIBTable;
    ConfigQuery: TIBQuery;
    Label1: TLabel;
    CodigoDBEdit: TDBEdit;
    BitBtn4: TBitBtn;
    DBNavigator1: TDBNavigator;
    Label24: TLabel;
    CodigoBarraEdit: TDBEdit;
    CodigoBarraBitBtn: TBitBtn;
    PaintBox1: TImage;
    DBEdit2: TDBEdit;
    Label35: TLabel;
    IVADBComboBox: TDBComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RubroBitBtnClick(Sender: TObject);
    procedure CodigoBarraBitBtnClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Precio6DBEditExit(Sender: TObject);
    procedure CategoriaBitBtnClick(Sender: TObject);
    procedure MarcaBitBtnClick(Sender: TObject);
    procedure DBEdit14Exit(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure TablaAfterInsert(DataSet: TDataSet);
    procedure GanaciaDBEditExit(Sender: TObject);
    procedure TablaAfterPost(DataSet: TDataSet);
    procedure TablaAfterCancel(DataSet: TDataSet);
    procedure TablaAfterDelete(DataSet: TDataSet);
    procedure MarcaDBLookupComboBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox4Enter(Sender: TObject);
    procedure CategoriaDBLookupComboBoxEnter(Sender: TObject);
    procedure RubroDBLookupComboBoxEnter(Sender: TObject);
    procedure MarcaDBLookupComboBoxEnter(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    desc: string;
    Precio1, Precio2, Precio3, Precio4, Precio5, Precio6, PrecioCtaCte: Double;
    { Public declarations }
    // procedimiento que codifica el n�mero en un n� binario
    procedure Codifica(num: string);
    // procedimiento para dibujar el c�d. de barras a partir del n� binario
    procedure Dibujar(matrix: string);
    // procedimiento para validar-corregir los c�digos
    procedure EANCorrecto(var num: string);
    Procedure nuevo;
    function CalcularIVA(neto,porcentaje:Double):Double;
  end;

var
  FProductos: TFProductos;

implementation

uses UFBuscaArticulos, Color, OperacionDM;

{$R *.dfm}

function  TFProductos.CalcularIVA;
begin
  Result := neto + (neto * (porcentaje / 100));
end;

procedure TFProductos.EANCorrecto(var num: string);
var
  i, N: byte;
  sum: integer;
  flag: byte;
begin
  sum := 0;
  N := Length(num) - 1; // 13-1=12
  for i := 1 to N do // desde 1 hasta 12
  begin
    if (i mod 2) = 0 then // x mod y = x � (x div y) * y = 1-(0.5)*2
    begin
      if N = 12 then
        sum := sum + StrToInt(num[i]) * 3
      else
        sum := sum + StrToInt(num[i]);
    end
    else
    begin
      if N = 12 then
        sum := sum + StrToInt(num[i])
      else
        sum := sum + StrToInt(num[i]) * 3;
    end;
  end;
  if sum > 99 then
    flag := 10 - (sum mod 100)
  else
    flag := 10 - (sum mod 10);
  if flag = 10 then
    flag := 0;
  if not(StrToInt(num[N + 1]) = flag) then
    num := copy(num, 1, Length(num) - 1) + IntToStr(flag);
end;

procedure TFProductos.Codifica(num: string);
var
  matrix: string;
  i: integer;
begin
  num := CodigoBarraEdit.Text; // numero
  matrix := '';
  case Length(num) of // mientras sean 13 caracteres
    13:
      begin
        EANCorrecto(num); //
        CodigoBarraEdit.Text := num;
        matrix := matrix + 'x0x'; // barra inicio
        matrix := matrix + EAN_izqA[StrToInt(num[2])];
        for i := 3 to 7 do
          if CodificaIzq[StrToInt(num[1])][i - 3] = 'A' then
            matrix := matrix + EAN_izqA[StrToInt(num[i])]
          else
            matrix := matrix + EAN_izqB[StrToInt(num[i])];
        matrix := matrix + '0x0x0'; // barra central
        matrix := matrix + EAN_dcha[StrToInt(num[8])];
        matrix := matrix + EAN_dcha[StrToInt(num[9])];
        matrix := matrix + EAN_dcha[StrToInt(num[10])];
        matrix := matrix + EAN_dcha[StrToInt(num[11])];
        matrix := matrix + EAN_dcha[StrToInt(num[12])];
        matrix := matrix + EAN_dcha[StrToInt(num[13])];
        matrix := matrix + 'x0x'; // barra final
        Dibujar(matrix);
      end;
    8:
      begin
        EANCorrecto(num);
        CodigoBarraEdit.Text := num;
        matrix := matrix + 'x0x';
        matrix := matrix + EAN_izqA[StrToInt(num[1])];
        matrix := matrix + EAN_izqA[StrToInt(num[2])];
        matrix := matrix + EAN_izqA[StrToInt(num[3])];
        matrix := matrix + EAN_izqA[StrToInt(num[4])];
        matrix := matrix + '0x0x0';
        matrix := matrix + EAN_dcha[StrToInt(num[5])];
        matrix := matrix + EAN_dcha[StrToInt(num[6])];
        matrix := matrix + EAN_dcha[StrToInt(num[7])];
        matrix := matrix + EAN_dcha[StrToInt(num[8])];
        matrix := matrix + 'x0x';
        Dibujar(matrix);
      end
  else
    ShowMessage('LONGITUD DE CODIGO NO VALIDA');
  end;
end;

procedure TFProductos.Dibujar(matrix: string);
var
  i: integer;
begin
  with PaintBox1 do
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
    Canvas.Pen.Color := clBlack;
  end;
  for i := 1 to Length(matrix) do
    if matrix[i] = '1' then
      PaintBox1.Canvas.PolyLine([Point(10 + i, 10), Point(10 + i, 50)])
    else if matrix[i] = 'x' then
      PaintBox1.Canvas.PolyLine([Point(10 + i, 10), Point(10 + i, 55)]);
  if Length(CodigoBarraEdit.Text) = 13 then
  begin
    PaintBox1.Canvas.TextOut(3, 50, CodigoBarraEdit.Text[1]);
    PaintBox1.Canvas.TextOut(17, 50, copy(CodigoBarraEdit.Text, 2, 6));
    PaintBox1.Canvas.TextOut(63, 50, copy(CodigoBarraEdit.Text, 8, 6));
  end
  else if Length(CodigoBarraEdit.Text) = 8 then
  begin
    PaintBox1.Canvas.TextOut(16, 50, copy(CodigoBarraEdit.Text, 1, 4));
    PaintBox1.Canvas.TextOut(48, 50, copy(CodigoBarraEdit.Text, 5, 4));
  end;
end;

procedure TFProductos.BitBtn1Click(Sender: TObject);
begin
  desc := CodigoDBEdit.Text;
  If (Tabla.State = dsEdit) or (Tabla.State = dsInsert) And
    (DescripcionDBEdit.Text <> '') then
    Tabla.Post
  else if (DescripcionDBEdit.Text <> '') then
    ShowMessage('COMPLETE TODOS LOS CAMPOS');
  Close;
end;

procedure TFProductos.BitBtn2Click(Sender: TObject);
begin
  Tabla.Cancel;
  Close;
end;

procedure TFProductos.FormCreate(Sender: TObject);
begin
  // DM := TDM.Create(Self);
  Tabla.Active := True;
  SubCategoriaT.Active := True;
  ProveedorT.Active := True;
  RubroT.Active := True;
  MarcaT.Active := True;
  CategoriaT.Active := True;
  with DM do
  begin
    ConfigQuery.Open;
    Precio1 := ConfigQuery.FieldByName('PP1').AsFloat / 100 + 1;
    Precio2 := ConfigQuery.FieldByName('PP2').AsFloat / 100 + 1;
    Precio3 := ConfigQuery.FieldByName('PP3').AsFloat / 100 + 1;
    Precio4 := ConfigQuery.FieldByName('PP4').AsFloat / 100 + 1;
    Precio5 := ConfigQuery.FieldByName('PP5').AsFloat / 100 + 1;
    Precio6 := ConfigQuery.FieldByName('PP6').AsFloat / 100 + 1;
    PrecioCtaCte := ConfigQuery.FieldByName('PP').AsFloat / 100 + 1;
  end;
  QTemp.Close;
  CuentaQuery.Open;
  Tabla.Insert;
end;

procedure TFProductos.BitBtn4Click(Sender: TObject);
begin
  TabSheet1.PageControl.ActivePageIndex := 0;
  Tabla.Cancel;
  FBuscaArticulo := TFBuscaArticulo.Create(Self);
  try
    FBuscaArticulo.ShowModal;
  finally
    If FBuscaArticulo.Tabla.Active = True then
      Tabla.Locate('CODIGO', FBuscaArticulo.Tabla.FieldByName('CODIGO')
        .AsInteger, []);
    FBuscaArticulo.Free;
  end;
  Tabla.Edit;
  Codifica(CodigoBarraEdit.Text);
end;

procedure TFProductos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end;
end;

procedure TFProductos.GanaciaDBEditExit(Sender: TObject);
var
  costo, flete,tasa: Double;
begin
  if CostoDBEdit.Text = '' then
    CostoDBEdit.Text := '0';
  if FleteDBEdit.Text = '' then
    FleteDBEdit.Text := '0';
//  if IVADBEdit.Text = '' then
//    IVADBEdit.Text := '0';
  if GanaciaDBEdit.Text = '' then
    GanaciaDBEdit.Text := '0';
  costo := StrToFloat(CostoDBEdit.Text);
  flete := costo * (StrToFloat(FleteDBEdit.Text) / 100);
  costo := costo + flete;
  if IVADBComboBox.Text = '21' then tasa:=StrToFloat(IVADBComboBox.Text)
  else tasa:=StrToFloat(IVADBComboBox.Text)/100;

  if GanaciaDBEdit.Text = '0' then
        PrecioCtaCteDBEdit.Text := FloatToStr( CalcularIVA((costo * PrecioCtaCte),tasa + flete))
   else
   //     PrecioCtaCteDBEdit.Text := FloatToStr((neto + iva));
  PrecioCtaCteDBEdit.Text := FloatToStr( CalcularIVA( (costo * (StrToFloat(GanaciaDBEdit.Text) / 100 + 1)),tasa));

//Precio1DBEdit.Text := FloatToStr((costo * Precio1) + iva);
Precio1DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio1),tasa) );
//  Precio2DBEdit.Text := FloatToStr((costo * Precio2) + iva);
Precio2DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio2),tasa) );
//  Precio3DBEdit.Text := FloatToStr((costo * Precio3) + iva);
Precio3DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio3),tasa) );
//  Precio4DBEdit.Text := FloatToStr((costo * Precio4) + iva);
Precio4DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio4),tasa) );
//  Precio5DBEdit.Text := FloatToStr((costo * Precio5) + iva);
Precio5DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio5),tasa) );
//  Precio6DBEdit.Text := FloatToStr((costo * Precio6) + iva);
Precio6DBEdit.Text := FloatToStr( CalcularIVA( (costo * Precio6),tasa) );

//  Label21.Caption := '= ' + FloatToStr(iva);
  DBText1.Caption := FloatToStr( costo );
  DBText2.Caption := FloatToStr( costo * (StrToFloat(GanaciaDBEdit.Text) / 100 + 1) );
  BitBtn1.SetFocus;
end;

Procedure TFProductos.nuevo;
begin
  Tabla.FieldByName('CtaNombre').AsString := '13';
  Tabla.FieldByName('CtaTipo').AsString := '13';
  Tabla.FieldByName('CtaAnticipo').AsString := '13';
  Tabla.FieldByName('CtaIIBB').AsString := '66';
  Tabla.FieldByName('CODIGOBARRA').AsString := '0';
  Tabla.FieldByName('Color').AsString := '0';
  Tabla.FieldByName('Categoria').AsString := '0';
  Tabla.FieldByName('SubCategoria').AsString := '0';
  Tabla.FieldByName('Rubro').AsString := '0';
  Tabla.FieldByName('Marca').AsString := '0';
  Tabla.FieldByName('Proveedor').Value := 1;
  DBLookupComboBox4.KeyValue := 0;
  DBEdit9.Field.AsString := 'c/u';
  DBEdit17.Field.AsDateTime := Date;
  Tabla.FieldByName('Costo').AsInteger := 0;
  CostoDBEdit.Field.AsFloat := 0;
  Tabla.FieldByName('ImpOtros').AsInteger := 0;
  FleteDBEdit.Field.AsFloat := 0;
  Tabla.FieldByName('Tasa').AsInteger := 0;
//  IVADBEdit.Field.AsFloat := 0;
  Tabla.FieldByName('Precio').AsInteger := 0;
  PrecioCtaCteDBEdit.Field.AsFloat := 0;
  Tabla.FieldByName('IIBB').AsInteger := 0;
end;

procedure TFProductos.RubroBitBtnClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Path + 'Rubro.exe')), SW_SHOWNORMAL);
  { RubroForm:=RubroForm.Create(self);
    try
    RubroForm.ShowModal;
    finally
    If RubroForm.desc <> '' then
    RubroDBLookupComboBox.KeyValue:= RubroForm.desc;
    Tabla.FieldByName('Rubro').AsString:=RubroForm.desc;
    RubroForm.Free;
    end;
    RubroT.Close;
    RubroT.Open;
    MarcaDBLookupComboBox.SetFocus;
  }

end;

procedure TFProductos.RubroDBLookupComboBoxEnter(Sender: TObject);
begin
  RubroT.Close;
  RubroT.Open;
  RubroT.Last;
end;

procedure TFProductos.CodigoBarraBitBtnClick(Sender: TObject);
var
  i: integer;
begin
  if Tabla.State = dsInsert then
  begin
    QTemp.Close;
    QTemp.SQL.Text := 'SELECT max(CODIGO) FROM "Articulo"';
    QTemp.Open;
    i := 1000000000 + (QTemp.Fields.Fields[0].AsInteger + 1);
    // agrego el codigo
  end
  else
  begin
    i := 1000000000 + StrToInt(CodigoDBEdit.Text);
    IF (Tabla.State <> dsEdit) then
      Tabla.Edit;
  end;
  // codigo de barras
  CodigoBarraEdit.Text := '10' + IntToStr(i) + '2';
  // lo incluyo en el codigo de barra
  Codifica(CodigoBarraEdit.Text);
  CodigoBarraEdit.SelStart := 0;
  CodigoBarraEdit.SelLength := Length(CodigoBarraEdit.Text);
  Tabla.FieldByName('CodigoBarra').AsString := CodigoBarraEdit.Text;
end;

procedure TFProductos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = VK_F2 then
    RubroBitBtn.Click;
  IF Key = VK_F3 then
    MarcaBitBtn.Click;
  IF Key = VK_F4 then
    BitBtn13.Click;
  IF Key = VK_F5 then
    BitBtn4.Click;
  IF Key = VK_F6 then
    CodigoBarraBitBtn.Click;
end;

procedure TFProductos.PaintBox1Click(Sender: TObject);
begin
  OperacionDataModule := TOperacionDataModule.Create(Self);
  with OperacionDataModule do
  begin
    CodigoBarra(CodigoBarraEdit.Text);
  end;
  OperacionDataModule.Free;
end;

procedure TFProductos.Precio6DBEditExit(Sender: TObject);
begin
//  IVADBEdit.SetFocus;
end;

procedure TFProductos.CategoriaBitBtnClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Path + 'Categoria.exe')), SW_SHOWNORMAL);
  {
    FCategorias:=TFCategorias.Create(self);
    try
    FCategorias.ShowModal;
    finally
    If FCategorias.desc <> '' then
    begin
    CategoriaDBLookupComboBox.KeyValue:= FCategorias.desc;
    Tabla.FieldByName('Categoria').AsString:=FCategorias.desc;
    end;
    FCategorias.Free;
    end;

    CategoriaT.Close;
    CategoriaT.Open;
    RubroDBLookupComboBox.SetFocus;
  }

end;

procedure TFProductos.CategoriaDBLookupComboBoxEnter(Sender: TObject);
begin
  CategoriaT.Close;
  CategoriaT.Open;
  CategoriaT.Last;
end;

procedure TFProductos.MarcaBitBtnClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Path + 'Marca.exe')), SW_SHOWNORMAL);
  { MarcaForm:=TMarcaForm.Create(self);
    try
    MarcaForm.ShowModal;
    finally
    If MarcaForm.desc <> '' then
    begin
    MarcaDBLookupComboBox.KeyValue:= MarcaForm.desc;
    If (Tabla.State <> dsEdit) and (Tabla.State <> dsInsert) then Tabla.Edit;
    Tabla.FieldByName('Marca').AsString:=MarcaForm.desc;
    end;
    MarcaForm.Free;
    end;
    MarcaT.Close;
    MarcaT.Open;
    DBEdit9.SetFocus;
  }

end;

procedure TFProductos.MarcaDBLookupComboBoxEnter(Sender: TObject);
begin
  MarcaT.Close;
  MarcaT.Open;
  MarcaT.Last;
end;

procedure TFProductos.MarcaDBLookupComboBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  MarcaT.Close;
  MarcaT.Open;
  MarcaT.Last;
end;

procedure TFProductos.DBEdit14Exit(Sender: TObject);
begin
  BitBtn1.SetFocus;
end;

procedure TFProductos.DBLookupComboBox4Enter(Sender: TObject);
begin
  ProveedorT.Close;
  ProveedorT.Open;
  ProveedorT.Last;
end;

procedure TFProductos.BitBtn13Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Path + 'Proveedor.exe')), SW_SHOWNORMAL);
end;

procedure TFProductos.TablaAfterCancel(DataSet: TDataSet);
begin
  Tabla.Transaction.RollbackRetaining;
end;

procedure TFProductos.TablaAfterDelete(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

procedure TFProductos.TablaAfterInsert(DataSet: TDataSet);
begin
  If Cancelar then
    Tabla.Cancel
  else
    nuevo;
end;

procedure TFProductos.TablaAfterPost(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

end.
