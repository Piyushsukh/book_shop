import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/pages/home_page.dart';
import 'package:book_shop/pages/profile.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDark = false;
  bool isNotificationOn = false;
  Future<void> logOut2() async {
    if (await loggingOut()) {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      setState(() {
        isAuth = false;
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Log out Successfully')));
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Log out failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person),
            subtitle: Text('Manage your account details'),
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          Divider(),
          SwitchListTile(
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
              });
            },
            title: Text('Dark mode'),
            secondary: Icon(Icons.dark_mode),
          ),
          Divider(),
          SwitchListTile(
            value: isNotificationOn,
            onChanged: (val) {
              setState(() {
                isNotificationOn = val;
              });
            },
            title: Text('Notifications'),
            secondary: Icon(Icons.notifications),
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      'Log out',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    content: Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          logOut2();
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
