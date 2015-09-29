unit PuffStruct;

{$mode objfpc}{$H+}

interface

type
TPUFF = class
    dev_file, net_file : TStringList;
end

uses
  Classes, SysUtils;

implementation

initialization
begin
  dev_file.Create; //Let's not write these until we need to.
  net_file.Create;
end;

finalization begin
dev_file.Free;
net_file.Free;
end;


end.

