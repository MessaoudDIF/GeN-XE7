unit MarcaF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB,
  Mask, OleCtrls, SHDocVw, IBX.IBCustomDataSet, IBX.IBTable;

type
  TMarcaForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    DS: TDataSource;
    Tabla: TIBTable;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TablaAfterCancel(DataSet: TDataSet);
    procedure TablaAfterDelete(DataSet: TDataSet);
    procedure TablaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    desc: string;
    { Public declarations }
  end;

var
  MarcaForm: TMarcaForm;

implementation

{$R *.dfm}

procedure TMarcaForm.FormCreate(Sender: TObject);
begin
  //DM := TDM.Create(Self);
  Tabla.Active := true;
end;

procedure TMarcaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Tabla.Active := false;
end;

procedure TMarcaForm.BitBtn1Click(Sender: TObject);
begin
  desc := DBEdit1.Text;
  If (Tabla.State = dsEdit) or (Tabla.State = dsInsert) then
    If DBEdit1.Text <> '' then
    begin
      Tabla.Post;
    end;
  Close;
end;

procedure TMarcaForm.FormShow(Sender: TObject);
begin
  Tabla.Insert;
end;

procedure TMarcaForm.TablaAfterCancel(DataSet: TDataSet);
begin
  Tabla.Transaction.RollbackRetaining;
end;

procedure TMarcaForm.TablaAfterDelete(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

procedure TMarcaForm.TablaAfterPost(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

end.
