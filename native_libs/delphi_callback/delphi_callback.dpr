library delphi_callback;

uses
  System.SysUtils,
  System.Classes;
{$R *.res}

type
  TGetProperty = function(const a: Integer; str: PAnsiChar): PAnsiChar; stdcall;

var
  GlobalDartFunc: TGetProperty;

procedure ApplyDartMethod(DartFunc: TGetProperty); stdcall;
begin
  GlobalDartFunc := DartFunc;
end;

function CallNative(const a: Integer; str: PAnsiChar): PAnsiChar; stdcall;
var
  DartReturn: string;
  FomratStr: string;
begin
  DartReturn := String(GlobalDartFunc(a, str));
  FomratStr  := 'Pascal( ' + #13#10
    + '   CallNative(' + IntToStr(a) + ', ' + String(str) + ')' + #13#10
    + '   dartFunction() return ' + DartReturn  + #13#10
    + ')';

  Result  := PAnsiChar(AnsiString(FomratStr));;
end;

exports
   CallNative,
   ApplyDartMethod;

begin
end.
