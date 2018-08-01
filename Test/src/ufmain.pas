unit ufmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, fpcsvexport, FileUtil, fpdataexporter,
  fpspreadsheetctrls, fpspreadsheetgrid, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, ZConnection, ZDataset;

type

  { TFMain }

  TFMain = class(TForm)
    Button1: TButton;
    CSVExporter1: TCSVExporter;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    SaveDialog1: TSaveDialog;
    ZConnection1: TZConnection;
    ZTable1: TZTable;
    ZTable1idTest: TLongintField;
    ZTable1Testcol: TStringField;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
      CSVExporter1.FileName:=SaveDialog1.FileName;
      CSVExporter1.Execute;
    end;
end;

end.

