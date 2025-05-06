unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;
  txt:textfile;
  pontok:integer;

implementation

uses
  Unit1,Unit3,Unit2;

{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  AssignFile(txt,'rekordok');
  if FileExists('rekordok') then
  begin
  if nehezseg <= 2 then
  begin
  append(txt);
  writeln(txt,Edit1.Text+':'+intToStr(pontok)+' könnyű');
  end
  else if nehezseg <= 5 then
    begin
    append(txt);
    writeln(txt,Edit1.Text+':'+intToStr(pontok)+' igen');
    end
  else
  begin
   append(txt);
   writeln(txt,Edit1.Text+':'+intToStr(pontok)+' NEM');
end;
  end else
  begin
   Rewrite(txt);
  end;
  closefile(txt);
  Form4.Hide;
  Form3.Close;
  Form3.Button1.Show;
  Form1.Show;

end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
end;

end.

