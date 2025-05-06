unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LResources,
  Unit3;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure ScrollBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  nehezseg:integer;
  kep,kep2,kep3:TPortableNetworkGraphic;
  grav, irany: integer;


implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
  Scrollbar1.Position:=nehezseg;
    if nehezseg <= 2 then
  begin
    Label1.Caption := 'Könnyű';
  end
  else if nehezseg <= 5 then
    begin
    Label1.Caption := 'igen';
    end
  else
  begin
    Label1.Caption:='NEM';
end;
    kep:=TPortableNetworkGraphic.Create;
    kep.LoadFromFile('madar1.png');
    kep2:=TPortableNetworkGraphic.Create;
    kep2.LoadFromFile('madar2.png');
    kep3:=TPortableNetworkGraphic.Create;
    kep3.LoadFromFile('madar3.png');
    Image1.Canvas.Brush.Color:=clActiveCaption;
    Image1.Canvas.FillRect(Image1.ClientRect);
    Image1.Canvas.Draw(0,0,kep);
    Image1.Canvas.Draw((Image1.Width div 2)-15,0,kep2);
    Image1.Canvas.Draw(Image1.Width-34,0,kep3);
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    If (X>=0) and (X<=34) then
    begin
    jatekos:=kep;
    Image1.Canvas.Rectangle(0,0,34,24);
    end else if (X >= (Image1.Width div 2)-15) and (X <= (Image1.Width div 2)+17)  then
    begin
    jatekos:=kep2;
    Image1.Canvas.Rectangle((Image1.Width div 2)-15,0,(Image1.Width div 2)+18,24);
    end else if (X>=(Image1.Width-34)) and (X<=Image1.Width-2)then
    begin
    jatekos:=kep3;
    Image1.Canvas.Rectangle((Image1.Width-34),0,Image1.Width-2,24);
    end;

end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Image1.Canvas.Brush.Color:=clActiveCaption;
  Image1.Canvas.FillRect(Image1.ClientRect);
  Image1.Canvas.Brush.Style:=bsclear;
  Image1.Canvas.Draw(0,0,kep);
  Image1.Canvas.Draw((Image1.Width div 2)-15,0,kep2);
  Image1.Canvas.Draw(Image1.Width-34,0,kep3);
  If (X>=0) and (X<=34) then
  begin
    Image1.Canvas.Rectangle(0,0,34,24);
    end else if (X >= (Image1.Width div 2)-15) and (X <= (Image1.Width div 2)+17)  then
    begin
    Image1.Canvas.Rectangle((Image1.Width div 2)-15,0,(Image1.Width div 2)+18,24);
    end else if (X>=(Image1.Width-34)) and (X<=Image1.Width-2)then
    begin
    Image1.Canvas.Rectangle((Image1.Width-34),0,Image1.Width-2,24);
    end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.Hide;
  //törli majd újra létrehozza a form3 at :P
  Form3.Close;
  FreeAndNil(Form3);
  Application.CreateForm(TForm3, Form3);
  Form3.Show;
end;

procedure TForm2.ScrollBar1Change(Sender: TObject);
begin
  nehezseg := ScrollBar1.Position;

  if nehezseg <= 2 then
  begin
    Label1.Caption := 'Könnyű';
    grav:=2;
    irany:=80;
    koz:=2;
  end
  else if nehezseg <= 5 then
    begin
    Label1.Caption := 'igen';
    grav:=4;
    irany:=50;
    koz:=3;
    end
  else
  begin
    Label1.Caption:='NEM';
    grav:=6;
    irany:=40;
    koz:=5;
end;

end;

end.

