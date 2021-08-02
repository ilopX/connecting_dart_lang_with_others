library delphi_lib;

uses
  System.SysUtils,
  System.Classes;

{$R *.res}

function AddIntegers(const a, b: integer): integer; stdcall;
begin
  Result := a + b;
end;

exports
   AddIntegers;
end.
