import 'dart:convert';

import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/widgets/my_books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyBooks extends StatefulWidget {
  final VoidCallback onUpdate;
  const MyBooks({super.key, required this.onUpdate});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  void refresh() {
    setState(() {});
    widget.onUpdate();
  }

  Future<List<MyBook>> fetchMyBook() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('$url/book/my-books/'),
        headers: {'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body);
        final map = jsonData.map((book) => MyBook.fromJSON(book)).toList();
        return map;
      } else {
        return throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('My books', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          FutureBuilder<List<MyBook>>(
            future: fetchMyBook(),
            builder: (context, snapshot) {
              return MyBookList(
                book: snapshot.data,
                buttonWorking: false,
                onUpdate: refresh,
              );
            },
          ),
        ],
      ),
    );
  }
}
