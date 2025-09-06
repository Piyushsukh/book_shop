import 'dart:convert';

import 'package:book_shop/Common/Widgets/custom_button.dart';
import 'package:book_shop/Common/fetchUser.dart';
import 'package:book_shop/Secrets/secret.dart';
import 'package:book_shop/auth_service/auth_service.dart';
import 'package:book_shop/details/bookdetails.dart';
import 'package:book_shop/details/more_info.dart';
import 'package:book_shop/pages/add_book.dart';
import 'package:book_shop/pages/cart.dart';
import 'package:book_shop/pages/log_in.dart';
import 'package:book_shop/pages/profile.dart';
import 'package:book_shop/pages/settings.dart';
import 'package:book_shop/widgets/books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String selecteChip;

  String? subjectName;
  String? authorName;
  Future<List<Subject>> fetchSubject() async {
    try {
      final response = await http.get(Uri.parse('$url/subjects/'));
      List jsonData = jsonDecode(response.body);
      final map = jsonData.map((book) => Subject.fromJSON(book)).toList();
      return map;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Author>> fetchAuthor() async {
    try {
      final response = await http.get(Uri.parse('$url/author/'));
      List jsonData = jsonDecode(response.body);
      final map = jsonData.map((book) => Author.fromJSON(book)).toList();
      return map;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getUserData() async {
    await fetchUser();
    setState(() {});
  }

  Future<void> logOut() async {
    Navigator.of(context).pop();
    if (await loggingOut()) {
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
      ).showSnackBar(const SnackBar(content: Text('Log out Failed')));
    }
  }

  Future<List<Book>> fetchBook() async {
    try {
      final http.Response response;

      if (subjectName != null) {
        response = await http.get(
          Uri.parse(
            '$url/subjects/by-subject/',
          ).replace(queryParameters: {'subject': subjectName}),
        );
      } else if (authorName != null) {
        response = await http.get(
          Uri.parse(
            '$url/author/by-author/',
          ).replace(queryParameters: {'author': authorName}),
        );
      } else {
        response = await http.get(Uri.parse('$url/book/'));
      }

      List jsonData = jsonDecode(response.body);
      final map = jsonData.map((book) => Book.fromJSON(book)).toList();
      return map;
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
    selecteChip = 'All';
    check();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAuth
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddBookPage(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
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
                    icon: const Icon(Icons.menu, color: Colors.white, size: 30),
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
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Cart()));
                  },
                  icon: const Icon(
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
                        MaterialPageRoute(builder: (context) => const LogIn()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: isAuth
          ? Drawer(
              shape: Border.all(width: 0),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: user != null
                        ? Text(
                            '''Welcome 
           ${user!['first_name']}''',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  ListTile(
                    title: const Text('Home'),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Profile'),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout),
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
                                  logOut();
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
            )
          : null,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: TextButton(
                  onPressed: () {},
                  child: const Text('Search'),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selecteChip = 'All';
                    subjectName = null;
                    authorName = null;
                  });
                },
                child: Chip(
                  label: Text(
                    'All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  backgroundColor: selecteChip == 'All'
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selecteChip = 'Types';
                    authorName = null;
                  });
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Types'),
                      content: SizedBox(
                        width: double.maxFinite,
                        height: 300,
                        child: FutureBuilder(
                          future: fetchSubject(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      subjectName = snapshot.data![i].name;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  title: Text(snapshot.data![i].name),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: Chip(
                  label: Text(
                    'Types',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: selecteChip == 'Types'
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selecteChip = 'Author';
                    subjectName = null;
                  });
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Types'),
                      content: SizedBox(
                        width: double.maxFinite,
                        height: 300,
                        child: FutureBuilder(
                          future: fetchAuthor(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      authorName = snapshot.data![i].name;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  title: Text(snapshot.data![i].name),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: Chip(
                  label: Text(
                    'Author',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: selecteChip == 'Author'
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selecteChip = 'Publisher';
                  });
                },
                child: Chip(
                  label: Text(
                    'Publisher',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: selecteChip == 'Publisher'
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: fetchBook(),
            builder: (context, snapshot) {
              return BookList(book: snapshot.data, buttonWorking: true);
            },
          ),
        ],
      ),
    );
  }
}
