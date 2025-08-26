import 'dart:convert';

import 'package:book_shop/Common/Widgets/custom_button.dart';
import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/pages/add_book.dart';
import 'package:book_shop/pages/log_in.dart';
import 'package:book_shop/widgets/books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  Future<void> logOut() async {
    Navigator.of(context).pop();
    if (await loggingOut()) {
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
      ).showSnackBar(SnackBar(content: Text('Log out Failed')));
    }
  }

  Future<List<Book>> fetchBook() async {
    try {
      final response = await http.get(Uri.parse('$url/book'));
      List jsonData = jsonDecode(response.body);
      return jsonData.map((book) => Book.fromJSON(book)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> check() async {
    if (await isLoggedIn()) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      'All',
      'Education',
      'Novel',
      'Story Telling',
      'Fictional',
      'Non Fictional',
    ];
    return Scaffold(
      floatingActionButton: isAuth
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AddBook()));
                },
                child: Icon(Icons.add),
              ),
            )
          : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: isAuth
            ? Builder(
                builder: (context) {
                  return IconButton(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, color: Colors.white, size: 30),
                  );
                },
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                if (!isAuth)
                  CustomButton(
                    text: 'Log in',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        shape: Border.all(width: 0),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                '''Welcome 
           User''',

                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(title: Text('Prfile'), leading: Icon(Icons.person)),
            ListTile(title: Text('Settings'), leading: Icon(Icons.settings)),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
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
                            logOut();
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
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(),
            ),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(label: Text(list[i])),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: TextButton(onPressed: () {}, child: Text('Search')),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),

          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Chip(
                label: Text(
                  'Subjects',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
              ),
              Chip(
                label: Text(
                  'Author',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
              ),
              Chip(
                label: Text(
                  'Publisher',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: fetchBook(),
            builder: (context, snapshot) {
              return BookList(book: snapshot.data);
            },
          ),
        ],
      ),
    );
  }
}
