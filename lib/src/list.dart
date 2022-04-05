import 'package:flutter/material.dart';

import 'cadastro.dart';

class ListaWidget extends StatelessWidget {
  const ListaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("T"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ContactFormPage();
          }));
        },
      ),
    );
  }
}
