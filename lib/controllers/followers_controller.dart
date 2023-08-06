import 'dart:convert';

import 'package:betweener_app/constants.dart';
import 'package:betweener_app/models/follower_model.dart';
import 'package:betweener_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<FollowerModel> getFollowingCount() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    return followerModelFromJson(response.body);
  }
  return Future.error('Somthing wrong');
}

Future<dynamic> addFollow(Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(addFollowUrl),
      body: body, headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'].toString();
  }
}
