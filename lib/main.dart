import 'package:flutter/material.dart';
import 'package:flutter_lista/src/lista.dart';

void main() {
  runApp(const MainWidget());
}


class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListaWidget(),);
  }
}



