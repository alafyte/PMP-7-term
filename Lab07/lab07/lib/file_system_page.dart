import 'package:flutter/material.dart';
import 'file_system_manager.dart';

class FileSystemPage extends StatefulWidget {
  const FileSystemPage({super.key});

  @override
  FileSystemPageState createState() => FileSystemPageState();
}

class FileSystemPageState extends State<FileSystemPage> {
  final FileSystemHelper fileSystemHelper = FileSystemHelper();
  String _fileContent = '';

  Future<void> _writeAndReadFiles() async {
    String content = 'Example Worker: Manager, Age: 30';

    String tempDir = await fileSystemHelper.getTemporaryDirectoryPath();
    await fileSystemHelper.writeFile(tempDir, 'temp_worker.txt', content);

    String readTempContent = await fileSystemHelper.readFile(tempDir, 'temp_worker.txt');

    String docDir = await fileSystemHelper.getDocumentsDirectoryPath();
    await fileSystemHelper.writeFile(docDir, 'doc_worker.txt', content);

    String readDocContent = await fileSystemHelper.readFile(docDir, 'doc_worker.txt');

    setState(() {
      _fileContent = 'Temp File Content: $readTempContent\n\nDoc File Content: $readDocContent';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File System Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _writeAndReadFiles,
              child: const Text('Write and Read Files'),
            ),
            const SizedBox(height: 20),
            Text(_fileContent),
          ],
        ),
      ),
    );
  }
}
