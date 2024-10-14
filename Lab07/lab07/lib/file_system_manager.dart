import 'dart:io';
import 'package:path_provider/path_provider.dart';


class FileSystemHelper {
  Future<String> getTemporaryDirectoryPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<String> getDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> writeFile(String directoryPath, String fileName, String content) async {
    final file = File('$directoryPath/$fileName');
    await file.writeAsString(content);
  }

  Future<String> readFile(String directoryPath, String fileName) async {
    try {
      final file = File('$directoryPath/$fileName');
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}
