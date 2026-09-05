import 'package:flutter/material.dart';
import 'package:movie_app/pages/pages.dart';
import 'package:movie_app/themes/themes.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData(fontFamily: 'Poppins').textTheme;
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: const HomePage(),
    );
  }
}
