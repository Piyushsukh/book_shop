import 'package:book_shop/details/bookdetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookCard extends StatelessWidget {
  final List<Book>? book;
  final int i;
  const BookCard({super.key, required this.book, required this.i});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network(
              fit: BoxFit.cover,
              book![i].imageUrl,
              width: 150,
              height: 200,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title :${book![i].bookName}'),
                Divider(),
                Text('Author : ${book![i].authorName}'),
                Divider(),
                Text('Publisher : ${book![i].publisherName}'),
                Divider(),
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
