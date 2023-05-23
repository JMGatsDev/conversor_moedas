import 'package:coonversor_moedas/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white),
    ),
  );
}
