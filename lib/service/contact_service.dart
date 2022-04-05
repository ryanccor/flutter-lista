import '../model/contact.dart';

class ContactService {
  static final Map<int, Contact> _contacts = {};
  static int idCounter = 1;

  int save(Contact contact) {
    int newId = idCounter++;
    contact.id = newId;

    _contacts[newId] = contact.copy;
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
    if (contact.id == null) {
      throw Exception("id cannot be null");
    }
    _contacts[contact.id!] = contact;
  }
}