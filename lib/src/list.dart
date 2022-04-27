import 'package:flutter/material.dart';
import 'package:flutter_lista/model/contact.dart';
import 'package:flutter_lista/service/contact_service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cadastro.dart';

class ListaWidget extends StatefulWidget {
  const ListaWidget({Key? key}) : super(key: key);

  @override
  State<ListaWidget> createState() => _ListaWidgetState();
}

class _ListaWidgetState extends State<ListaWidget> {
  @override
  Widget build(BuildContext context) {
    var contactService = ContactService();

    List<Contact> contacts = contactService.getAll()!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListBody(
            children: contacts
                .map((contact) => Card(
                      child: Dismissible(
                        key: Key(contact.phoneNumber ?? ''),
                        confirmDismiss: (direction) async {
                          return await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: Colors.red,
                                  child: ElevatedButton(
                                    child: Text('Apagar'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                );
                              });
                        },
                        onDismissed: (direction) {
                          setState(() {
                            contactService.deleteById(contact.id);
                            contacts = contactService.getAll()!;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Contato ${contact.name} deletado')));
                        },
                        background: Container(
                          color: Colors.red,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.delete),
                                Icon(Icons.delete)
                              ],
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        child: ListTile(
                          title: Text(contact.name),
                          subtitle:
                              Text("${contact.phoneNumber} - ${contact.email}"),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(contact.image ??
                                "https://picsum.photos/seed/${contact.name}/100"),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContactFormPage(
                                contact: contact,
                              );
                            })).then((value) {
                              setState(() {
                                contacts = contactService.getAll()!;
                              });
                            });
                          },
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: ContactAction.call,
                                onTap: () async {
                                  launch("tel://${contact.phoneNumber}");
                                },
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
                                onTap: () async {
                                  launch("mailto:${contact.email!}");
                                },
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
                                onTap: () {
                                  contactService.deleteById(contact.id);
                                  setState(() {
                                    contacts = contactService.getAll()!;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Apagar")
                                  ],
                                ),
                              ),
                            ],
                          ),
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
          })).then((value) {
            setState(() {
              contacts = contactService.getAll()!;
            });
          });
        },
      ),
    );
  }
}
