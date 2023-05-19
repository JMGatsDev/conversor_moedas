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
    double dolar;
    double euro;
    return Scaffold(
      appBar: AppBar(
        title: const Text("\$ Conversor"),
        centerTitle: true,
        backgroundColor: Colors.amber,
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
                dolar = coin.data!["results"]["currencies"]["USD"]["buy"];
                euro = coin.data!["results"]["currencies"]["EUR"]["buy"];
                return Container();
              }
          }
        },
      ),
    );
  }
}
