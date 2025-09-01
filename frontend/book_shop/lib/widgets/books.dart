import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/pages/about_book.dart';
import 'package:book_shop/widgets/book_card.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final bool buttonWorking;
  final List<Book>? book;
  const BookList({super.key, required this.book, required this.buttonWorking});

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
                    child: buttonWorking
                        ? InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AboutBook(book: book![i]),
                                ),
                              );
                            },
                            child: BookCard(book: book, i: i),
                          )
                        : BookCard(book: book, i: i),
                  );
          },
        ),
      ),
    );
  }
}
