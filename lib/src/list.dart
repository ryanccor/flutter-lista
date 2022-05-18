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

    List<Contact> contacts = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder<List<Contact>>(
          future: contactService.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListBody(
                children: snapshot.data!
                    .map((contact) => CartContactWidget(
                          contact: contact,
                          onDelete: () async {
                            await contactService.deleteById(contact.id!);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Contato ${contact!.name} deletado'),
                              ),
                            );
                          },
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContactFormPage(
                                contact: contact,
                              );
                            })).then((value) async {
                              setState(() {});
                            });
                          },
                        ))
                    .toList(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return CircularProgressIndicator();
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactFormPage();
          })).then((value) async {
            setState(() {});
          });
        },
      ),
    );
  }
}

class CartContactWidget extends StatelessWidget {
  final Contact? contact;
  final Function? onDelete;
  final Function? onTap;

  const CartContactWidget({this.contact, this.onDelete, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(contact!.id!);
    return Card(
      child: Dismissible(
        key: ObjectKey(DateTime.now().microsecond),
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
          if (onDelete != null) {
            onDelete!();
          }
        },
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.delete), Icon(Icons.delete)],
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        child: ListTile(
          title: Text(contact!.name!),
          subtitle: Text("${contact!.phoneNumber} - ${contact!.email}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact!.image ??
                "https://picsum.photos/seed/${contact!.name}/100"),
          ),
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) {
            //       return ContactFormPage(
            //         contact: contact,
            //       );
            //     })).then((value) {
            //   setState(() {
            //     contacts = contactService.getAll()!;
            //   });
            // });
          },
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ContactAction.call,
                onTap: () async {
                  launch("tel://${contact!.phoneNumber}");
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
                  launch("mailto:${contact!.email!}");
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
                  if (onDelete != null) {
                    onDelete!();
                  }
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
    );
  }
}
