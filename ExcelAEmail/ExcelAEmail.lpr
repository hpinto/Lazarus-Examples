program ExcelAEmail;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UFMain
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Excel a Email';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.

