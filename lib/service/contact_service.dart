import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/contact.dart';
import 'file_storage.dart';

class ContactService {
  static final Map<int, Contact> _contacts = {};

  int save(contact) {
    int newId = _contacts.length;

    _contacts[newId] = Contact(newId, contact["name"],
        email: contact["email"], phoneNumber: contact["phoneNumber"]);
    return newId;
  }

  Contact? getById(int id) {
    return _contacts[id]?.copy;
  }

  List<Contact>? getAll() {
    return _contacts.values.map((element) => element.copy).toList();
  }

  void deleteById(int id) {
    _contacts.remove(id);
  }

  void update(Contact contact) {
    _contacts[contact.id] = contact;
  }

  dynamic exportContactFile() async {
    // try {
    FileStorage fileStorage = FileStorage();

    String _fileContent = _contacts[0]!.toJson().toString();
    print("CONTENT: " + _fileContent);

    fileStorage.writeFile(_fileContent);

    File _exportFileName = File("exportedContacts.txt");
    print(_exportFileName);

    // var _directory = getApplicationDocumentsDirectory();
    // var exportFile = _directory; // + "/exportedContacts.txt";
    // print(exportFile);

    await _exportFileName.writeAsString(_fileContent);
    return true;
    // } on Exception catch (erro) {
    //   print("Errou essa parada aqui!\n\n $erro");
    //   return false;
  }
}
// }

enum ContactAction { edit, sendEmail, call, delete }
