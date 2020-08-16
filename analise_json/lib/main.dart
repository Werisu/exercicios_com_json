import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; // para o Json
import 'package:http/http.dart' as http;

void main() async {
  List dados = await getJson();

  //print(dados[0]['friends'][0]['name']);
  // print(dados[0]['friends'][0]);

  //buscando usuários no json e mostrando
  for (int i = 0; i < dados.length; i++) {
    String _name = dados[i]['name'];
    //listando os amigos dos usuários
    List _listaAmigos = dados[i]['friends'];
    debugPrint("amigos de $_name: ");
    //mostrando os amigos dos usuários
    for (int j = 0; j < _listaAmigos.length; j++) {
      String nameFriends = _listaAmigos[j]['name'];
      debugPrint("$nameFriends");
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Json'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Corpo',
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<List> getJson() async {
  String url = "http://www.json-generator.com/api/json/get/cfaAAbayUO?indent=2";

  http.Response resposta = await http.get(url);

  // sttus code == 200 (ok)
  if (resposta.statusCode == 200) {
    return json.decode(resposta.body);
  } else {
    throw Exception('Falhou!');
  }
}
