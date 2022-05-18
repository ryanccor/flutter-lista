import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../model/contact.dart';

class ContactService {
  static final Map<int, Contact> _contacts = {};

  Future<int> save(Contact contact) async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    var id = DateTime.now().millisecondsSinceEpoch;
    String fileName = diretorio.path + '/contacts.json';
    File file = File(fileName);
    List<dynamic> content = [];
    if (await file.exists()) {
      String contentRaw = await file.readAsString();
      if (contentRaw.length > 2) {
        content = json.decode(await file.readAsString());
      }
    }
    contact.id = id;
    content.add(contact.map);
    String strJson = json.encode(content);
    await file.writeAsString(strJson);
    return id;
  }

  Future<Contact?> getById(int id) async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String fileName = diretorio.path + '/contacts.json';
    File file = File(fileName);
    List<dynamic> content = [];
    if (await file.exists()) {
      String contentRaw = await file.readAsString();
      if (contentRaw.length > 2) {
        content = json.decode(await file.readAsString());
      }
    }
    Map<String, dynamic> map =
        content.firstWhere((e) => int.parse(e["id"]) == id, orElse: () => {});
    if (map.isEmpty) {
      return null;
    }
    return Contact.fromMap(map);
  }

  Future<List<Contact>> getAll() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String fileName = diretorio.path + '/contacts.json';
    print(fileName);
    File file = File(fileName);
    print(file.absolute);

    List<dynamic> content = [];
    if (await file.exists()) {
      String contentRaw = await file.readAsString();
      if (contentRaw.length > 2) {
        content = json.decode(await file.readAsString());
      }
    }
    List<Contact> contacts = content.map((m) => Contact.fromMap(m)).toList();

    return contacts;
  }

  Future<void> deleteById(int id) async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String fileName = diretorio.path + '/contacts.json';
    File file = File(fileName);
    List<dynamic> content = [];
    if (await file.exists()) {
      String contentRaw = await file.readAsString();
      if (contentRaw.length > 2) {
        content = json.decode(await file.readAsString());
      }
    }
    content =
        content.where((element) => element["id"] != id).toList();
    String strJson = json.encode(content);
    await file.writeAsString(strJson);
  }

  void update(Contact contact) async {
    if (contact.id == null) {
      throw Exception("id cannot be null");
    }
    Directory diretorio = await getApplicationDocumentsDirectory();
    String fileName = diretorio.path + '/contacts.json';
    File file = File(fileName);
    List<dynamic> content = [];
    if (await file.exists()) {
      String contentRaw = await file.readAsString();
      if (contentRaw.length > 2) {
        content = json.decode(await file.readAsString());
      }
    }
    Map<String, dynamic> map =
        content.firstWhere((element) => element["id"] == contact.id, orElse: () => {});
    if(map.isEmpty){
      return;
    }
    contact.map.forEach((key, value) => map[key] = value);
    String strJson = json.encode(content);
    await file.writeAsString(strJson);
  }
}

enum ContactAction { edit, sendEmail, call, delete }
