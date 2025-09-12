import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/widgets/my_book_card.dart';
import 'package:flutter/material.dart';

class MyBookList extends StatelessWidget {
  final bool buttonWorking;
  final List<MyBook>? book;
  const MyBookList({
    super.key,
    required this.book,
    required this.buttonWorking,
  });

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
                    child: MyBookCard(book: book, i: i, deleteButton: true),
                  );
          },
        ),
      ),
    );
  }
}
