import 'dart:convert';

import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/widgets/books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  Future<List<Book>> fetchMyBook() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('$url/book/my-books/'),
        headers: {'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body);
        final map = jsonData.map((book) => Book.fromJSON(book)).toList();
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My books', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: fetchMyBook(),
            builder: (context, snapshot) {
              return BookList(book: snapshot.data, buttonWorking: false);
            },
          ),
        ],
      ),
    );
  }
}
