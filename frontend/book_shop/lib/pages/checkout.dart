import 'package:book_shop/Common/Widgets/custom_button.dart';
import 'package:book_shop/pages/order_placed.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  final String totalPrice;
  const CheckOutPage({super.key, required this.totalPrice});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formkey = GlobalKey<FormState>();
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
  }

  void _submitButton() {
    if (selectedValue == 'Cod') {
      if (_formkey.currentState!.validate()) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OrderPlaced()),
          (r) => false,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select payment method')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              const Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 6),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Phone',
                ),
                validator: (val) {
                  if (val!.isEmpty || val.length != 10) {
                    return 'Please enter phone no.(9876543210)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Address\n1234 Main st',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'City',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter City name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Pincode',
                ),
                validator: (val) {
                  if (val!.isEmpty || val.length != 6) {
                    return 'Please enter pincode of 6 digit(123456)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Order summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 23),
                  ),
                  Text(
                    '₹${widget.totalPrice}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Payment',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              RadioListTile.adaptive(
                value: 'Cod',
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 'Cod';
                  });
                },
                title: const Text(
                  'Cash on delivery',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(text: 'Place order', onPressed: _submitButton),
            ],
          ),
        ),
      ),
    );
  }
}
