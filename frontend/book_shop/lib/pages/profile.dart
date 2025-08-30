import 'package:book_shop/Common/fetchUser.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/pages/change_password.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> getUserData() async {
    setState(() {
      fetchUser();
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My Account', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CircleAvatar(
                backgroundColor: Colors.black87,
                radius: 50,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            user != null
                ? Text(
                    '${user!['first_name']} ${user!['last_name']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : CircularProgressIndicator(),
            user != null
                ? Text(
                    user!['email'],
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  )
                : CircularProgressIndicator(),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('My books'),
              leading: Icon(Icons.book_sharp, color: Colors.deepPurple),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock, color: Colors.deepPurple),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
            ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
