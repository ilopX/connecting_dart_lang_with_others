import 'package:ffi/ffi.dart';
import 'package:ffi_interpop_c/color_printer.dart';
import 'package:ffi_interpop_c/lib_search.dart';
import 'dart:ffi';

void main() async {
  final math = await MathFunctions.loadFunctions();

  printGreen('Output:');
  final sumResult = math.sum(1, 2);
  print('sum(1, 2) return $sumResult');

  final argPointer = calloc<Int32>()..value = 10;
  final substractResult = math.substract(argPointer, 3);
  print('substract(10, 3) return  $substractResult');
  calloc.free(argPointer);

  final multiResult = math.myltiply(3, 3);
  print('multiply(3, 3) return ${multiResult.value}');
  calloc.free(multiResult);

  final resultMultiSum = math.multiSum(3, 1, 2, 3);
  print('mutliSum(3, 1, 2, 3) return $resultMultiSum');
}

typedef CXX_Sum_Func = Int32 Function(Int32, Int32);
typedef Dart_Sum_Func = int Function(int, int);

typedef CXX_Substract_Func = Int32 Function(Pointer<Int32>, Int32);
typedef Dart_Substract_Func = int Function(Pointer<Int32>, int);

typedef CXX_Multiply_Func = Pointer<Int32> Function(Int32, Int32);
typedef Dart_Multiply_Func = Pointer<Int32> Function(int, int);

typedef CXX_MultiSum_Func = Int32 Function(Int32 n_count, Int32, Int32, Int32);
typedef Dart_MultiSum_Fun = int Function(int n_coun, int, int, int);

class MathFunctions {
  final Dart_Sum_Func sum;
  final Dart_Substract_Func substract;
  final Dart_Multiply_Func myltiply;
  final Dart_MultiSum_Fun multiSum;

  static Future<MathFunctions> loadFunctions() async {
    final libMath = await _loadMathLibrary();

    final sum = libMath.lookupFunction<CXX_Sum_Func, Dart_Sum_Func>('sum');
    final substract = libMath
        .lookupFunction<CXX_Substract_Func, Dart_Substract_Func>('substract');
    final multiply = libMath
        .lookupFunction<CXX_Multiply_Func, Dart_Multiply_Func>('multiply');
    final multi_sum = libMath
        .lookupFunction<CXX_MultiSum_Func, Dart_MultiSum_Fun>('multi_sum');

    return MathFunctions._internals(sum, substract, multiply, multi_sum);
  }

  static Future<DynamicLibrary> _loadMathLibrary() async{
    final fileName = await buildAndGetFileNameLib('primitives_lib');

    final libMath = DynamicLibrary.open(fileName);
    return libMath;
  }

  MathFunctions._internals(
      this.sum, this.substract, this.myltiply, this.multiSum);
}
