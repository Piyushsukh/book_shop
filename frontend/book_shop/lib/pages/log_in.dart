import 'package:book_shop/pages/sign_in.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> textField = ['Username', 'Password'];
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: size.height / 6,
          bottom: size.height / 5,
        ),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: textField.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textField[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: textField[index],
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                maximumSize: Size(double.infinity, 50),
              ),
              child: Text('Log In'),
            ),
            SizedBox(height: 10),
            Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                maximumSize: Size(double.infinity, 50),
              ),
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Don\'t Have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    "Signup",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
