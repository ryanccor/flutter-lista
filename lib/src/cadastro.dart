import 'package:flutter/material.dart';
import 'package:flutter_lista/service/contact_service.dart';

import '../model/contact.dart';

class ContactFormPage extends StatelessWidget {
  ContactFormPage({Key? key, this.contact}) : super(key: key);

  final ContactService _contactService = ContactService();
  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Contatos")),
      body: Container(
        child: ContactForm(_contactService, contact),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm(this.contactService, this.contact, {Key? key})
      : super(key: key);
  final ContactService contactService;
  final Contact? contact;

  @override
  State<ContactForm> createState() =>
      _ContactFormState(contactService, contact);
}

String? validateEmpty(String? value, String fieldName) {
  return value != null && value.isEmpty ? "Preencha o campo $fieldName" : null;
}

class _ContactFormState extends State<ContactForm> {
  _ContactFormState(this.contactService, this.contact);
  final Contact? contact;
  final ContactService contactService;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact!.name;
      emailController.text = contact!.email!;
      phoneController.text = contact!.phoneNumber!;
    }
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), labelText: "Nome"),
                validator: (value) => validateEmpty(value, "Nome")),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    icon: Icon(Icons.mail), labelText: "Email"),
                validator: (value) => validateEmpty(value, "Email")),
            TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone), labelText: "Telefone"),
                validator: (value) => validateEmpty(value, "Telefone")),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    if (contact != null) {
                      if (_formKey.currentState!.validate()) {
                        Contact updatedContact = Contact(
                            contact!.id, nameController.value.text,
                            email: emailController.value.text,
                            phoneNumber: phoneController.value.text);
                        widget.contactService.update(updatedContact);

                        Navigator.pop(context);
                      }
                    } else if (_formKey.currentState!.validate()) {
                      var newContact = {
                        "name": nameController.value.text,
                        "email": emailController.value.text,
                        "phoneNumber": phoneController.value.text
                      };
                      widget.contactService.save(newContact);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Salvar")),
              margin: EdgeInsets.all(16.0),
            )
          ],
        ));
  }
}
