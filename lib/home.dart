import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "dart:convert";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "Resultado";
  TextEditingController cepController = TextEditingController();

  _RecuperarCep() async{
    String cep = cepController.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;


    response = await http.get((Uri.parse(url)));
    Map <String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    // print("resposta logradouro: ${logradouro}");
    // print("resposta bairro: ${bairro}");
    // print("resposta cidade: ${localidade}");
    // print(response.body);

    setState(() {
      _resultado = "${logradouro}, ${bairro}, ${localidade}";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviços web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite um cep: ex: 64207175, sem espaços ou traços",
              ),
            ),
            ElevatedButton(
                onPressed: _RecuperarCep,
                child: Text("Clique aqui"),
            ),
            Text (_resultado),
          ],
        ),
      ),
    );
  }
}
