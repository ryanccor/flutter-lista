import 'dart:convert';

class Contact {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? image;

  Contact ({this.id,this.name,this.phoneNumber, this.email, this.image});

  factory Contact.fromMap( Map<String, dynamic> map) {
    int id = map["id"];
    String name = map["name"];
    return Contact(
      name:name,
      id:id,
      phoneNumber: map["phoneNumber"],
      email: map["email"],
      image: map["image"],
    );
  }

  Contact get copy {
    return Contact(
        id:id,
        name:name,
        phoneNumber: phoneNumber,
        email: email,
        image: image);
  }

  Map<String, dynamic> get map {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "image": image
    };
  }
}
