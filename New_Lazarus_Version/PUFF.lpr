program PUFF;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, puffmainwindow,
  { you can add units after this }
  Dialogs, Classes, SmithChart, DebugFormUnit;

{$R *.res}
var
  CommandLineParams : TStringList;
  s : String;

begin
  CommandLineParams := TStringList.Create;
  try
  //Application.GetEnvironmentList(CommandLineParams);

  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDebugForm, DebugForm);
  Application.Run;
  finally
    CommandLineParams.Free;
  end;
end.

