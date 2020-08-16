import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String _name = "";
  int _count = 0;

  List _dados;
  List _dadosAux;

  void _getUsersName() async {
    _dados = await getJson();
    setState(() {
      _name = _dados[_count]['friends'][0]['name'];
    });
    _count++;
  }

  void _startN() async {
    _dados = await getJson();
    setState(() {
      _dadosAux = _dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    _startN();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Json"),
            ),
            Icon(Icons.computer)
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _startN)
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _dadosAux == null ? 0 : _dadosAux.length,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (BuildContext context, int posicao) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text("${_dadosAux[posicao]['name']}"),
                  subtitle:
                      Text("${_dadosAux[posicao]['friends'][_count]['name']}"),
                  leading: CircleAvatar(
                      //child: Icon(Icons.person),
                      child: Text("${_dadosAux[posicao]['name'][0]}")),
                  onTap: () => _mostrarMensagem(
                      context,
                      _dadosAux[posicao]['name'],
                      _dadosAux[posicao]['friends']),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

_mostrarMensagem(BuildContext context, String name, List friends) {
  print("Botão: ${friends[0]['name']}");
  var alert = new AlertDialog(
    title: Text(name),
    content: ListView.builder(
      itemBuilder: (BuildContext context, int pos) {
        return ListView(
          children: <Widget>[Text(friends[pos]['name'])],
        );
      },
    ),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok")),
    ],
  );

  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String url = "http://www.json-generator.com/api/json/get/cfaAAbayUO?indent=2";

  http.Response respota = await http.get(url);

  if (respota.statusCode == 200) {
    return json.decode(respota.body);
  } else {
    throw Exception('Erro!');
  }
}
