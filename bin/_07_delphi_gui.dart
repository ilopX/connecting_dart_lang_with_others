import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'package:ffi_interpop_c/lib_builder.dart';
import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) async {
  final delphiRunner = DelphiRunner();

  delphiRunner.run((msg) {
    switch (msg.runtimeType) {
      case DelphiMessage:
        final delphiMsg = msg as DelphiMessage;
        print('DelphiMessage: ${delphiMsg.message}');
        break;

      case ServerCreate:
        final event = msg as ServerCreate;
        print('Create server. ${event.host}:${event.port}');
        break;

      case ServerClose:
        print('Server close.');
        break;

      case ClientConnect:
        final client = msg as ClientConnect;
        print('Connect from: ${client.remoteAddress}:${client.remotePort}');
        break;

      case ClientClose:
        print('Client close');
        break;

      case AppRun:
        print('App is running.');
        break;

      case AppClose:
        print('App is close.');
        break;

      default:
        print(msg);
    }
  });
}

typedef C_DelphiFunc = ffi.Void Function();
typedef Dart_CXXFunc = void Function();

final HOST = InternetAddress.loopbackIPv6;
const PORT = 7654;

class Event {}

class ServerCreate {
  final InternetAddress host;
  final int port;

  ServerCreate(this.host, this.port);
}

class AppRun {}

class AppClose {}

class ClientConnect {
  final String remoteAddress;
  final int remotePort;

  ClientConnect(Socket client)
      : remotePort = client.remotePort,
        remoteAddress = client.remoteAddress.address;
}

class ServerClose {}
class ClientClose {}

class DelphiMessage {
  final String message;

  DelphiMessage(this.message);
}

class DelphiCommand{

}

class DelphiRunner {
  final runnerPort = ReceivePort();

  void run(void Function(Object message) clientListen) async {
    final delphiConnector = await DelphiConnector.connect(runnerPort.sendPort);

    runnerPort.listen((message) async {
      if (message is AppClose) {
        await delphiConnector.close();
      } else if(message is ServerClose) {
        runnerPort.close();
      }
      clientListen(message);
    });

    await Isolate.spawn(DelphiThread.guiThread, runnerPort.sendPort);
  }
}

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
