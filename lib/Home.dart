import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //convert to json

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = ("");

  //add http: ^0.12.0+1 in pubspecs.yaml/dependencies
  _recuperarCep() async {
    String _cepDigitado = _controllerCep.text;
    String url = "http://viacep.com.br/ws/${_cepDigitado}/json/";

    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado =
          "${logradouro},\n${complemento},\n ${bairro},\n ${localidade}. ";
    });

    /*print(
        "Logradouro:  ${logradouro}\n Complemento:  ${complemento}\n Bairro:  ${bairro}\n Localidade:  ${localidade}"); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: "Digite o cep: Ex. 05428200"),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text(
              _resultado,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
