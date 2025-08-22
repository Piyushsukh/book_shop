import 'package:flutter/material.dart';

class Book {
  final String bookName;
  final String price;
  final DateTime publishDate;
  final Image bookImage;
  final String authorName;
  final String publisherName;
  final String subject;
  final String synopsis;
  const Book({
    required this.bookName,
    required this.price,
    required this.bookImage,
    required this.authorName,
    required this.publisherName,
    required this.publishDate,
    required this.synopsis,
    required this.subject,
  });
}
