import 'package:flutter/material.dart';
import 'package:flutter_parcial3venturadeleon_bonillalovo/paginas/home.dart';

void main() {
  runApp(Marvel());
}

class Marvel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MarvelHome());
  }
}
