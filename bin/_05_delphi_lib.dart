import 'dart:ffi' as ffi;
import 'package:connect_dart_with_others/color_printer.dart';
import 'package:connect_dart_with_others/lib_builder.dart';

void main(List<String> arguments) async {
  final AddIntegers = await loadDelphiFunc();
  final result = AddIntegers(3, 4);
  printGreen('Output:');
  print('AddIntegers(3, 4) return $result');
}

Future<Dart_CXXFunc> loadDelphiFunc() async{
  final libFileName = await buildAndGetFileNameLib('delphi_lib');
  final dyCxxLib = ffi.DynamicLibrary.open(libFileName);
  return dyCxxLib.lookupFunction<C_DelphiFunc, Dart_CXXFunc>('AddIntegers');
}

typedef C_DelphiFunc = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef Dart_CXXFunc = int Function(int, int);

