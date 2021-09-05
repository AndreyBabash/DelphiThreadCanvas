unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, TMyThread, FMX.Colors;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    ComboColorBox1: TComboColorBox;
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboColorBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    x:integer;
    y:integer;
    flag:boolean;
    t:TMyNewThread;
  end;

var
  Form1: TForm1;


implementation

{$R *.fmx}


procedure TForm1.Button1Click(Sender: TObject);
begin
  flag := true;
  t := TMyNewThread.Create(true);
  t.flag := flag;
  t.PaintBox := PaintBox1;
  t.xrange := Round(Form1.PaintBox1.Width);
  t.yrange := Round(Form1.PaintBox1.Height);
  x := 0;
  y := 0;
  t.FreeOnTerminate := true;
  t.Start;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  flag := false;
  if t <> nil then
    t.flag := Self.flag;
end;

procedure TForm1.ComboColorBox1Click(Sender: TObject);
begin
  Form1.Fill.Color:=ComboColorBox1.Color;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var PixelPos:TPointF;  PixelRegion:TRectF;
begin
  if t <> nil then
  begin
    Self.x := t.x;
    Self.y := t.y;
  end;
  PaintBox1.Canvas.Stroke.Color := TAlphaColors.Coral;
  PaintBox1.Canvas.Stroke.Dash := TStrokeDash.Solid;
  PaintBox1.Canvas.Stroke.Thickness := 4;
  PaintBox1.Canvas.BeginScene();
  PaintBox1.Canvas.DrawEllipse(TRectF.Create(0 + x, 0 + y, 40 + x,
    40 + y), 1.0);
  // PixelPos:=PaintBox1.Canvas.AlignToPixel(TPointF.Create(x,y));
  // PixelRegion:=TRectF.Create(PixelPos,1,1);
  // PaintBox1.Canvas.DrawRect(PixelRegion,0,0,AllCorners,1);
  PaintBox1.Canvas.EndScene;
end;

end.
