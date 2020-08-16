import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListUsersWidget extends StatefulWidget {
  @override
  _ListUsersWidgetState createState() => _ListUsersWidgetState();
}

List _dados;
int _count = 0;

void _Start() async {
  _dados = await getJson();

  void _listaMap() {
    _count = 0;
    for (int i = 0; i < _dados.length; i++) {
      _count++;
    }
  }

  _listaMap();
}

class _ListUsersWidgetState extends State<ListUsersWidget> {
  @override
  Widget build(BuildContext context) {
    _Start();
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _count,
          itemBuilder: (BuildContext context, int posicao) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "${posicao + 1}",
                    ),
                  ),
                  title: Text("${_dados[posicao]['name']}"),
                  subtitle: Text("${_dados[posicao]['email']}".toLowerCase()),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Você tem $_count contatos"),
        )
      ],
    );
  }
}

Future<List> getJson() async {
  String url = "https://jsonplaceholder.typicode.com/users";

  http.Response resposta = await http.get(url);
  if (resposta.statusCode == 200) {
    return jsonDecode(resposta.body);
  } else {
    throw Exception("Error");
  }
}
