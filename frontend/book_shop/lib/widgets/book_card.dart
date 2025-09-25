import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:book_shop/details/bookdetails.dart';

class BookCard extends StatelessWidget {
  final List<Book>? book;
  final int i;
  final bool deleteButton;
  const BookCard({
    super.key,
    this.book,
    required this.i,
    required this.deleteButton,
  });

  void deleteBook(String i) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.delete(
        Uri.parse('$url/book/my-books/i'),
        headers: {'Authorization': 'Token $token'},
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
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
            padding: const EdgeInsets.all(12.0), // const added
            child: Image.network(
              book![i].imageUrl,
              width: 150,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title :${book![i].bookName}'),
                const Divider(), // const added
                Text('Author : ${book![i].authorName}'),
                const Divider(), // const added
                Text('Publisher : ${book![i].publisherName}'),
                const Divider(), // const added
                Text(
                  'Published Date :${DateFormat.yMMMd().format(book![i].publishDate)}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
