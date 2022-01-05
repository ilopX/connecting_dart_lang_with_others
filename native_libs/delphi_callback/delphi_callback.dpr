library delphi_callback;

uses
  System.SysUtils,
  System.Classes;
{$R *.res}

type
  TGetProperty = function(const a: Integer; str: PChar): PChar; stdcall;

var
  GlobalDartFunc: TGetProperty;

procedure ApplyDartMethod(DartFunc: TGetProperty); stdcall;
begin
  GlobalDartFunc := DartFunc;
end;

function CallNative(const a: Integer; str: PChar): PChar; stdcall;
var
  DartReturn: string;
  FormatStr: string;
begin
  var strAgs := PChar('Argument from delphi');
  DartReturn := String(GlobalDartFunc(a, strAgs));
  FormatStr  := 'Pascal( ' + #13#10
    + '   CallNative(' + IntToStr(a) + ', ' + String(str) + ')' + #13#10
    + '   dartFunction() return ' + DartReturn  + #13#10
    + ')';

  Result  := PChar(FormatStr);
end;

exports
   CallNative,
   ApplyDartMethod;

begin
end.
