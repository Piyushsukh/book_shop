import 'package:book_shop/details/bookdetails.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final List<Book> book;
  final String bookType;
  const BookList({super.key, required this.bookType, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: book.length,
          itemBuilder: (context, i) {
            return Card(
              child: Row(
                children: [
                  Image.network(book[i].imageUrl),
                  Column(
                    children: [
                      Text('Title :${book[i].bookName}'),
                      Text('Author : ${book[i].authorName}'),
                      Text('Publisher : ${book[i].publisherName}'),
                      Text('Published Date : ${book[i].publishDate}'),
                      Text('Synopsis:${book[i].synopsis}'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
