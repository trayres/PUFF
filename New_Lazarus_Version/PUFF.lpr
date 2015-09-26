program PUFF;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PuffMainWindow,
  { you can add units after this }
  Crt, puffinit;

{$R *.res}


begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run; //This drops us into the application loop, so we can't setup here.

end.

