import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:ffi_interpop_c/color_printer.dart';
import 'package:ffi_interpop_c/lib_builder.dart';

void main() async {
  await load();
  printGreen('Output:');
  final cl = CxxClass(666);
  print('CxxClass.getNumber = ${cl.getNumber()}');
  print('CxxClass.val = ${cl.val}');
  cl.release();
}

Future<void> load() async {
  _lod = await CxxClassLoader.load();
}

late CxxClassLoader _lod;

class CxxClass {
  final Pointer<CxxClassType> _obj;

  CxxClass(int val): _obj = _lod.makeClass(val);

  int getNumber() => _lod.getNumber(_obj);

  void release() => calloc.free(_obj);

  int get val => _obj.ref.val;
}

class CxxClassLoader {
  final Dart_CxxClass makeClass;
  final Dart_GetInt getNumber;

  static Future<CxxClassLoader> load() async{
    final fileName = await buildAndGetFileNameLib('cxx_class');
    final lib = DynamicLibrary.open(fileName);
    final makeClass = lib.lookupFunction<C_CxxClass, Dart_CxxClass>('MakeCxxClass');
    final getNumber = lib.lookupFunction<C_GetInt, Dart_GetInt>('getNumber');

    return CxxClassLoader._inter(makeClass, getNumber);
  }

  CxxClassLoader._inter(this.makeClass, this.getNumber);
}

class CxxClassType extends Struct {
  @Int32()
  external int val;
}


typedef C_CxxClass = Pointer<CxxClassType> Function(Int32);
typedef Dart_CxxClass = Pointer<CxxClassType> Function(int);

typedef C_GetInt = Int32 Function(Pointer<CxxClassType>);
typedef Dart_GetInt = int Function(Pointer<CxxClassType>);
