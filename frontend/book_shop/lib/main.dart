import 'package:book_shop/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          primary: Colors.purple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const Home(),
    );
  }
}
