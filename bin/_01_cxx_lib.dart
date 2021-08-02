import 'dart:ffi';
import 'package:ffi_interpop_c/color_printer.dart';
import 'package:ffi_interpop_c/lib_builder.dart';

void main(List<String> arguments) async {
  final my_call = await loadFunction();
  printGreen('C++ output:');
  my_call();
}

Future<Dart_CXXFunc> loadFunction() async {
  final fileName = await buildAndGetFileNameLib(r'cxx_lib');
  final lib = DynamicLibrary.open(fileName);
  return lib.lookupFunction<C_CxxFunc, Dart_CXXFunc>('my_call');
}

typedef C_CxxFunc = Void Function();
typedef Dart_CXXFunc = void Function();
