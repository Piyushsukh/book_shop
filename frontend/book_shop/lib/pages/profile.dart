import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            Text(
              'Piyush Sukhwani',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'piyush@gmail.com',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock, color: Colors.deepPurple),
              onTap: () {},
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
