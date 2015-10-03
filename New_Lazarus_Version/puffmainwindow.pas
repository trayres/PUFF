unit puffmainwindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Menus, ComCtrls, ExtCtrls, BGRAGraphicControl, BCPanel,
  BGRAShape, PuffStruct, SmithChart, BGRABitmap, BGRABitmapTypes;

type

  TMouseState = Record
    PrevX, PrevY: Integer;
    MouseIsDown: Boolean;
    //mouse tool selected
    IsDraggingComponent : Boolean;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    a_edit: TEdit;
    b_edit: TEdit;
    c_edit: TEdit;
    d_edit: TEdit;
    e_edit: TEdit;
    f_edit: TEdit;
    g_edit: TEdit;
    h_edit: TEdit;
    i_edit: TEdit;
    LeftSide_RootPanel: TPanel;
    LayoutPaintBox: TPaintBox;
    Partlabel_a: TLabel;
    Partlabel_b: TLabel;
    Partlabel_c: TLabel;
    Partlabel_d: TLabel;
    Partlabel_e: TLabel;
    Partlabel_f: TLabel;
    Partlabel_g: TLabel;
    Partlabel_h: TLabel;
    Partlabel_i: TLabel;
    PlotPanel: TPanel;
    PartsPanel: TPanel;
    BoardPanel: TPanel;
    PartsBoard_Splitter: TSplitter;
    Points_Editbox: TEdit;
    Points_Label: TLabel;
    FrequencyChart: TChart;
    SmithChart: TChart;
    SmithRadius_Label: TLabel;
    Smith_Layout_Splitter: TSplitter;
    Frequency_LayoutSmith_Splitter: TSplitter;
    PuffInst : TPuffStruct;
    FrequencyChartLineSeries1: TLineSeries;
    MenuItem_Help: TMenuItem;
    MenuItem_About: TMenuItem;
    PuffCmdEdit: TEdit;
    PuffCmdLstBox: TListBox;
    PuffMenu: TMainMenu;
    PuffStatusBar: TStatusBar;
    LeftSide_Splitter: TSplitter;
    PlotParts_Splitter: TSplitter;
    Smith_Radius_Editbox: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure LayoutPaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LayoutPaintBoxPaint(Sender: TObject);
    procedure MenuItem_AboutClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
  version_string : String;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  I : Integer;
begin
  version_string :=  String({$I %DATE%}); // {$I %TIME%} Right now this is a crude date - we'll come up with something better later.
  {$IFDEF DEBUG}
  WriteLn(version_string);
  WriteLn('Program: ', ParamStr(0));
  for I := 1 to ParamCount do
  begin
    WriteLn('Param ', I, ': ', ParamStr(I));
    WriteLn('ParamCount:  ', ParamCount);
  end;
    {$ENDIF DEBUG}
  Caption := 'PUFF ' + String(version_string);
  PuffCmdLstBox.Clear;
  PuffCmdLstBox.Items.Add('>>');
  PuffCmdEdit.Clear;
  PuffCmdEdit.Text:='>>';
  PrepareSmithChart(SmithChart);
end;

procedure TMainForm.LayoutPaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     PuffStatusBar.Panels[0].Text:='('+IntToStr(X)+','+IntToStr(Y)+')';
end;

procedure TMainForm.LayoutPaintBoxPaint(Sender: TObject);
var bmp: TBGRABitmap;
begin
  bmp := TBGRABitmap.Create(ClientWidth, ClientHeight, BGRABlack);
  bmp.FillRect(20, 20, 100, 40, BGRA(255,192,0), dmSet);  //fill an orange rectangle
  bmp.Draw(LayoutPaintBox.Canvas, 0, 0, True);                           //render BGRABitmap on the form
  bmp.Free;                                               //free memory
end;

procedure TMainForm.MenuItem_AboutClick(Sender: TObject);
begin
  ShowMessage('PUFF, Version ' + version_string + sLineBreak +
  'Copyright (C) 1991, Scott W. Wedge, Richard Compton, David Rutledge' + sLineBreak +
  '(C) 1997, 1998 Andreas Gerstlauer' + sLineBreak +
  '2010 - Code released under the GNU General Public License version 3' + sLinebreak +
  '(C) 2000-2010 Pieter-Tjerk de Boer' + sLineBreak +
  '(C) 2009 Leland C. Scott' + sLineBreak +
  '(C) 2015 Travis Ayres; Multi-Platform Refactoring and Updates' + sLineBreak +
  'http://www.its.caltech.edu/~mmic/puff.html -> for the original version' + sLineBreak +
  'http://wwwhome.cs.utwente.nl/~ptdeboer/ham/puff.html -> for the Linux version' + sLineBreak +
  'https://github.com/trayres/PUFF -> For updated Multi-Platform Lazarus version');
end;

{procedure TMainForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     PuffStatusBar.Panels[0].Text:='('+IntToStr(X)+','+IntToStr(Y)+')';
end;}


end.

