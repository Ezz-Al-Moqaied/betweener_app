import 'dart:convert';
import 'package:betweener_app/constants.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(user.token);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<LinkModel> addLink (Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  print(user.token);
  final response = await http.post(
    Uri.parse(linksUrl),
    body: body,
      headers: {'Authorization': 'Bearer ${user.token}'});


  if (response.statusCode == 200) {
    return linkModelFromJson(response.body);
  } else {
    throw Exception('Failed to link From Json');
  }
}

Future<LinkModel> updateLink (Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  print(user.token);
  final response = await http.put(
      Uri.parse(linksUrl),
      body: body,
      headers: {'Authorization': 'Bearer ${user.token}'});


  if (response.statusCode == 200) {
    return linkModelFromJson(response.body);
  } else {
    throw Exception('Failed to link From Json');
  }
}
