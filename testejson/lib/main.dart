import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testejson/ui/myHome.dart';
import 'package:http/http.dart' as http;

void main() async {
  List dados = await getJson();
  String _name = dados[0]['name'];
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
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
