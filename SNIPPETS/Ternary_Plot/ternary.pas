{ Workaround for drawing ternary diagrams with TAChart.

  Usage:
  - Add a chart to the form, add series for data
  - At runtime, call PrepareTernaryChart after creation of the chart, i.e.
    in FormCreate
  - Call DrawTernaryAxes from the chart's OnAfterPaint event handler
  - Add ternary data to the series by calling AddTernary.

  Modifying the appearance of the chart:
  - the following properties are borrowed from the chart's bottom axis:
    - bottom axis title font is used for the corner labels
    - grid is determined by settings of bottom axis grid
    - length of ticks is determined by bottom axis TickLength
}

unit ternary;

{$mode objfpc}{$H+}

interface

uses
  Classes, Graphics, SysUtils, TAGraph, TACustomSeries, TASources, TAChartUtils;

procedure PrepareTernaryChart(AChart: TChart);

procedure DrawTernaryAxes(AChart: TChart;
  const AVertexA, AVertexB, AVertexC: String; ABackColor:TColor=clNone);

function AddTernary(ASeries:TChartSeries; x,y,z:double; AXLabel: String = '';
  AColor: TColor = clTAColor): Integer; overload;

function AddTernary(AChartSource:TListChartSource; x,y,z:double;
  AXLabel:String = ''; AColor: TColor = clTAColor): Integer; overload;

implementation

uses
  LCLIntf, FPCanvas;

type
  TMyChart = class(TChart);

procedure PrepareTernaryChart(AChart: TChart);
begin
  with AChart do begin
    BottomAxis.Visible := false;
    LeftAxis.Visible := false;
    Frame.Visible := false;
    Title.Font.Style := [fsBold];
    with Extent do begin
      XMin := -0.15;
      XMax := 1.15;
      YMin := -0.15;
      YMax := 1.0;
      UseXMin := true;
      UseXMax := true;
      UseYMin := true;
      UseYMax := true;
    end;
  end;
end;

procedure DrawTernaryAxes(AChart: TChart;
  const AVertexA, AVertexB, AVertexC: String; ABackColor:TColor=clNone);
var
  i: Integer;
  pt: TPoint;
  s: String;
  x1, y1, x2, y2: Integer;
  dx, dy: Integer;
  dxt, dyt: Integer;
  h: array[0..10] of double;
  h0: double;
  gridClr: TColor;
  axClr: TColor;
  bkClr: TColor;
  showGrid: boolean;
  gridStyle: TPenstyle;
  pen: TPen;
  tickLen: integer;

  procedure DrawText(x,y: integer; const AText:string);
  begin
    with AChart do
      Drawer.TextOut.Pos(x, y).Text(AText).Done;
  end;

begin
  h0 := sqrt(3.0)/2.0;
  for i:=0 to 10 do
    h[i] := h0*i*0.1;

  with AChart do begin
    gridClr := BottomAxis.Grid.Color;
    axClr := BottomAxis.AxisPen.Color;
    if ABackColor = clNone then
      bkClr := BackColor
    else
      bkClr := ABackColor;
    showGrid := BottomAxis.Grid.Visible;
    tickLen := BottomAxis.TickLength;
    gridStyle := BottomAxis.Grid.Style;

    pen := TPen.Create;
    Drawer.Pen := pen;

    Drawer.SetBrushParams(bsSolid, bkClr);

    Drawer.Polygon([
      Point(XGraphToImage(0.0), YGraphToImage(0.0)),
      Point(XGraphToImage(1.0), YGraphToImage(0.0)),
      Point(XGraphToImage(0.5), YGraphToImage(h[10]))],
      0, 3);

    Drawer.SetBrushParams(bsClear, ABackColor);
    Drawer.Font := BottomAxis.Marks.LabelFont;
    pt := Drawer.TextExtent('0.9');

    dx := pt.X div 2;
    dy := pt.Y div 2;
    dyt := tickLen;
    if ShowGrid then begin
      Drawer.SetPenParams(gridStyle, gridClr);
      for i:=1 to 9 do begin
        x1 := XGraphToImage(i*0.1);
        y1 := YGraphToImage(0.0);
        x2 := XGraphToImage(0.5 + 0.05*i);
        y2 := YGraphToImage(h[10-i]);
        Drawer.Line(x1, y1, x2, y2);
      end;
    end;
    Drawer.SetPenParams(psSolid, axClr);
    Drawer.Line(XGraphToImage(0.0), YGraphToImage(0.0), XGraphToImage(1.0), YGraphToImage(0.0));
    for i:=0 to 10 do begin
      x1 := XGraphToImage(i*0.1);
      y1 := YGraphToImage(0.0);
      x2 := XGraphToImage(0.5 + 0.05*i);
      y2 := YGraphToImage(h[10-i]);
      Drawer.Line(x1, y1+dyt, x1, y1-dyt);
      DrawText(x1-dx, y1+dy, FormatFloat('0.0', 0.1*i));
    end;

    dx := pt.X div 2;
    dy := pt.Y;
    dxt := round(0.866*tickLen);
    dyt := round(0.5*tickLen);
    if showGrid then begin
      Drawer.SetPenParams(gridStyle, gridClr);
      for i:=1 to 9 do begin
        x1 := XGraphToImage(1.0 - 0.05*i);
        y1 := YGraphToImage(h[i]);
        x2 := XGraphToImage(0.05*i);
        y2 := YGraphToImage(h[i]);
        Drawer.Line(x1, y1, x2, y2);
      end;
    end;
    Drawer.SetPenParams(psSolid, axClr);
    Drawer.Line(XGraphToImage(1.0), YGraphToImage(0.0), XGraphToImage(0.5), YGraphToImage(h[10]));
    for i:=0 to 10 do begin
      x1 := XGraphToImage(1.0 - 0.05*i);
      y1 := YGraphToImage(h[i]);
      x2 := XGraphToImage(0.05*i);
      y2 := YGraphToImage(h[i]);
      Drawer.Line(x1+dxt, y1-dyt, x1-dxt, y1+dyt);
      DrawText(x1+dx, y1-dy, FormatFloat('0.0', 0.1*i));
    end;

    dx := 3*pt.X div 2;
    dy := pt.Y;
    dxt := round(0.866*tickLen);
    dyt := round(0.5*tickLen);
    if showGrid then begin
      Drawer.SetPenParams(gridStyle, gridClr);
      for i:=1 to 9 do begin
        x1 := XGraphToImage(0.05*i);
        y1 := YGraphToImage(h[i]);
        x2 := XGraphToImage(0.1*i);
        y2 := YGraphToImage(0.0);
        Drawer.Line(x1,y1, x2,y2);
      end;
    end;
    Drawer.SetPenParams(psSolid, axClr);
    Drawer.Line(XGraphToImage(0.5), YGraphToImage(h[10]), XGraphToImage(0.0), YGraphToImage(0.0));
    for i:=0 to 10 do begin
      x1 := XGraphToImage(0.05*i);
      y1 := YGraphToImage(h[i]);
      x2 := XGraphToImage(0.1*i);
      y2 := YGraphToImage(0.0);
      Drawer.Line(x1-dxt, y1-dyt, x1+dxt, y1+dyt);
      DrawText(x1-dx, y1-dy, FormatFloat('0.0', 1.0-0.1*i));
    end;

    Drawer.Font := BottomAxis.Title.Font;
    pt := Drawer.TextExtent(AVertexA);
    DrawText(XGraphToImage(0.5)-pt.X div 2, YGraphToImage(h[10])-round(pt.Y*2.5), AVertexA);

    pt := Drawer.TextExtent(AVertexB);
    DrawText(XGraphToImage(0.0)-pt.X div 2, YGraphToImage(0.0)+pt.Y*2, AVertexB);

    pt := Drawer.TextExtent(AVertexC);
    DrawText(XGraphToImage(1.0) - pt.X div 2, YGraphToImage(0.0) + pt.Y*2, AVertexC);

    TMyChart(AChart).DisplaySeries(Drawer);
  end;

  pen.Free;
end;

function AddTernary(ASeries:TChartSeries; x,y,z:double; AXLabel: String = '';
  AColor: TColor = clTAColor): Integer;
var
  xx, yy: double;
begin
  xx := 0.5*(x + 2*z) / (x + y + z);
  yy := sqrt(3.0)*0.5 * x / (x + y + z);
  result := ASeries.AddXY(xx, yy, AXLabel, AColor);
end;

function AddTernary(AChartSource:TListChartSource; x,y,z:double;
  AXLabel:String = ''; AColor: TColor = clTAColor): Integer; overload;
var
  xx, yy: Double;
begin
  xx := 0.5*(x + 2*z) / (x + y + z);
  yy := sqrt(3.0)*0.5 * x / (x + y + z);
  result := AChartSource.Add(xx, yy, AXLabel, AColor);
end;

end.

