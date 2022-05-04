import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    print("_localPath() ==> START");

    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    print("_localFile() ==> START");
    final path = await _localPath;
    print("_localFile() ==> END");
    return File('$path/exportedContacts.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeFile(String content) async {
    print("writeFile() ==> START");
    final file = await _localFile;
    print(await _localFile);
    var write = file.writeAsString('$content');
    // Write the file
    print("writeFile() ==> END");
    return write;
  }
}
