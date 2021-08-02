import 'package:dart_console/dart_console.dart';

void printGreen(String text) {
  Console()
    ..setForegroundColor(ConsoleColor.green)
    ..writeLine(text)
    ..resetColorAttributes();
}
