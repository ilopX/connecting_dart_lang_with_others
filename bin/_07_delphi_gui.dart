import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'dart:io';
import 'dart:convert';

import 'package:connect_dart_with_others/lib_builder.dart';
void main(List<String> arguments) async {
  final delphiRunner = DelphiRunner();

  delphiRunner.run((msg) {
    if (msg is Event) {
      print(msg);
    }
  });
}

////////////////////////////////////////////////////////////////////////////////
class DelphiRunner {
  final runnerPort = ReceivePort();

  void run(void Function(Object message) clientSend) async {
    final delphiConnector = await DelphiConnector.connect(runnerPort.sendPort);

    runnerPort.listen((message) async {
      if (message is AppClose) {
        await delphiConnector.close();
      } else if(message is ServerClose) {
        runnerPort.close();
      }
      clientSend(message);
    });

    await Isolate.spawn(DelphiThread.guiThread, runnerPort.sendPort);
  }
}
////////////////////////////////////////////////////////////////////////////////
class DelphiConnector {
  Socket? _client;
  ServerSocket? _server;

  static Future<DelphiConnector> connect(SendPort runnerPort) async {
    final thisResult = DelphiConnector._internals();

    final server = await ServerSocket.bind(HOST, PORT);
    runnerPort.send(ServerCreate(HOST, PORT));

    server.listen(
          (client) {
        thisResult._client = client;
        runnerPort.send(ClientConnect(client));

        client.cast<List<int>>().transform(utf8.decoder).listen((val) {
          runnerPort.send(DelphiMessage(val));
        }, onDone: () {
          runnerPort.send(ClientClose());
        });
      },
      onDone: () {
        runnerPort.send(ServerClose());
      },
    );

    thisResult._server = server;
    return thisResult;
  }

  DelphiConnector._internals();

  Future close() async {
    await _client?.close();
    await _server?.close();
    _client?.destroy();
  }
}
////////////////////////////////////////////////////////////////////////////////
// Events
class Event {
  @override
  String toString() {
    return 'Event: $runtimeType.';
  }
}

class ServerCreate extends Event {
  final InternetAddress host;
  final int port;

  ServerCreate(this.host, this.port);

  @override
  String toString() {
    return 'Create server. $host:$port';
  }
}

class AppRun extends Event {

}

class AppClose extends Event {

}

class ClientConnect extends Event {
  final String remoteAddress;
  final int remotePort;

  ClientConnect(Socket client)
      : remotePort = client.remotePort,
        remoteAddress = client.remoteAddress.address;

  @override
  String toString() {
    return 'Connect from: $remoteAddress:$remotePort';
  }
}

class ServerClose extends Event {}
class ClientClose extends Event {}

class DelphiMessage extends Event {
  final String message;

  DelphiMessage(this.message);

  @override
  String toString() {
    return 'DelphiMessage: $message';
  }
}

////////////////////////////////////////////////////////////////////////////////
class DelphiThread {
  static void guiThread(SendPort runnerPort) async {
    runnerPort.send(AppRun());
    await _runApp();
    runnerPort.send(AppClose());
  }

  static Future _runApp() async {
    final fileName = await buildAndGetFileNameLib(r'delphi_app');

    final dyCxxLib = ffi.DynamicLibrary.open(fileName);
    final RunApp =
        dyCxxLib.lookupFunction<C_DelphiFunc, Dart_CXXFunc>('RunApp');

    RunApp();
  }
}

////////////////////////////////////////////////////////////////////////////////
typedef C_DelphiFunc = ffi.Void Function();
typedef Dart_CXXFunc = void Function();

final HOST = InternetAddress.loopbackIPv6;
const PORT = 7654;
