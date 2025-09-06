import 'package:book_shop/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                ),
                color: const Color.fromARGB(255, 9, 166, 48),
              ),
              child: Text(
                'Order Placed',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.check_circle_outline,
              color: const Color.fromARGB(255, 17, 142, 21),
              size: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Thank you!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: size.width / 1.4,
              child: Text(
                'Your order has been placed successfully. It will be delivered to your address soon. Please keep cash ready for delivery.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 60),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(7),
                ),
                backgroundColor: const Color.fromARGB(255, 9, 166, 48),
                minimumSize: Size(size.width / 2, 60),
              ),

              child: Text(
                'Back To Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
