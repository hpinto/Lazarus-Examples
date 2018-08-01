unit UFMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, LCLType, {comobj,} IniFiles, xmailer;

type

  { TFMain }

  TFMain = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    function EnviarMail(Usuario,Clave,Destinatario,Asunto,Mensaje,Servidor,Puerto: AnsiString;FullSSL,TLS: Boolean):Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label11MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Label11MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SoloNumeros(Sender: TObject; var Key: char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FMain: TFMain;
  Excel: OLEVariant;
implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.SpeedButton1Click(Sender: TObject);
Var
  Path: Variant;
begin
  if OpenDialog1.Execute then
    begin
      Edit10.Text:=OpenDialog1.FileName;
      try
        Excel := CreateOleObject('Excel.Application');
        try
          Excel.Visible := False;
          Excel.DisplayAlerts := False;
          try
            Path := OpenDialog1.FileName;
            Excel.WorkBooks.Open(Path);
          except
            Application.MessageBox(PChar('Error al abrir el archivo '+OpenDialog1.FileName),PChar(Application.Title),MB_ICONSTOP);
          end;
        finally
          SpeedButton2.Enabled := True;
        end;
      except
        SpeedButton2.Enabled := False;
        Application.MessageBox(PChar('Excel no está instalado en este equipo'),PChar(Application.Title),MB_ICONSTOP);
      end;
    end;
end;

procedure TFMain.SoloNumeros(Sender: TObject; var Key: char);
begin
  if not(Key in ['0'..'9',#8]) then Key := #0;
end;

procedure TFMain.FormCreate(Sender: TObject);
Var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ParamStr(0)+'.ini');
  if not(FileExists(Ini.filename)) then
    begin
      Ini.WriteString('Parameters','ColEmails','0');
      Ini.WriteString('Parameters','ColNombres','0');
      Ini.WriteString('Parameters','RowIni','0');
      Ini.WriteString('Parameters','RowFin','0');
      Ini.WriteString('Parameters','Server','smtp2.cruzblanca.cl');
      Ini.WriteString('Parameters','Port','25');
      Ini.WriteBool('Parameters','FullSSL',False);
      Ini.WriteBool('Parameters','TLS',True);
      Ini.WriteString('Parameters','User','alejandra.riquelme@gmail.com');
      Ini.WriteString('Parameters','Pass','');
      Ini.WriteString('Parameters','Asunto','Plan de Salud');
      Ini.WriteString('Parameters','Message','');
      Ini.UpdateFile;
    end;
  Edit1.Text := Ini.ReadString('Parameters','ColEmails','');
  Edit2.Text := Ini.ReadString('Parameters','ColNombres','');
  Edit3.Text := Ini.ReadString('Parameters','RowIni','');
  Edit9.Text := Ini.ReadString('Parameters','RowFin','');
  Edit4.Text := Ini.ReadString('Parameters','Server','');
  Edit5.Text := Ini.ReadString('Parameters','Port','');
  CheckBox1.Checked := Ini.ReadBool('Parameters','FullSSL',False);
  CheckBox2.Checked := Ini.ReadBool('Parameters','TLS',False);
  Edit6.Text := Ini.ReadString('Parameters','User','');
  Edit7.Text := Ini.ReadString('Parameters','Pass','');
  Edit8.Text := Ini.ReadString('Parameters','Asunto','');
  Memo1.Lines.CommaText := Ini.ReadString('Parameters','Message','');
  Ini.Free;
end;

function TFMain.EnviarMail(Usuario,Clave,Destinatario,Asunto,Mensaje,Servidor,Puerto: AnsiString;FullSSL,TLS: Boolean): Boolean;
var
  Mail: TSendMail;
begin
  Mail := TSendMail.Create;
  try
    Mail.Sender := Usuario;
    Mail.Receivers.Add(Destinatario);
    Mail.Subject := Asunto;
    Mail.Message.Add(Mensaje);
    //Mail.Attachments.Add('C:\saludos.log');
    Mail.Smtp.UserName := Usuario;
    Mail.Smtp.Password := Clave;
    Mail.Smtp.Host := Servidor;
    Mail.Smtp.Port := Puerto;
    mail.Smtp.FullSSL:=FullSSL;
    Mail.Smtp.TLS:=TLS;
    try
      Mail.Send;
      Result := True;
    except
      Result := False;
    end;
  finally
    Mail.Free;
  end;
end;

procedure TFMain.FormDestroy(Sender: TObject);
Var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ParamStr(0)+'.ini');
  Ini.WriteString('Parameters','ColEmails',Edit1.Text);
  Ini.WriteString('Parameters','ColNombres',Edit2.Text);
  Ini.WriteString('Parameters','RowIni',Edit3.Text);
  Ini.WriteString('Parameters','RowFin',Edit9.Text);
  Ini.WriteString('Parameters','Server',Edit4.Text);
  Ini.WriteString('Parameters','Port',Edit5.Text);
  Ini.WriteBool('Parameters','FullSSL',CheckBox1.Checked);
  Ini.WriteBool('Parameters','TLS',CheckBox2.Checked);
  Ini.WriteString('Parameters','User',Edit6.Text);
  Ini.WriteString('Parameters','Pass',Edit7.Text);
  Ini.WriteString('Parameters','Asunto',Edit8.Text);
  Ini.WriteString('Parameters','Message',Memo1.Lines.CommaText);
  Ini.UpdateFile;
  Ini.Free;
end;

procedure TFMain.Label11Click(Sender: TObject);
begin

end;

procedure TFMain.Label11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit7.PasswordChar := #0;
end;

procedure TFMain.Label11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit7.PasswordChar := '*';
end;

procedure TFMain.SpeedButton2Click(Sender: TObject);
Var
  Row,RowIni,RowFin,ColEmails,ColNombres,Buenos,Malos: Integer;
  Archivo: TStringList;
  Email,Nombre,Mensaje,LineaLOG: AnsiString;
begin
  if Length(Trim(Edit10.Text))=0 then
    begin
      Application.MessageBox(PChar('Primero debe Seleccionar un archivo Excel'),PChar(Application.Title),MB_ICONSTOP);
    end
  else if Length(Trim(Edit1.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar el n° de la columna con los emails'),PChar(Application.Title),MB_ICONSTOP);
      Edit1.SetFocus;
    end
  else if Trim(Edit1.Text)='0' then
    begin
      Application.MessageBox(PChar('El valor ingresado debe ser mayor que 0'),PChar(Application.Title),MB_ICONSTOP);
      Edit1.SetFocus;
    end
  else if Length(Trim(Edit2.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar el n° de la columna con los nombres'),PChar(Application.Title),MB_ICONSTOP);
      Edit2.SetFocus;
    end
  else if Trim(Edit2.Text)='0' then
    begin
      Application.MessageBox(PChar('El valor ingresado debe ser mayor que 0'),PChar(Application.Title),MB_ICONSTOP);
      Edit2.SetFocus;
    end
  else if Length(Trim(Edit3.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar la fila en dónde se inician los datos'),PChar(Application.Title),MB_ICONSTOP);
      Edit3.SetFocus;
    end
  else if Trim(Edit3.Text)='0' then
    begin
      Application.MessageBox(PChar('El valor ingresado debe ser mayor que 0'),PChar(Application.Title),MB_ICONSTOP);
      Edit3.SetFocus;
    end
  else if Length(Trim(Edit9.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar la fila en dónde se terminan los datos'),PChar(Application.Title),MB_ICONSTOP);
      Edit9.SetFocus;
    end
  else if Trim(Edit9.Text)='0' then
    begin
      Application.MessageBox(PChar('El valor ingresado debe ser mayor que 0'),PChar(Application.Title),MB_ICONSTOP);
      Edit9.SetFocus;
    end
  else if Length(Trim(Edit4.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar la dirección del servidor de correos'),PChar(Application.Title),MB_ICONSTOP);
      Edit4.SetFocus;
    end
  else if Length(Trim(Edit5.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar el n° de puerto del servidor de correos (usualmente es el 25)'),PChar(Application.Title),MB_ICONSTOP);
      Edit5.SetFocus;
    end
  else if Trim(Edit5.Text)='0' then
    begin
      Application.MessageBox(PChar('El valor ingresado debe ser mayor que 0'),PChar(Application.Title),MB_ICONSTOP);
      Edit5.SetFocus;
    end
  else if Length(Trim(Edit6.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar un usuario válido para el servidor de correos'),PChar(Application.Title),MB_ICONSTOP);
      Edit6.SetFocus;
    end
  else if Length(Trim(Edit7.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar una password para el usuario del servidor de correos'),PChar(Application.Title),MB_ICONSTOP);
      Edit7.SetFocus;
    end
  else if Length(Trim(Memo1.Text))=0 then
    begin
      Application.MessageBox(PChar('Debe ingresar el cuerpo del mensaje'),PChar(Application.Title),MB_ICONSTOP);
      Memo1.SetFocus;
    end
  else
    begin
      try
        Screen.Cursor:=crHourGlass;
        Buenos := 0;
        Malos := 0;
        Archivo    := TStringList.Create;
        Archivo.Add(FormatDateTime('YYYY/MM/DD HH:NN:SS.ZZZ',now)+' - Inicio');
        ColEmails  := StrToInt(Edit1.Text);
        ColNombres := StrToInt(Edit2.Text);
        RowIni    := StrToInt(Edit3.Text);
        RowFin    := StrToInt(Edit9.Text);
        for Row:=RowIni to RowFin do
          begin
            Email  := Trim(AnsiString(Excel.Cells[Row,ColEmails].Value));
            Nombre := Trim(AnsiString(Excel.Cells[Row,ColNombres].Value));
            Mensaje := Trim(AnsiString(Memo1.Lines.CommaText));
            Mensaje := Copy(Mensaje,2,Length(Mensaje)-2);
            Mensaje := StringReplace(Mensaje,'","',#13#10,[rfReplaceAll,rfIgnoreCase]);
            Mensaje := StringReplace(Mensaje,'",,"',#13#10#13#10,[rfReplaceAll,rfIgnoreCase]);
            Mensaje := StringReplace(Mensaje,'",,,"',#13#10#13#10#13#10,[rfReplaceAll,rfIgnoreCase]);
            if Pos('@Nombre',Mensaje)>0 then
              Mensaje := StringReplace(Mensaje,'@Nombre',Nombre,[rfReplaceAll,rfIgnoreCase]);
            if Pos('@Usuario',Mensaje)>0 then
              Mensaje := StringReplace(Mensaje,'@Usuario',AnsiString(Trim(Edit6.Text)),[rfReplaceAll,rfIgnoreCase]);
            LineaLOG := FormatDateTime('YYYY/MM/DD HH:NN:SS.ZZZ',now)+' - '+FormatFloat('00000000',Row)+' - '+Nombre+' - '+Email;
            Label1.Caption:=LineaLOG;
            Application.ProcessMessages;
            if Length(Trim(Email))=0 then
              begin
                Archivo.Add(LineaLOG+' - ERROR (Sin Email)');
                Inc(Malos);
              end
            else if EnviarMail(Trim(Edit6.Text),Trim(Edit7.Text),Email,Trim(Edit8.Text),Mensaje,Trim(Edit4.Text),Trim(Edit5.Text),CheckBox1.Checked,CheckBox2.Checked) then
              begin
                Archivo.Add(LineaLOG+' - Enviado');
                Inc(Buenos);
              end
            else
              begin
                Archivo.Add(LineaLOG+' - ERROR (Envío)');
                Inc(Malos);
              end;
            Label1.Caption:=LineaLOG;
            Application.ProcessMessages;
          end;
        Archivo.Add(FormatDateTime('YYYY/MM/DD HH:NN:SS.ZZZ',now)+' - Fin');
        Label1.Caption:='';
        Application.ProcessMessages;
        Application.MessageBox(PChar('Se han enviado correctamente '+FormatFloat('###,##0',Buenos)+' emails y '+FormatFloat('###,##0',Malos)+' han presentado problemas'),PChar(Application.Title),MB_ICONINFORMATION);
      finally
        Excel.Quit;
        Excel := Unassigned;
        SpeedButton2.Enabled:=False;
        Edit10.Text:='';
        Label1.Caption:='';
        Archivo.SaveToFile(Edit10.Text+'.'+FormatDateTime('YYYYMMDDHHNNSSZZZ',now)+'.Log');
        Archivo.Free;
        Screen.Cursor:=crDefault;
        Application.ProcessMessages;
      end;
    end;
end;

end.

