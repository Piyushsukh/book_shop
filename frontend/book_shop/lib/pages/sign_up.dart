import 'package:book_shop/pages/home_page.dart';
import 'package:book_shop/pages/log_in.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<void> _handlesignup() async {
    try {
      final data = await register(
        textEditingController[0].text,
        textEditingController[1].text,
        textEditingController[2].text,
        textEditingController[3].text,
        textEditingController[4].text,
        textEditingController[5].text,
      );
      if (!mounted) return;
      if (data['key'] != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered Successfully')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
  }

  final List<String> textField = const [
    "First name",
    "Last name",
    "Username",
    "Email",
    "Password",
    "Confirm password",
  ];

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(26),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
        child: Column(
          children: [
            const Text(
              'Sign Up',
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
              onPressed: _handlesignup,
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Sign Up'),
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
                const Text('Have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "Login",
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
