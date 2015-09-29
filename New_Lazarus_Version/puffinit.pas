unit PuffInit;

{$mode objfpc}{$H+}

interface

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

