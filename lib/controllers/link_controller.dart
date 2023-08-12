import 'dart:convert';
import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/shared_preferences.dart';
import 'package:betweener_app/models/link.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/views/widgets/flutterToastWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LinkHelper {
  LinkHelper._();

  static final LinkHelper instance = LinkHelper._();

  Future<List<Link>> links() async {
    final response = await http.get(Uri.parse(linksUrl), headers: {
      'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['links'] as List<dynamic>;
      return data.map((e) => Link.fromJson(e)).toList();
    }

    return Future.error('an error occurred');
  }

  Future<LinkModel> deleteLink(String id) async {
    String url = "$deleteUrl$id";
    final response = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    });

    if (response.statusCode == 200) {
      return linkModelFromJson(response.body);
    } else {
      flutterToastWidget(
          msg: "Check the data process", colors: Colors.redAccent);
      return Future.error('an error occurred');
    }
  }

  Future<LinkModel> updateLink(Link link) async {
    final bodyData = {'title': link.title, 'link': link.link};

    String url = "$linksUrl/${link.id}";

    final response = await http.put(Uri.parse(url), body: bodyData, headers: {
      'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    });

    if (response.statusCode == 200) {
      return linkModelFromJson(response.body);
    } else {
      flutterToastWidget(
          msg: "Check the data process", colors: Colors.redAccent);
      return Future.error('an error occurred');
    }
  }
}

Future<LinkModel> addLink(Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(linksUrl),
      body: body, headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    return linkModelFromJson(response.body);
  } else {
    throw Exception('Failed to link From Json');
  }
}
