unit PuffInit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation


var
  //dt : TDateTime; {http://forum.lazarus.freepascal.org/index.php?topic=20421.0 - Used for compile date/time}
  dev_file, net_file : TStringList;

initialization
begin
  dev_file.Create; //Let's not write these until we need to.
  net_file.Create;

  {The "puff_file:=Commandline" has a side effect of replacing puff_file with
  "setup" to load "setup.puf", which means if the user deletes this file it simply exits.
  Let's replace that whole ball of wax.}

end;



end.

