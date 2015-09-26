unit puffmainwindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Menus, ComCtrls, PuffInit;

type

  { TMainForm }

  TMainForm = class(TForm)
    Chart1: TChart;
    MenuItem_Help: TMenuItem;
    MenuItem_About: TMenuItem;
    PuffCmdEdit: TEdit;
    PuffCmdLstBox: TListBox;
    PuffMenu: TMainMenu;
    PuffStatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
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
begin
  version_string :=  String({$I %DATE%}); // {$I %TIME%} Right now this is a crude date - we'll come up with something better later.
  {$IFDEF DEBUG}
  WriteLn(version_string);
  {$ENDIF DEBUG}
  Caption := 'PUFF ' + String(version_string);
  PuffCmdLstBox.Clear;
  PuffCmdLstBox.Items.Add('>>');
  PuffCmdEdit.Clear;
  PuffCmdEdit.Text:='>>';
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

end.

