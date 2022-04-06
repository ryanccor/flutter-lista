import 'package:flutter/material.dart';
import 'package:flutter_lista/service/contact_service.dart';

import '../model/contact.dart';

class ContactFormPage extends StatelessWidget {
  final ContactService _contactService = ContactService();
  ContactFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Contatos")),
      body: Container(
        child: ContactForm(_contactService),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final ContactService contactService;
  const ContactForm(this.contactService, {Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

String? validateEmpty(String? value, String fieldName) {
  return value != null && value.isEmpty ? "Preencha o campo $fieldName" : null;
}

class _ContactFormState extends State<ContactForm> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    if (_formKey.currentState!.validate()) {
                      Contact newContact = Contact(
                          name: nameController.value.text,
                          email: emailController.value.text,
                          phoneNumber: phoneController.value.text);
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
