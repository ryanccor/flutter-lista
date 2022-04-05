class Contact{
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  Contact({this.id, this.name, this.phoneNumber, this.email});

  Contact get copy{
    return Contact(id: id, name: name, phoneNumber: phoneNumber, email: email);
  }
}