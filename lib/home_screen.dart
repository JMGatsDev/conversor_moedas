import 'dart:developer' as developer;
import 'package:coonversor_moedas/Components/my_text_field.dart';
import 'package:coonversor_moedas/Repository/coins_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final realController = TextEditingController();
    final dolarController = TextEditingController();
    final euroController = TextEditingController();

    late double dolars;
    late double euros;

    void clearAll() {
      realController.text = "";
      dolarController.text = "";
      euroController.text = "";
    }

    void realChanged(String txt) {
      try {
        if (txt.isEmpty) {
          clearAll();
        }
        double real = double.parse(txt);
        dolarController.text = (real / dolars).toStringAsFixed(2);
        euroController.text = (real / euros).toStringAsFixed(2);
      } catch (e) {
        developer.log("$e");
      }
    }

    void dolarChanged(String txt) {
      try {
        if (txt.isEmpty) {
          clearAll();
        }
        double dolar = double.parse(txt);
        realController.text = (dolar * dolars).toStringAsFixed(2);
        euroController.text = (dolar * dolars / euros).toStringAsFixed(2);
      } catch (e) {
        developer.log("$e");
      }
    }

    void euroChanged(String txt) {
      try {
        if (txt.isEmpty) {
          clearAll();
        }
        double euro = double.parse(txt);
        realController.text = (euro * euros).toStringAsFixed(2);
        dolarController.text = (euro * euros / dolars).toStringAsFixed(2);
      } catch (e) {
        developer.log("$e");
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("\$ Conversor"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: CoinsRepository().getCoinsTotal(),
        builder: (context, coin) {
          switch (coin.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text(
                  "Erro ao Conectar com a API",
                  style: TextStyle(fontSize: 25),
                ),
              );
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  "Carengando Dado...",
                  style: TextStyle(fontSize: 25),
                ),
              );
            default:
              if (coin.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao Carergar dados",
                    style: TextStyle(fontSize: 25),
                  ),
                );
              } else {
                dolars = coin.data!["results"]["currencies"]["USD"]["buy"];
                euros = coin.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on_sharp,
                        size: 150,
                        color: Colors.green,
                      ),
                      myTextField(
                          coin: "Reais",
                          prefix: "R\$",
                          context: context,
                          controller: realController,
                          function: realChanged),
                      const Divider(),
                      myTextField(
                          coin: "Dólares",
                          prefix: "US\$",
                          context: context,
                          controller: dolarController,
                          function: dolarChanged),
                      const Divider(),
                      myTextField(
                          coin: "Euros",
                          prefix: "€",
                          context: context,
                          controller: euroController,
                          function: euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
