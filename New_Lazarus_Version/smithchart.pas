unit SmithChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, TAGraph, TACustomSeries, TASources, TAChartUtils;

procedure PrepareSmithChart(AChart: TChart);

implementation

procedure PrepareSmithChart(AChart: TChart);
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



end.

