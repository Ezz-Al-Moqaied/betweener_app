import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/shared_preferences.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:betweener_app/views/main_app_view.dart';
import 'package:betweener_app/views/widgets/flutterToastWidget.dart';
import 'package:betweener_app/views/widgets/navigate_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthHelper {
  AuthHelper._();

  static final AuthHelper instance = AuthHelper._();

  Future<void> login(Map<String, String> body, BuildContext context,
      LinkProvider linkProvider) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: body,
    );
    if (response.statusCode == 200) {
      SharedPreferencesHelper.setUser(userModelFromJson(response.body))
          .then((value) async {
        await linkProvider.getLinks().then((value) {
          navigatePushReplacement(
              context: context, nextScreen: const MainAppView());
        });
      });
    } else {
      flutterToastWidget(
          msg: "Check the data process", colors: Colors.redAccent);
    }
  }

  Future<bool> register(Map<String, String> body) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      body: body,
    );
    if (response.statusCode == 201) {
      flutterToastWidget(
          msg: "The user has been registered successfully",
          colors: Colors.greenAccent);
      return true;
    } else if (response.statusCode == 200) {
      flutterToastWidget(msg: "Email is used", colors: Colors.deepOrangeAccent);
    } else {
      flutterToastWidget(
          msg: "The operation did not complete successfully",
          colors: Colors.redAccent);
    }
    return false;
  }
}