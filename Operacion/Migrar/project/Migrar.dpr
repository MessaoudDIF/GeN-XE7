program Migrar;

uses
  Forms,
  MigrarF in '..\form\MigrarF.pas' {MigrarForm},
  DataModule in '..\..\..\DataModule\DataModule.pas' {DM: TDataModule},
  OperacionDM in '..\..\..\DataModule\OperacionDM.pas' {OperacionDataModule: TDataModule},
  ImprimirDM in '..\..\..\DataModule\ImprimirDM.pas' {ImprimirDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MIGRAR';
  Application.CreateForm(TMigrarForm, MigrarForm);
  Application.Run;
end.
