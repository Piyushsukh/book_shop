import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/details/cart_items.dart';
import 'package:book_shop/main.dart';
import 'package:book_shop/pages/checkout.dart';
import 'package:book_shop/pages/pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AboutBook extends StatelessWidget {
  final Book book;
  const AboutBook({super.key, required this.book});

  void openPreview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFViewPage(pdfUrl: book.preview),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ColoredBox(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    book.imageUrl,
                    fit: BoxFit.cover,
                    height: size.height / 2.7,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        Text(
                          book.bookName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Author: ${book.authorName}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Publisher: ${book.publisherName}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Type: ${book.subject}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Publish Date: ${DateFormat('yyyy-MM-dd').format(book.publishDate)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Last Sold: ${DateFormat('yyyy-MM-dd').format(book.lastSold)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Text(
                              '₹${book.price}',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 18, 126, 21),
                              ),
                            ),
                            const SizedBox(width: 13),
                            Text(
                              '₹${book.price + book.discount}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 99, 99, 99),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () => openPreview(context),
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 23,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            fixedSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          label: const Text(
                            'Preview Book',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                return TextButton(
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .addItem(
                                          CartItems(
                                            name: book.bookName,
                                            imageUrl: book.imageUrl,
                                            author: book.authorName,
                                            price: book.price,
                                            discount: book.discount,
                                          ),
                                        );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Item added successfully',
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    overlayColor: Colors.transparent,
                                    backgroundColor: Colors.grey,
                                    fixedSize: Size(size.width / 2.5, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Add to cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                      totalPrice: book.price.toString(),
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                overlayColor: Colors.transparent,
                                backgroundColor: Colors.black,
                                fixedSize: Size(size.width / 2.5, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Buy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
