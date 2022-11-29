import 'package:flutter/material.dart';
import 'package:flutter_development_assignment/EpizodesPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EpisodesPage(),
    );
  }
}
