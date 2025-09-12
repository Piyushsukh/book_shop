// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/pages/my_books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:book_shop/details/bookdetails.dart';

class MyBookCard extends StatefulWidget {
  final List<MyBook>? book;
  final int i;
  final bool deleteButton;
  const MyBookCard({
    super.key,
    this.book,
    required this.i,
    required this.deleteButton,
  });

  @override
  State<MyBookCard> createState() => _MyBookCardState();
}

class _MyBookCardState extends State<MyBookCard> {
  Future<void> deleteBook(int i) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.delete(
        Uri.parse('$url/book/my-books/$i/'),
        headers: {'Authorization': 'Token $token'},
      );
      print(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network(
              fit: BoxFit.cover,
              widget.book![widget.i].imageUrl,
              width: 150,
              height: 200,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title :${widget.book![widget.i].bookName}'),
                Divider(),
                Text('Author : ${widget.book![widget.i].authorName}'),
                Divider(),
                Text('Publisher : ${widget.book![widget.i].publisherName}'),
                Divider(),
                Text(
                  'Published Date :${DateFormat.yMMMd().format(widget.book![widget.i].publishDate)}',
                ),
              ],
            ),
          ),
          if (widget.deleteButton)
            IconButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => MyBooks()));
              },
              icon: Icon(Icons.delete),
            ),
        ],
      ),
    );
  }
}
