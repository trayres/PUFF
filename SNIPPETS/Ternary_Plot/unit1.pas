unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TAFuncSeries, TASources,
  TATools, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnGridColor: TColorButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    CbShowGrid: TCheckBox;
    Chart1LineSeries6: TLineSeries;
    BtnBkColor: TColorButton;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    ListChartSource1: TListChartSource;
    Panel1: TPanel;
    RandomChartSource1: TRandomChartSource;
    procedure BtnBkColorColorChanged(Sender: TObject);
    procedure BtnGridColorColorChanged(Sender: TObject);
    procedure CbShowGridChange(Sender: TObject);
    procedure Chart1AfterPaint(ASender: TChart);
    procedure ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
      const APoint: TPoint; var AHint: String);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  ternary, TACustomSeries;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  PrepareTernaryChart(Chart1);


  AddTernary(ListChartSource1,  0.3,  1.2, 98.5, Format('A=%f, B=%f, C=%f', [ 0.3,  1.2, 98.5]), clRed);
  AddTernary(ListChartSource1, 10.5,  7.3, 82.2, Format('A=%f, B=%f, C=%f', [10.5,  7.3, 82.2]));
  AddTernary(ListChartSource1, 21.1, 13.4, 65.5, Format('A=%f, B=%f, C=%f', [21.1, 13.4, 65.5]));
  AddTernary(ListChartSource1, 32.4, 21.3, 46.3, Format('A=%f, B=%f, C=%f', [32.4, 21.3, 46.3]));
  AddTernary(ListChartSource1, 43.3, 25.3, 31.4, Format('A=%f, B=%f, C=%f', [43.3, 25.3, 31.4]));
  AddTernary(ListChartSource1, 62.4, 32.2, 15.4, Format('A=%f, B=%f, C=%f', [62.4, 32.2, 15.4]));
  AddTernary(ListChartSource1, 80.5, 19.1,  0.4, Format('A=%f, B=%f, C=%f', [80.5, 19.1,  0.4]), clGreen);

  AddTernary(Chart1LineSeries2, 19.9, 80.1, 0.0, Format('A=%f, B=%f, C=%f', [19.9, 80.1,  0.0]));
  AddTernary(Chart1LineSeries2, 15.5, 84.5, 0.0, Format('A=%f, B=%f, C=%f', [15.5, 84.5,  0.0]));
  AddTernary(Chart1LineSeries2, 13.7, 86.3, 0.0, Format('A=%f, B=%f, C=%f', [13.7, 86.3,  0.0]));
  AddTernary(Chart1LineSeries2, 11.5, 88.5, 0.0, Format('A=%f, B=%f, C=%f', [11.5, 88.5,  0.0]));

  AddTernary(Chart1LineSeries3, 62.4, 32.2, 15.4);
  AddTernary(Chart1LineSeries3, 19.9, 80.1,  0.0);

  AddTernary(Chart1LineSeries4, 43.3, 25.3, 31.4);
  AddTernary(Chart1LineSeries4, 15.5, 84.5,  0.0);

  AddTernary(Chart1LineSeries5, 32.4, 21.3, 46.3);
  AddTernary(Chart1LineSeries5, 13.7, 86.3,  0.0);

  AddTernary(Chart1LineSeries6, 21.1, 13.4, 65.5);
  AddTernary(Chart1LineSeries6, 11.5, 88.5,  0.0);
end;

procedure TForm1.Chart1AfterPaint(ASender: TChart);
begin
  DrawTernaryAxes(ASender, 'Material A', 'Material B', 'Material C', BtnBkColor.ButtonColor);
end;

procedure TForm1.ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
  const APoint: TPoint; var AHint: String);
var
  ser: TChartSeries;
  i: integer;
begin
  ser := TChartSeries(ATool.Series);
  i := ATool.PointIndex;
  AHint := ser.ListSource.Item[i]^.Text;
end;

procedure TForm1.CbShowGridChange(Sender: TObject);
begin
  Chart1.BottomAxis.Grid.Visible := CbShowGrid.Checked;
end;

procedure TForm1.BtnGridColorColorChanged(Sender: TObject);
begin
  Chart1.BottomAxis.Grid.Color := BtnGridColor.ButtonColor;
  Chart1.Refresh;
end;

procedure TForm1.BtnBkColorColorChanged(Sender: TObject);
begin
  Chart1.Refresh;
end;

end.

