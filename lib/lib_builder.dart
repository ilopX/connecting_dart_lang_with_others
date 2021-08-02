import 'dart:io';
import 'package:path/path.dart' as path;

Future<String> buildAndGetFileNameLib(String libName) async {
  final libPath = getLibPath(libName);
  var fileName = '$libPath\\build\\$libName.dll';

  if (!File(fileName).existsSync()) {
    await _build(libPath);
  }

  if (!File(fileName).existsSync()) {
    stderr.writeln('Library $fileName not exist.');
    stdout.writeln('Please run $libPath\\build.cmd"');
    exit(-1);
  }

  return fileName;
}

Future _build(String libPath) async {
  final fileName = path.join(libPath, 'build.cmd');
  if (!File(fileName).existsSync()) {
    stderr.writeln('Build file $fileName not exist.');
    exit(-1);
  }

  var process = await Process.start(
    'cmd',
    ['/c', 'build',],
    workingDirectory: '$libPath',
    runInShell: true,
  );

  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
}

String getLibPath(String libName) {
  final currScript = Platform.script.toFilePath(windows: true);
  final currDir = path.dirname(currScript);
  final libPath = path.join(
    currDir,
    '..',
    'native_libs',
    '$libName',
  );
  return path.normalize(libPath);
}
