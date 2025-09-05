import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/details/cart_items.dart';
import 'package:book_shop/main.dart';
import 'package:book_shop/pages/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class AboutBook extends StatelessWidget {
  final Book book;
  const AboutBook({super.key, required this.book});
  Future<void> openPreview() async {
    await OpenFilex.open(book.preview);
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
            padding: const EdgeInsets.all(14.0),
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
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children: [
                        Text(
                          book.bookName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Author: ${book.authorName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Publisher: ${book.publisherName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Type: ${book.subject}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Publish Date: ${DateFormat('yyyy-MM-dd').format(book.publishDate)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Last Sold: ${DateFormat('yyyy-MM-dd').format(book.lastSold)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 7),
                        Row(
                          children: [
                            Text(
                              '₹${book.price}',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 18, 126, 21),
                              ),
                            ),
                            SizedBox(width: 13),
                            Text(
                              '₹${book.price + book.discount}',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 99, 99, 99),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: const Color.fromARGB(
                                  255,
                                  99,
                                  99,
                                  99,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: openPreview,
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 23,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            fixedSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                          ),
                          label: Text(
                            'Preview Book',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
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
                                      SnackBar(
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
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                    ),
                                  ),
                                  child: Text(
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
                              style: ElevatedButton.styleFrom(
                                overlayColor: Colors.transparent,
                                backgroundColor: Colors.black,
                                fixedSize: Size(size.width / 2.5, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                ),
                              ),
                              child: Text(
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
