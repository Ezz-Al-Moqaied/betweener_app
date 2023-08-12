import 'dart:convert';
import 'package:betweener_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<List<User>> searchUser(String query) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final body = {
    'name': query
  };

  final response = await http.post(Uri.parse(searchUrl),
      body: body, headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['user'] as List<dynamic>;
    return data.map((e) => User.fromJson(e)).toList();
  } else {
    throw Exception('Failed to get User From Json');
  }
}
