import 'package:book_shop/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarThemeData(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 131, 4, 154),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          primary: const Color.fromARGB(255, 131, 4, 154),
          secondary: const Color.fromARGB(255, 166, 21, 192),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const Home(),
    );
  }
}
