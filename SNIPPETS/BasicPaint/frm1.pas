unit frm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Clipbrd, LCLIntf, LCLType, StdCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnResize: TBitBtn;
    btnOpen: TBitBtn;
    btnPaste: TBitBtn;
    btnNew: TBitBtn;
    btnCopy: TBitBtn;
    btnSave: TBitBtn;
    Label1: TLabel;
    LineColor: TColorButton;
    MyCanvas: TPaintBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    CanvasScroller: TScrollBox;
    SpinEdit1: TSpinEdit;
    ToolFill: TSpeedButton;
    ToolTriangle: TSpeedButton;
    ToolRect: TSpeedButton;
    ToolPencil: TSpeedButton;
    ToolLine: TSpeedButton;
    ToolOval: TSpeedButton;
    ToolColorDropper: TSpeedButton;
    procedure btnCopyClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnResizeClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LineColorColorChanged(Sender: TObject);
    procedure MyCanvasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MyCanvasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MyCanvasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MyCanvasPaint(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

  paintbmp: TBitmap;

  MouseIsDown: Boolean;
  PrevX, PrevY: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  paintbmp.Free;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  OpenDialog1.Execute;

  if (OpenDialog1.Files.Count > 0) then begin

    if (FileExistsUTF8(OpenDialog1.FileName)) then begin
      paintbmp.LoadFromFile(OpenDialog1.FileName);
      MyCanvasPaint(Sender);

    end else begin
      ShowMessage('File is not found. You will have to open an existing file.');

    end;

  end;
end;

procedure TForm1.btnNewClick(Sender: TObject);
begin
    // if our bitmap is already Create-ed (TBitmap.Create)
    // then start fresh
    if paintbmp <> nil then
      paintbmp.Destroy;

    paintbmp := TBitmap.Create;

    paintbmp.SetSize(Screen.Width, Screen.Height);
    paintbmp.Canvas.FillRect(0,0,paintbmp.Width,paintbmp.Height);

    paintbmp.Canvas.Brush.Style:=bsClear;
    MyCanvas.Canvas.Brush.Style:=bsClear;

    paintbmp.Canvas.Pen.Color:=LineColor.ButtonColor;
    paintbmp.Canvas.Pen.Width:=SpinEdit1.Value;

    MyCanvasPaint(Sender);
end;

procedure TForm1.btnCopyClick(Sender: TObject);
begin

  Clipboard.Assign(paintbmp);

end;

procedure TForm1.btnPasteClick(Sender: TObject);
var
  tempBitmap: TBitmap;
  PictureAvailable: boolean = False;
begin

  // we determine if any image is on clipboard
  if (Clipboard.HasFormat(PredefinedClipboardFormat(pcfDelphiBitmap))) or
    (Clipboard.HasFormat(PredefinedClipboardFormat(pcfBitmap))) then
    PictureAvailable := True;


  if PictureAvailable then
  begin

    tempBitmap := TBitmap.Create;

    if Clipboard.HasFormat(PredefinedClipboardFormat(pcfDelphiBitmap)) then
      tempBitmap.LoadFromClipboardFormat(PredefinedClipboardFormat(pcfDelphiBitmap));
    if Clipboard.HasFormat(PredefinedClipboardFormat(pcfBitmap)) then
      tempBitmap.LoadFromClipboardFormat(PredefinedClipboardFormat(pcfBitmap));

    // so we use assign, it works perfectly
    paintbmp.Assign(tempBitmap);
    MyCanvasPaint(Sender);

    tempBitmap.Free;

  end else begin

    ShowMessage('No image is found on clipboard!');

  end;

end;

procedure TForm1.btnResizeClick(Sender: TObject);
var
  ww, hh: string;
  ww2, hh2: Integer;
  Code: Integer;
begin

  ww:=InputBox('Resize Canvas', 'Please enter the desired new width:', IntToStr(paintbmp.Width));
  Val(ww, ww2, Code);
  if Code <> 0 then begin
    ShowMessage('Error! Try again with an integer value of maximum '+inttostr(High(Integer)));
    Exit; // skip the rest of the code
  end;

  hh:=InputBox('Resize Canvas', 'Please enter the desired new height:', IntToStr(paintbmp.Height));
  Val(hh, hh2, Code);
  if Code <> 0 then begin
    ShowMessage('Error! Try again with an integer value of maximum '+inttostr(High(Integer)));
    Exit; // skip the rest of the code
  end;

  paintbmp.SetSize(ww2, hh2);
  MyCanvasPaint(Sender);

end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  SaveDialog1.Execute;

  if SaveDialog1.Files.Count > 0 then begin
    // if the user enters a file name without a .bmp
    // extension, we will add it
    if RightStr(SaveDialog1.FileName, 4) <> '.bmp' then
      SaveDialog1.FileName:=SaveDialog1.FileName+'.bmp';

    paintbmp.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // We create a new file/canvas/document when
  // it starts up
  btnNewClick(Sender);
end;

procedure TForm1.LineColorColorChanged(Sender: TObject);
begin
  paintbmp.Canvas.Pen.Color:=LineColor.ButtonColor;
  MyCanvas.Canvas.Pen.Color:=LineColor.ButtonColor;
end;

procedure TForm1.MyCanvasMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseIsDown := True;
  PrevX := X;
  PrevY := Y;
end;

procedure TForm1.MyCanvasMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MouseIsDown = true then begin

    //// Pencil Tool ////
    if ToolPencil.Down = true then begin
      paintbmp.Canvas.Line(PrevX, PrevY, X, Y);
      MyCanvas.Canvas.Line(PrevX, PrevY, X, Y);

      PrevX:=X;
      PrevY:=Y;

    //// Line Tool ////
    end else if ToolLine.Down = true then begin
      // we are clearing previous preview drawing
      MyCanvasPaint(Sender);
      // we draw a preview line
      MyCanvas.Canvas.Line(PrevX, PrevY, X, Y);

    //// Rectangle Tool ////
    end else if ToolRect.Down = true then begin
      MyCanvasPaint(Sender);
      MyCanvas.Canvas.Rectangle(PrevX, PrevY, X, Y);

    //// Oval Tool ////
    end else if ToolOval.Down = true then begin
      MyCanvasPaint(Sender);
      MyCanvas.Canvas.Ellipse(PrevX, PrevY, X, Y);

    //// Triangle Tool ////
    end else if ToolTriangle.Down = true then begin
      MyCanvasPaint(Sender);
      MyCanvas.Canvas.Line(PrevX,Y,PrevX+((X-PrevX) div 2), PrevY);
      MyCanvas.Canvas.Line(PrevX+((X-PrevX) div 2),PrevY,X,Y);
      MyCanvas.Canvas.Line(PrevX,Y,X,Y);
      //MyCanvas.Canvas.Ellipse(PrevX, PrevY, X, Y);



    end;

  end;


end;

procedure TForm1.MyCanvasMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TempColor: TColor;
begin
  if MouseIsDown then begin

    //// Line tool
    if ToolLine.Down = true then begin
      paintbmp.Canvas.Line(PrevX, PrevY, X, Y);
    //// Rect
    end else if ToolRect.Down = true then begin
      paintbmp.Canvas.Rectangle(PrevX, PrevY, X, Y);
    //// Oval tool
    end else if ToolOval.Down = true then begin
      paintbmp.Canvas.Ellipse(PrevX, PrevY, X, Y);
    //// Triangle tool
    end else if ToolTriangle.Down = true then begin
      paintbmp.Canvas.Line(PrevX,Y,PrevX+((X-PrevX) div 2), PrevY);
      paintbmp.Canvas.Line(PrevX+((X-PrevX) div 2),PrevY,X,Y);
      paintbmp.Canvas.Line(PrevX,Y,X,Y);
    //// Color Dropper Tool ////
    end else if ToolColorDropper.Down = true then begin
      LineColor.ButtonColor:=MyCanvas.Canvas.Pixels[X,Y];
    //// (Flood) Fill Tool ////
    end else if ToolFill.Down = true then begin
      TempColor := paintbmp.Canvas.Pixels[X, Y];
      paintbmp.Canvas.Brush.Style := bsSolid;
      paintbmp.Canvas.Brush.Color := LineColor.ButtonColor;
      paintbmp.Canvas.FloodFill(X, Y, TempColor, fsSurface);
      paintbmp.Canvas.Brush.Style := bsClear;
      MyCanvasPaint(Sender);
    end;

  end;

  MouseIsDown:=False;
end;

procedure TForm1.MyCanvasPaint(Sender: TObject);
begin
  if MyCanvas.Width<>paintbmp.Width then begin
    MyCanvas.Width:=paintbmp.Width;
    // the resize will run this function again
    // so we skip the rest of the code
    Exit;
  end;
  if MyCanvas.Height<>paintbmp.Height then begin
    MyCanvas.Height:=paintbmp.Height;
    // the resize will run this function again
    // so we skip the rest of the code
    Exit;
  end;

  MyCanvas.Canvas.Draw(0,0,paintbmp);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  paintbmp.Canvas.Pen.Width:=SpinEdit1.Value;
  MyCanvas.Canvas.Pen.Width:=SpinEdit1.Value;
end;

end.

