unit Unit3;

{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType,Unit4,
  StdCtrls;
type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

  private
    procedure map;

  public


  end;

var
  Form3: TForm3;
  move,jatekosx,jatekosy:integer;
  jatekos,alap,hater,cso_fel,cso_le:TPortableNetworkGraphic;
  akadalyok:array[0..11] of integer;
  a,x,y,i:integer;
  yes: array[0..2]of boolean;
  f,koz:integer;
    ujX, ujY, elozoY: Integer;
  j: Integer;

implementation


uses
  Unit1,Unit2;

{$R *.lfm}

{ TForm3 }
procedure TForm3.map;
var
  ujX, ujY, elozoY: Integer;
  j: Integer;
begin
  // előretolás: minden csőpárt eggyel előrébb mozgatunk
  for j := 0 to 4 do
  begin
    akadalyok[j * 2] := akadalyok[(j + 1) * 2];
    akadalyok[j * 2 + 1] := akadalyok[(j + 1) * 2 + 1];
  end;

  // új csőpár generálása a végére
  ujX := akadalyok[10] + 300;

  ujY := Random(Image1.Height - 300) + 100;

  If ujY < 160 then
  begin
    ujY:=250;
  end
  else if ujY > 800 then
  begin
    ujY:=800;
  end;

  akadalyok[10] := ujX;
  akadalyok[11] := ujY;

  // pontozás visszaállítása
  for i:=0 to length(yes) do
  begin
    yes[i]:=false;
  end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
    //madar zuhanása
    inc(jatekosy, grav);
    //hater betöltése
    Image1.Canvas.Draw(0,0,hater);
   // padlo
    If move=-1008 then
    begin
      move:=0
    end;
    dec(move,koz);
    Image1.Canvas.Draw(move,788,alap);
    //madar kirajzolása
    Image1.Canvas.Draw(jatekosx,jatekosy,jatekos);

    //a for ciklusban kirajzolja a csöveket és hitboxot csinál neki
    for i := 0 to (Length(akadalyok) div 2) - 1 do
    begin
      //az akaralyok jönnek feléd
      dec(akadalyok[i * 2],koz);
      //a csövek kirajzolása
      Image1.Canvas.Draw(akadalyok[i * 2], akadalyok[i * 2 + 1], cso_fel);
      Image1.Canvas.Draw(akadalyok[i * 2], akadalyok[i * 2 + 1] - 800, cso_le);
       //hitboxa a csöveknek
      If (jatekosX + 34 > akadalyok[i * 2]) and (jatekosX < akadalyok[i * 2] + 40) and (jatekosY + 24 > akadalyok[i * 2 + 1]) and (jatekosY < akadalyok[i * 2 + 1] + 840)
      then
      begin
        Timer1.Enabled:=false;
        Form4.Edit1.Text:='';
        Form4.Show;
      end;
      If (jatekosX + 34 > akadalyok[i * 2]) and (jatekosX < akadalyok[i * 2] + 40) and (jatekosY + 24 > akadalyok[i * 2 + 1 - 840]) and (jatekosY < akadalyok[i * 2 + 1]-200)
      then
      begin
        Timer1.Enabled:=false;
        Form4.Show;
      end;
      //pontok
      if (not yes[i]) and (jatekosx > akadalyok[i * 2] + 40)then
      begin
        Inc(pontok);
        yes[i] := true;
      end;
  end;
  //map generálás
    if akadalyok[0] < -40 then
    begin
      map();
      end;
    //pontok kiíratása
    Image1.Canvas.Brush.Style:=bsclear;
    Image1.Canvas.Font.Size:=32;
     Image1.Canvas.TextOut(0,0,intToStr(pontok));
    // ha a jatekos ki megy a padlóból akkor induljon újra
    If Jatekosy>=Image1.Height-112 then
    begin
        Timer1.Enabled:=false;
        Form4.Edit1.Text:='';
       Form4.Show;
    end else if Jatekosy< 0
    then
    begin
       Jatekosy:=10;

    end;
end;
procedure TForm3.Timer2Timer(Sender: TObject);
begin
end;

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
if Key = VK_W then
  begin
    dec(jatekosy,irany);
  end
  //mozgás le
  else if Key = VK_S then
  begin
    inc(jatekosy,irany);
  end;
end;

procedure TForm3.Image1Click(Sender: TObject);
begin

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  //jatekosx az fix
  jatekosx:=100;
  //jatekosy hogy kőzepen legyen
  jatekosy:=Image1.Height div 2;
  // betölti a képeket
  alap:=TPortableNetworkGraphic.Create;
  alap.LoadFromFile('alap.png');
  hater:=TPortableNetworkGraphic.Create;
  hater.LoadFromFile('hater.png');
  cso_fel:=TPortableNetworkGraphic.Create;
  cso_fel.LoadFromFile('cso_fel.png');
  cso_le:=TPortableNetworkGraphic.Create;
  cso_le.LoadFromFile('cso_le.png');
  //ez az x a csövekhez kell
  x := random(Image1.Width div 2);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  // itt indul a játék és feltölti a tömb elemeit
  jatekosx:=100;
  jatekosy:=Image1.Height div 2;
  Image1.Canvas.Draw(0,0,hater);
  Image1.Canvas.Draw(100,jatekosy,jatekos);
  if f = 0 then
  begin
    pontok:=-15;
    inc(f);
  end else
  begin
    pontok:=0;
  end;
  move:=0;
  {for i := 0 to (Length(akadalyok) div 2) - 1 do
  begin
    y := random(Image1.Height);
    x:=x+300;
    akadalyok[i * 2] := x;
    akadalyok[i * 2 + 1] := y;
  end;}
  map();
  yes[0] := false;
  //gomb eltűnik
  Timer1.Enabled:=True;
  Button1.Hide;
end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//Application.Terminate;
end;

end.

