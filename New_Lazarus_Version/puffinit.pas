unit PuffInit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation


var
  dev_file, net_file : TStringList;

initialization
begin
  dev_file.Create; //Let's not write these until we need to.
  net_file.Create;
end;



end.

