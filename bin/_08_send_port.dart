import 'dart:async';
import 'dart:ffi';

import 'dart:isolate';

import 'package:connect_dart_with_others/color_printer.dart';
import 'package:connect_dart_with_others/lib_builder.dart';

void main() async {
  // [1]
  final mainPort = ReceivePort();
  final doneRun = Completer<int>();
  final doneStr = Completer<String>();

  // [2]
  mainPort.listen((message) {
    if (message is int) {
      // [5]
      doneRun.complete(message);
    } else if (message is String) {
      // [8]
      doneStr.complete(message);
    }
  });

  // [3]
  final lib = await SendNativePortLib.load(mainPort.sendPort.nativePort);

  printGreen('Output:');
  final t1 = Stopwatch()..start();
  // [4]
  lib.sendPortInt();
  final number = await doneRun.future;
  // [6]
  print('(${t1.elapsedTicks / 10000} ms) from dll: $number');

  final t2 = Stopwatch()..start();
  // [7]
  lib.sendPortString();
  final str = await doneStr.future;
  // [9]
  print('(${t2.elapsedTicks / 10000} ms) $str');

  // [10]
  mainPort.close();
}

class SendNativePortLib {
  final Dart_SendPort sendPortInt;
  final Dart_SendPort sendPortString;

  static Future<SendNativePortLib> load(int nativePort) async {
    final fileName = await buildAndGetFileNameLib('send_port');
   final dl = DynamicLibrary.open(fileName);

    final applyPort = dl.lookupFunction<
        C_ApplyPort,
        Dart_ApplyPort>('applyPort');

    applyPort(nativePort);

    final sendPortInt = dl.lookupFunction<C_SendPort,
        Dart_SendPort>('sendPortInt');
    final sendPortString = dl.lookupFunction<C_SendPort,
        Dart_SendPort>('sendPortString');

    return SendNativePortLib._internal(sendPortInt, sendPortString);
  }

  SendNativePortLib._internal(this.sendPortInt,
      this.sendPortString);
}

typedef C_ApplyPort = Void Function(Int64);
typedef Dart_ApplyPort = void Function(int);


typedef C_SendPort = Void Function();
typedef Dart_SendPort = void Function();
