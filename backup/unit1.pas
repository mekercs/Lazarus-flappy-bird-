unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Unit2, Unit4,Unit5;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    start: TButton;
    toplista: TButton;
    kilepes: TButton;
    procedure FormCreate(Sender: TObject);
    procedure kilepesClick(Sender: TObject);
    procedure startClick(Sender: TObject);
    procedure toplistaClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses
  Unit3;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  grav := 2;
  irany := 80;
  Image1.Picture.LoadFromFile('flapy.jpg');
end;

procedure TForm1.kilepesClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.startClick(Sender: TObject);
begin
 // pontok:=-15;
  Form1.Hide;
  Form2.Show;
  jatekos:=kep;
end;

procedure TForm1.toplistaClick(Sender: TObject);
begin
  Form5.Memo1.Clear;
  Assignfile(txt,'rekordok');
  If fileexists('rekordok') then
  begin
    reset(txt);
    While not eof(txt) do
    begin
    readln(txt,asd);
    Form5.Memo1.Lines.Add(asd);
    end;
  end else
  begin
  rewrite(txt);
  reset(txt);
    While not eof(txt) do
    begin
    readln(txt,asd);
    Form5.Memo1.Lines.Add(asd);
    end;
  end;
  closefile(txt);
  Form5.Show;
end;

end.

