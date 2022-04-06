import '../model/contact.dart';

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
    if (contact.id == null) {
      throw Exception("id cannot be null");
    }
    _contacts[contact.id] = contact;
  }
}

enum ContactAction { edit, sendEmail, call, delete }
