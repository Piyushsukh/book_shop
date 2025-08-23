// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  final String bookName;
  final int price;
  final int discount;
  final DateTime publishDate;
  final DateTime lastSold;
  final String imageUrl;
  final String authorName;
  final String publisherName;
  final String subject;
  final String synopsis;
  final String preview;
  const Book({
    required this.bookName,
    required this.lastSold,
    required this.preview,
    required this.price,
    required this.discount,
    required this.imageUrl,
    required this.authorName,
    required this.publisherName,
    required this.publishDate,
    required this.synopsis,
    required this.subject,
  });

  factory Book.fromJSON(Map<String, dynamic> map) {
    return Book(
      bookName: map['name'] as String,
      price: map['price'] as int,
      publishDate: DateTime.parse(map['publish_date']),
      lastSold: DateTime.parse(map['last_sold']),
      imageUrl: map['image'] as String,
      preview: map['preview'] as String,
      authorName: map['author'] as String,
      publisherName: map['publisher'] as String,
      subject: map['subject'] as String,
      synopsis: map['synopsis'] as String,
      discount: map['discount'] as int,
    );
  }

  static fromJson(book) {}
}
