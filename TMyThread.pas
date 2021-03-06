unit TMyThread;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Objects, FMX.Graphics, FMX.Dialogs;

type
  TMyNewThread = class(TThread)
  private
    { Private declarations }
  public
    flag: boolean;
    x: integer;
    y: integer;
    xrange: integer;
    yrange: integer;
    PaintBox: TPaintBox;
  protected
    procedure Execute; override;
    procedure Repaint;
  end;

implementation

{ TMyThread }

procedure TMyNewThread.Execute;
begin
  inherited;
  Randomize;
  while flag do
  begin
    x := Random(xrange);
    y := Random(yrange);
    Synchronize(Repaint);
  end;

end;

procedure TMyNewThread.Repaint;
begin
  PaintBox.Repaint;
  TThread.Sleep(50);
end;

end.
