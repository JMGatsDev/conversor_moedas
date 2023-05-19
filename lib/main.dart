import 'package:coonversor_moedas/Repository/coins_repository.dart';
import 'package:coonversor_moedas/home_screen.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
