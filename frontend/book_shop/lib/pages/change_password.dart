import 'package:book_shop/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  List<String> textField = ['Old password', 'New password'];
  List<TextEditingController> textEditingController = [];

  Future<void> changePass() async {
    final cP = await changePassword(
      textEditingController[0].text,
      textEditingController[1].text,
    );

    if (cP) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password changed successfully!')));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password change failed')));
    }
  }

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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Change your password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: size.height / 7,
          bottom: size.height / 7,
        ),
        child: Column(
          children: [
            Text(
              'Change your password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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
                        controller: textEditingController[index],
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
              onPressed: changePass,
              style: ElevatedButton.styleFrom(
                maximumSize: Size(double.infinity, 50),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
