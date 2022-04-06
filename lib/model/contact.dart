class Contact {
  int id;
  String name;
  String? phoneNumber;
  String? email;
  String? image;
  Contact(this.id, this.name, {this.phoneNumber, this.email, this.image});

  Contact get copy {
    return Contact(id, name,
        phoneNumber: phoneNumber, email: email, image: image);
  }
}
