unit puffmainwindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Menus, ComCtrls, ExtCtrls, BGRAGraphicControl, BCPanel,
  BGRAShape, PuffStruct, SmithChart, BGRABitmap, BGRABitmapTypes, LCLType;

type



  TMouseState = record
    PrevX, PrevY: integer;
    MouseIsDown: boolean;
    //mouse tool selected
    IsDraggingComponent: boolean;
  end;

  //TPuffCommand = (Invalid, ZoomIn, ZoomOut);

  {IPuffCommand = interface
    function ParseCommand(inputString: string): TPuffCommand;
  end;}

  {ILayout = Interface
   }
  //Add a base class color, width  - actually a variant record would work fine for that, unless I want to add
  EnumCompType = (LineP1P2, LineXYXY, RectangleTLBR, RectangleXYXY);
  //,   Ellipse, Arc);

  TPointReal = record
    X: real;
    Y: real;
  end;

  TRectTLBRreal = record
    TL: TPointReal;
    BR: TPointReal;
  end;

  ComponentType = record  //Component of graphical item - eg a line in a resistor
    Color: TColor;
    Width: Real;  //Never thought I'd miss 'Natural of range' from VHDL.
    case CompType: EnumCompType of  {These are all in Model coordinates}
      LineP1P2: (
        W:  Real;
        P1: TPointReal;
        P2: TPointReal);
      LineXYXY: (
        Width: real;
        X1: real;
        Y1: real;
        X2: real;
        Y2: real);
      RectangleTLBR: (
        TL: TPointReal;
        BR: TPointReal);
      RectangleXYXY: (
        RX1: TPointReal;
        RY1: TPointReal;
        RX2: TPointReal;
        RY2: TPointReal);
  end;

  TComponentTypeArray = array of ComponentType;


  { TSchematicObject }
  {Should be complicated enough to hold IEC 60617 symbols}
  {}
  TSchematicObject = class
    gfx_components : TComponentTypeArray; //Remember, put everything in world coords when we place items.
    anchorPt : TPointReal; //Drag from here - world coordinates
  public
    constructor Create({Color : TColor, Width});
    procedure drawSchematicObject(draw_point_world_coords : TPointReal; rotation_degree : integer); {Should I give this the viewport coordinates?}
  private
    BBox: TRectTLBRreal; //Remember, this is in world coordinates!
  end;

  TSchematicObjectArray = array of TSchematicObject;

  { TSchematicLibrary }

  TSchematicLibrary = class
    libraryItem: TSchematicObjectArray;
    constructor Create(var InputLibraryFile: TextFile);
    constructor Create;
  end;

  TSchematic = class
    class var total_instances: array of TSchematicObject;
    class var number_of_total_instances : integer;
  public
    current_viewport_instances : TSchematicObjectArray;
    ZoomValue     : Real;
    ZoomInt       : Integer;
    WorldTLBRreal : TRectTLBRreal;
    ViewTLBRreal  : TRectTLBRreal;
    OriginPt : TPointReal;
    ScreenRez: integer;
    SchWidthPixels  : integer;   //TODO: Should probably be private
    SchHeightPixels : integer;
    SchWidthInches: real;
    SchHeightInches: real;
    VCenter       : TPointReal;  //Center of the viewport
    constructor Create(var InputTextFile: TextFile);
    constructor Create;
    procedure ColdBootSchematic; //Gets initial window/screen info
    procedure getSchematicItems(var cvi : TSchematicObjectArray); //Uses ViewTLBRreal and class variable instances to determine what is visible, returns that list via
    function  SpanCheck(Mode : char; item : TRectTLBRreal) : boolean;
    //procedure   SetupSchematic;    //Call on window resize
    //procedure ResizeSchematic;
    procedure ZoomIn;
    procedure ZoomOut;
    //procedure drawSchematic;
    function getWorldCoords(X,Y : Integer) : TPointReal;    //From Viewport Coords, X,Y
    //procedure moveToWorldCoord(OriginPt : TPointReal);
    //procedure getWorldCoords(vPt :  TPoint);
    function getViewportCoords(vp_pt : TPointReal) : TPoint; //From World Coords
    //property WOrigin
    //procedure getOrigin;
    //procedure setOrigin;
    //procedure checkBoundingBox;
    //procedure addSchematicItem;
    procedure drawVisibleSchematicItems;
  private
  end;

  { TMainForm }

  TMainForm = class(TForm) {Should I add an interface, or static methods?}
    a_edit: TEdit;
    b_edit: TEdit;
    c_edit: TEdit;
    d_edit: TEdit;
    e_edit: TEdit;
    FrequencyChartLineSeries_S12: TLineSeries;
    FrequencyChartLineSeries_S21: TLineSeries;
    FrequencyChartLineSeries_S22: TLineSeries;
    f_edit: TEdit;
    g_edit: TEdit;
    h_edit: TEdit;
    i_edit: TEdit;
    BoardLabel: TLabel;
    MenuItem_File: TMenuItem;
    MenuItem_ShowDebug: TMenuItem;
    PartsLabel: TLabel;
    PlotLabel: TLabel;
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
    PuffInst: TPuffStruct;
    FrequencyChartLineSeries_S11: TLineSeries;
    MenuItem_Help: TMenuItem;
    MenuItem_About: TMenuItem;
    PuffMenu: TMainMenu;
    PuffStatusBar: TStatusBar;
    LeftSide_Splitter: TSplitter;
    PlotParts_Splitter: TSplitter;
    Smith_Radius_Editbox: TEdit;


    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LayoutPaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure LayoutPaintBoxPaint(Sender: TObject);
    procedure LayoutPaintBoxResize(Sender: TObject);
    procedure MenuItem_AboutClick(Sender: TObject);
    procedure MenuItem_ShowDebugClick(Sender: TObject);
   { procedure PuffCmdEditKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);}
    procedure UpdateStatusBar(X,Y : Integer);
  private
    { private declarations }
    //function ParseCommand(inputString: string): TPuffCommand;

  public
    { public declarations }

    //property LayoutPaintBoxWidth :
  end;

var
  MainForm: TMainForm;
  version_string: string;
  Schematic : TSchematic;
  schematic_bmp : TBGRABitmap;

implementation

uses DebugFormUnit;

{$R *.lfm}

{ TSchematicLibrary }

constructor TSchematicLibrary.Create(var InputLibraryFile: TextFile);
begin

end;

constructor TSchematicLibrary.Create;
begin

end;

{ TSchematic }

constructor TSchematic.Create(var InputTextFile: TextFile);
begin
  Self.ColdBootSchematic;
end;

constructor TSchematic.Create;
begin

  Self.ColdBootSchematic;
end;

procedure TSchematic.ColdBootSchematic;
begin
  //Determine DPI, assuming isotropic density in x/y
  //Get window width
  ScreenRez := Screen.PixelsPerInch;
  SchWidthPixels  := MainForm.LayoutPaintBox.Width; //TODO: Make sure to update on resize!
  SchHeightPixels := MainForm.LayoutPaintBox.Height; //TODO: Make sure to update on resize!
  SchWidthInches  := Real(MainForm.LayoutPaintBox.Width  / ScreenRez);
  SchHeightInches := Real(MainForm.LayoutPaintBox.Height / ScreenRez);
  OriginPt.X := 0.0;
  OriginPt.Y := 0.0;
  {$IFDEF DEBUG}
  WriteLn('ScreenRez: ' + Format('%D',[ScreenRez]));
  WriteLn('SchHeightPixels: ' + Format('%D', [SchHeightPixels]));
  WriteLn('SchWidthPixels: '  + Format('%D', [SchWidthPixels]));
  WriteLn('SchHeightInches: ' + Format('%F', [SchHeightInches]));
  WriteLn('SchWidthInches: '  + Format('%F', [SchWidthInches]));
  {$ENDIF DEBUG}

  //Place the World with (0,0) in the lower left hand corner
  //C Sized Sheet -> 17 X 22
  WorldTLBRreal.TL.X := -8.5;
  WorldTLBRreal.TL.Y :=   11;
  WorldTLBRreal.BR.X := 8.5;
  WorldTLBRreal.BR.Y := -11.0;
  VCenter.X:=0.0; //In World Coords
  VCenter.Y:=0.0;
  //ViewTLBRreal := WorldTLBRreal; //Currently view the world
  ViewTLBRreal.TL.X := -SchWidthInches/2.0;
  ViewTLBRreal.TL.Y :=  SchHeightInches/2.0;
  ViewTLBRreal.BR.X :=  SchWidthInches/2.0;
  ViewTLBRreal.BR.Y := -SchHeightInches/2.0;
  ZoomValue := 1.0;

  {Add a dummy component for testing.}
  schematic_bmp := TBGRABitmap.Create( SchWidthPixels, SchHeightPixels, BGRABlack);

end;

procedure TSchematic.getSchematicItems(var cvi: TSchematicObjectArray); {TODO: Change integer to TSchematicIndex,
which is just an alias for Integer; Also make sure this is re-called when an item is deleted, otherwise the data will be stale.}
{Relies on the schematic's ViewTLBRreal and class variable total_instances
to determine what is within the current viewport's bounding box.}
var
  item : TSchematicObject;
  cvi_length : Integer;
  max_cvi_length : Integer;
begin
   {Clear out cvi first, since we're using it to pass data back and forth and each call
   to this procedure is considered 'destructive' on that data [although that makes sense]}
  SetLength(cvi,1);

  cvi_length := 0;
  max_cvi_length := number_of_total_instances;
  SetLength(cvi, max_cvi_length);
  for item in total_instances do
    begin
      if SpanCheck('X',item.BBox) then begin
        cvi[cvi_length] := item;
        cvi_length += 1;
      end else if SpanCheck('Y',item.BBox) then begin
        cvi[cvi_length] := item;
        cvi_length += 1;
      end;
  end;
end;

function TSchematic.SpanCheck(Mode: char; item: TRectTLBRreal
  ): boolean;
begin
  case Mode of
    'X' :
      if     ( (item.TL.X >= ViewTLBRreal.TL.X) and (item.TL.X <= ViewTLBRreal.BR.X) ) then
        Result := True
      else if( (item.BR.X <= ViewTLBRreal.BR.X) and (item.BR.X >= ViewTLBRreal.TL.X) )  then
        Result := True
      else if( (item.TL.X <= ViewTLBRreal.TL.X) and (item.BR.X >= ViewTLBRreal.BR.X)  ) then
        Result := True
      else
        Result := False;
       'Y' :
         if     (item.TL.Y >= ViewTLBRreal.BR.Y) and (item.TL.Y <= ViewTLBRreal.TL.Y) then
           Result := True
         else if(item.BR.Y >= ViewTLBRreal.BR.Y) and (item.BR.Y <= ViewTLBRreal.TL.Y) then
           Result := True
         else if(item.TL.Y >= ViewTLBRreal.TL.Y) and (item.BR.Y <= ViewTLBRreal.BR.Y)  then
           Result := True
         else
           Result := False;
  end;{End Case}
end;

procedure TSchematic.ZoomIn;
begin
  ZoomValue *= 1/sqrt(2);
  {$IFDEF DEBUG}
  WriteLn('ZoomValue: '+Format('%F',[ZoomValue]));
  {$ENDIF DEBUG}
  SchWidthInches := (1/sqrt(2))*SchWidthInches;
  SchHeightInches:= (1/sqrt(2))*SchHeightInches;
  ViewTLBRreal.TL.X := -SchWidthInches/2.0;
  ViewTLBRreal.TL.Y :=  SchHeightInches/2.0;
  ViewTLBRreal.BR.X :=  SchWidthInches/2.0;
  ViewTLBRreal.BR.Y := -SchHeightInches/2.0;
end;

procedure TSchematic.ZoomOut;
begin
  ZoomValue *= sqrt(2);
  {$IFDEF DEBUG}
  WriteLn('ZoomValue: '+Format('%F',[ZoomValue]));
  {$ENDIF DEBUG}
  SchWidthInches := (sqrt(2))*SchWidthInches;
  SchHeightInches:= (sqrt(2))*SchHeightInches;
  ViewTLBRreal.TL.X := -SchWidthInches/2.0;
  ViewTLBRreal.TL.Y :=  SchHeightInches/2.0;
  ViewTLBRreal.BR.X :=  SchWidthInches/2.0;
  ViewTLBRreal.BR.Y := -SchHeightInches/2.0;
end;

function TSchematic.getWorldCoords(X, Y: Integer) : TPointReal;
{DOC: With the OriginPt in WorldCoordinates, and a point (X,Y) in ViewPort Pixels,
 return the WorldCoordinates of (X,Y). }
begin
     //Figure out how far we are into the viewport (as a percentage), multiply that by the width
     //of the window, then add that value to the left hand side of the top left value.
  //X and Y are in ViewPort Pixels
  //First do X
  Result.X := ViewTLBRreal.TL.X+SchWidthInches*(X/SchWidthPixels);
  //Then do Y
  Result.Y := ViewTLBRreal.TL.Y-SchHeightInches*(Y/SchHeightPixels);
end;

function TSchematic.getViewportCoords(vp_pt: TPointReal) : TPoint;
{From the real world coordinate point - used in drawing functions after establishing the bbox}
var
  X,Y : Real;
begin
  //Compare the viewpoint_point to the boundaries of the ViewTLBRreal
  X :=  ( (vp_pt.X - ViewTLBRreal.TL.X ) / SchWidthInches ) * SchWidthPixels ;
  Y :=  ( (ViewTLBRreal.TL.Y - vp_pt.Y ) / SchHeightInches) * SchHeightPixels;
  {WriteLn( Format('X: %f',[X]) );
  WriteLn( Format('Y: %f',[Y]) ); }
  Result.X := TRUNC(X);
  Result.Y := TRUNC(Y);
end;

procedure TSchematic.drawVisibleSchematicItems;
begin

end;

{ TSchematicObject }

constructor TSchematicObject.Create;
begin

end;

procedure TSchematicObject.drawSchematicObject(draw_point_world_coords : TPointReal; rotation_degree : integer);
begin

end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  I: integer;
begin
  version_string := string(
  {$I %DATE%}
    ); // {$I %TIME%} Right now this is a crude date - we'll come up with something better later.
  {$IFDEF DEBUG}
  WriteLn(version_string);
  WriteLn('Program: ', ParamStr(0));
  for I := 1 to ParamCount do
  begin
    WriteLn('Param ', I, ': ', ParamStr(I));
    WriteLn('ParamCount:  ', ParamCount);
  end;
    {$ENDIF DEBUG}
  Caption := 'PUFF ' + string(version_string);
  //PuffCmdLstBox.Clear;
  //PuffCmdLstBox.Items.Add('>>');
  //PuffCmdEdit.Clear;
  //PuffCmdEdit.Text := '>>';
  PrepareSmithChart(SmithChart);
  Schematic := TSchematic.Create;
  PuffMenu.Items[1].Items[1].Visible:=False;
  {$IFDEF DEBUG}
        //Set debug menu not to show up explicitly in Release builds.
        PuffMenu.Items[1].Items[1].Visible:=True;
  {$ENDIF DEBUG}

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  //Schematic.ColdBootSchematic;
end;

procedure TMainForm.LayoutPaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
begin
  UpdateStatusBar(X,Y);
end;

procedure TMainForm.LayoutPaintBoxPaint(Sender: TObject);
var
  bmp: TBGRABitmap;
begin
  bmp := TBGRABitmap.Create(ClientWidth, ClientHeight, BGRABlack);
  bmp.FillRect(20, 20, 100, 40, BGRA(255, 192, 0), dmSet);  //fill an orange rectangle
  bmp.Draw(LayoutPaintBox.Canvas, 0, 0, True);
  //render BGRABitmap on the form
  bmp.Free;                                               //free memory
end;

procedure TMainForm.LayoutPaintBoxResize(Sender: TObject);
begin
  //Should replace this with Schematic.Resize function to keep things private.
  Schematic.SchWidthPixels  := MainForm.LayoutPaintBox.Width; //TODO: Make sure to update on resize!
  Schematic.SchHeightPixels := MainForm.LayoutPaintBox.Height; //TODO: Make sure to update on resize!
  Schematic.SchWidthInches  := Real(MainForm.LayoutPaintBox.Width  / Schematic.ScreenRez);
  Schematic.SchHeightInches := Real(MainForm.LayoutPaintBox.Height / Schematic.ScreenRez);
  Schematic.ViewTLBRreal.BR.X:=Schematic.ViewTLBRreal.TL.X + Schematic.SchWidthInches;
  Schematic.ViewTLBRreal.BR.Y:=Schematic.ViewTLBRreal.TL.Y - Schematic.SchHeightInches;
  schematic_bmp.Free;
  schematic_bmp := TBGRABitmap.Create(Schematic.SchWidthPixels, Schematic.SchHeightPixels,BGRABlack);
  LayoutPaintBoxPaint(Sender);
end;

procedure TMainForm.MenuItem_AboutClick(Sender: TObject);
begin
  ShowMessage('PUFF, Version ' + version_string + sLineBreak +
    'Copyright (C) 1991, Scott W. Wedge, Richard Compton, David Rutledge' +
    sLineBreak + '(C) 1997, 1998 Andreas Gerstlauer' + sLineBreak +
    '2010 - Code released under the GNU General Public License version 3' +
    sLinebreak + '(C) 2000-2010 Pieter-Tjerk de Boer' + sLineBreak +
    '(C) 2009 Leland C. Scott' + sLineBreak +
    '(C) 2015 Travis Ayres; Multi-Platform Refactoring and Updates' +
    sLineBreak + 'http://www.its.caltech.edu/~mmic/puff.html -> for the original version' +
    sLineBreak + 'http://wwwhome.cs.utwente.nl/~ptdeboer/ham/puff.html -> for the Linux version'
    + sLineBreak + 'https://github.com/trayres/PUFF -> For updated Multi-Platform Lazarus version');
end;

procedure TMainForm.MenuItem_ShowDebugClick(Sender: TObject);
begin
      DebugForm.Show;
end;


procedure TMainForm.UpdateStatusBar(X, Y: Integer);
var
  tempTPointReal : TPointReal;
  viewTPoint : TPoint;
begin
  tempTPointReal := Schematic.GetWorldCoords(X,Y);
  viewTPoint:= Schematic.getViewportCoords(tempTPointReal);
  PuffStatusBar.Panels[0].Text := 'Pixel Coords: (' + IntToStr(X) + ',' + IntToStr(Y) + ')';
  PuffStatusBar.Panels[1].Text := Format('World Coords: (%fin,%fin)',[tempTPointReal.X,tempTPointReal.Y]);
  PuffStatusBar.Panels[2].Text := Format('ViewPort Coords: (%dpx,%dpx)',[viewTPoint.X,viewTPoint.Y]);
end;

//initialization
	(* here may be placed code that is *)
	(* executed as the unit gets loaded *)


finalization
  begin
	(* code executed at program end *)
  schematic_bmp.Free;
  end;

end.
