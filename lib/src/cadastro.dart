import 'package:flutter/material.dart';
import 'package:flutter_lista/service/contact_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../model/contact.dart';

class ContactFormPage extends StatelessWidget {
  ContactFormPage({Key? key, this.contact}) : super(key: key);
  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Contatos")),
      body: Container(
        child: ContactForm(contact),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  ContactForm(this.contact, {Key? key}) : super(key: key);
  final ContactService contactService = ContactService();


  final Contact? contact;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  _ContactFormState();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final MaskTextInputFormatter telefoneMask = CellPhoneMaskInputFormatter();

  @override
  Widget build(BuildContext context) {
    Contact? contact = widget.contact;
    if (contact != null) {
      nameController.text = contact.name;
      emailController.text = contact.email!;
      phoneController.text = contact.phoneNumber!;
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
                validator: (value) => validateEmail(value, "Email")),
            TextFormField(
                inputFormatters: [
                  telefoneMask
                ],


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
                            contact.id, nameController.value.text,
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


class CellPhoneMaskInputFormatter extends MaskTextInputFormatter {

  static String phone = "(##) ####-####";
  static String cell = "(##) #####-####";

  CellPhoneMaskInputFormatter({
    String? initialText
  }): super(
      mask: phone,
      filter: {"#": RegExp('([0-9])'), 'P':RegExp('(([0-9])|([0-9][0-9]))')},
      initialText: initialText
  );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    print(oldValue.text);
    print(newValue.text);
    print("no digits: ${newValue.text.replaceAll(RegExp(r"\D"), "")}");
    if(newValue.text.replaceAll(RegExp(r"\D"), "").length > 10 && oldValue.text.replaceAll(RegExp(r"\D"), "").length == 10 && getMask() != cell){
      updateMask(mask:cell);
    } else if(newValue.text.replaceAll(RegExp(r"\D"), "").length <= 10 && oldValue.text.replaceAll(RegExp(r"\D"), "").length > 10 && getMask() != phone){
      updateMask(mask:phone);
    }

    return super.formatEditUpdate(oldValue, newValue);

  }

}

String? validateEmpty(String? value, String fieldName) {
  return value != null && value.isEmpty ? "Preencha o campo $fieldName" : null;
}

String? validateEmail(String? value, String fieldName) {
  String? emptyValidation = validateEmpty(value, fieldName);
  if (emptyValidation != null) {
    return emptyValidation;
  }
  var emailRegex = RegExp(".+@.+", caseSensitive: false);
  value = value!.trim();
  print(emailRegex.stringMatch(value));
  return !emailRegex.hasMatch(value) ? "Email inválido" : null;
}
