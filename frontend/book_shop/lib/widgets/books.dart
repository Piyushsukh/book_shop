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
        padding: const EdgeInsets.all(12.0),
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
                                  Divider(),
                                  Text(
                                    'Synopsis:${book![i].synopsis}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
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

  // data.map((book) => Book.fromJSON(book)).toList();
  // Future<List<Book>> fetchBook() async {
  //   final response = await http.get(Uri.parse("http://127.0.0.1:8000/book/"));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     print(data);
  //     print(data.map((book) => Book.fromJSON(book)).toList());
  //     return data.map((book) => Book.fromJSON(book)).toList();
  //   } else {
  //     throw Exception("Failed to load books");
  //   }
  // }