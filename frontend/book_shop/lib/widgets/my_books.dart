import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/widgets/my_book_card.dart';
import 'package:flutter/material.dart';

class MyBookList extends StatefulWidget {
  final VoidCallback onUpdate;
  final bool buttonWorking;
  final List<MyBook>? book;
  const MyBookList({
    super.key,
    required this.book,
    required this.onUpdate,
    required this.buttonWorking,
  });

  @override
  State<MyBookList> createState() => _MyBookListState();
}

class _MyBookListState extends State<MyBookList> {
  void refresh() {
    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView.builder(
          itemCount: widget.book == null ? 0 : widget.book!.length,
          itemBuilder: (context, i) {
            return widget.book == null
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyBookCard(
                      onUpdate: refresh,
                      book: widget.book,
                      i: i,
                      deleteButton: true,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
