import 'package:betweener_app/controllers/auth_controller.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:betweener_app/views/main_app_view.dart';
import 'package:betweener_app/views/widgets/navigate_widget.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthHelper _authHelper = AuthHelper.instance;

  Future<void> registerUser(
      Map<String, String> data, BuildContext context) async {
    await _authHelper.register(data).then((value) {
      if (value) {
        navigatePushReplacement(
            context: context, nextScreen: const MainAppView());
      }
    });
  }

  Future<void> loginUser(Map<String, String> data, BuildContext context,
      LinkProvider linkProvider) async {
    await _authHelper.login(data, context, linkProvider);
  }
}
