unit UFMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1MouseEnter(Sender: TObject);
    procedure Edit1MouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses Unit1;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
Var
  Resultado: Integer;
begin
  Resultado := Application.MessageBox(PChar(Edit1.Text),PChar(Application.Title),mb_iconquestion+mb_yesno);
  if Resultado = IDYES then
    ShowMessage('Apretaste YES')
  else
    ShowMessage('Apretaste NO');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.Edit1MouseEnter(Sender: TObject);
begin
  Edit1.PasswordChar:=#0;
end;

procedure TForm1.Edit1MouseLeave(Sender: TObject);
begin
  Edit1.PasswordChar:='*';
end;

end.

