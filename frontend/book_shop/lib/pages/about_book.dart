import 'package:book_shop/details/bookdetails.dart';
import 'package:flutter/material.dart';

class AboutBook extends StatefulWidget {
  final List<Book>? book;
  const AboutBook({super.key, required this.book});

  @override
  State<AboutBook> createState() => _AboutBookState();
}

class _AboutBookState extends State<AboutBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
