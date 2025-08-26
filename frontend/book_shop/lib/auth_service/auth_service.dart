import 'dart:convert';

import 'package:book_shop/Secrets/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    Uri.parse('$url/auth/login/'),
    body: jsonEncode({'username': username, 'password': password}),
  );
  if (response.statusCode != 200) {
    throw Exception('Login failed : ${response.statusCode} ${response.body}');
  }

  final data = jsonDecode(response.body);
  final token = data['token'];
  await storage.write(key: 'token', value: token);
  return data;
}

Future<Map<String, dynamic>> register(
  String firstName,
  String lastName,
  String username,
  String email,
  String password,
  String confirmPassword,
) async {
  final response = await http.post(
    Uri.parse('$url/auth/register/'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    body: jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    }),
  );
  if (response.statusCode != 201) {
    throw Exception('Login failed : ${response.statusCode} ${response.body}');
  }

  final data = jsonDecode(response.body);
  final token = data['token'];
  await storage.write(key: 'token', value: token);
  return data;
}

Future<bool> isLoggedIn() async {
  String? token = await storage.read(key: 'token');
  return token != null;
}

Future<bool> loggingOut() async {
  String? token = await storage.read(key: 'token');
  final response = await http.post(
    Uri.parse('$url/auth/logout/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    },
  );
  if ((response.statusCode == 200)) {
    await storage.delete(key: 'token');
    return true;
  } else {
    return false;
  }
}
