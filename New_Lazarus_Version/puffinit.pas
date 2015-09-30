unit PuffInit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation


var
  dev_file, net_file : TStringList;
  I : Integer;

initialization
begin
  dev_file.Create; //Let's not write these until we need to.
  net_file.Create;
  {$IFDEF DEBUG}
  WriteLn('Program: ', ParamStr(0));
  for I := 1 to ParamCount do
    WriteLn('Param ', I, ': ', ParamStr(I));
  {$ENDIF DEBUG}
end;



end.

