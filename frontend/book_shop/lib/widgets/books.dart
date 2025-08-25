import 'package:book_shop/details/bookdetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookList extends StatelessWidget {
  final List<Book>? book;
  const BookList({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView.builder(
          itemCount: book == null ? 0 : book!.length,
          itemBuilder: (context, i) {
            return book == null
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
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
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
