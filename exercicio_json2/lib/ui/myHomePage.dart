import 'package:exercicio_json2/ui/widgets/listUsersWidget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício com Json"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[ListUsersWidget()],
      ),
    );
  }
}
