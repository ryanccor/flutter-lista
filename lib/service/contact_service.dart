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
    String _fileContent = _contacts[0]!.toJson().toString();
    print("CONTENT: " + _fileContent);

    var _directory = await getApplicationDocumentsDirectory();
    var exportFile = File( _directory.path + "/exportedContacts.txt");
    print(exportFile);

    await exportFile.writeAsString(_fileContent);
    return true;
    // } on Exception catch (erro) {
    //   print("Errou essa parada aqui!\n\n $erro");
    //   return false;
  }
}
// }

enum ContactAction { edit, sendEmail, call, delete }
