import 'package:book_shop/auth_service/auth_service.dart';

Map<String, dynamic>? user;

Future<void> fetchUser() async {
  final data = await getUser();
  user = data;
}
