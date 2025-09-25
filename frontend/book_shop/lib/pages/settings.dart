import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/pages/home_page.dart';
import 'package:book_shop/pages/profile.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final VoidCallback onUpdate;
  const SettingPage({super.key, required this.onUpdate});

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
      ).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
      setState(() {
        isAuth = false;
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Log out Successfully')));
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Log out failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Account'),
            leading: const Icon(Icons.person),
            subtitle: const Text('Manage your account details'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(onUpdate: widget.onUpdate),
                ),
              );
            },
          ),
          const Divider(),
          SwitchListTile(
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
              });
            },
            title: const Text('Dark mode'),
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
            ),
          ),
          const Divider(),
          SwitchListTile(
            value: isNotificationOn,
            onChanged: (val) {
              setState(() {
                isNotificationOn = val;
              });
            },
            title: const Text('Notifications'),
            secondary: Icon(
              isNotificationOn
                  ? Icons.notifications_active
                  : Icons.notifications,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: const Text(
                      'Log out',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          logOut2();
                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
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
