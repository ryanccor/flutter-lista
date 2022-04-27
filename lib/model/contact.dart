import 'package:flutter/cupertino.dart';

class Contact {
  int id;
  String name;
  String? phoneNumber;
  String? email;
  String? image;
  Contact(this.id, this.name, {this.phoneNumber, this.email, this.image});

  Contact get copy {
    return Contact(
      id,
      name,
      phoneNumber: phoneNumber,
      email: email,
      image: image,
    );
  }

  Map<String, dynamic> toJson() {
    print("toJson() == > Start");
    Map<String, dynamic> json = {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "image": image
    };
    print("toJson() == > End");
    return json;
  }

  factory Contact.fromJson(Map<String, String> json) {
    Contact obj = Contact(
      int.parse(json["id"]!),
      json["name"]!,
      phoneNumber: json["phoneNumber"]!,
      email: json["email"]!,
      image: json["image"]!,
    );
    return obj;
  }
}
