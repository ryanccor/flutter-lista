import 'package:flutter/material.dart';
import 'package:flutter_lista/model/contact.dart';
import 'package:flutter_lista/service/contact_service.dart';

import 'cadastro.dart';

class ListaWidget extends StatelessWidget {
  const ListaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactService = ContactService();

    contactService.save(
      Contact(
          name: "Hudson Rodrigues",
          email: "hud.rod@mail.com",
          phoneNumber: "00 00000-0000"),
    );
    contactService.save(
      Contact(
          name: "Ryan Cordeiro",
          email: "ryan.cor@mail.com",
          phoneNumber: "11 11111-1111"),
    );
    contactService.save(
      Contact(
          name: "Thales Azevedo",
          email: "tha.aze@mail.com",
          phoneNumber: "22 22222-2222"),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListBody(
            children: contactService
                .getAll()!
                .map((e) => Card(
                      child: ListTile(
                        title: Text(e.name!),
                        subtitle: Text("${e.phoneNumber} - ${e.email}"),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage("https://picsum.photos/100"),
                        ),
                        onTap: () {},
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: ContactAction.edit,
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Editar")
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: ContactAction.call,
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Ligar")
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: ContactAction.sendEmail,
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.mail),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Enviar Email")
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: ContactAction.delete,
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Deletar")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactFormPage();
          }));
        },
      ),
    );
  }
}
