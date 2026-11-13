import 'package:flutter/material.dart';
import 'screens/book_page.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.brown, useMaterial3: true),
      home: const BookPage(),
    );
  }
}
