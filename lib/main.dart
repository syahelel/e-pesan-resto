import 'package:e_pesan_resto/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E RESTO',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
