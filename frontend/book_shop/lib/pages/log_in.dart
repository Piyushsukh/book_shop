import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/pages/home_page.dart';
import 'package:book_shop/pages/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:book_shop/auth_service/auth_service.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Future<void> _handlelogin() async {
    try {
      final data = await login(
        textEditingController[0].text,
        textEditingController[1].text,
      );
      if (!mounted) return;
      if (data['token'] != null) {
        isAuth = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Logged In Successfully')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
    }
  }

  final List<String> textField = const ['Username', 'Password'];
  final List<TextEditingController> textEditingController = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < textField.length; i++) {
      textEditingController.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Log In',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(26),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: size.height / 7,
          bottom: size.height / 6,
        ),
        child: Column(
          children: [
            const Text(
              'Log In',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: textField.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textField[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: textEditingController[index],
                        decoration: InputDecoration(
                          hintText: textField[index],
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _handlelogin,
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 10),
            const Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
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
