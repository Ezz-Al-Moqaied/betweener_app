
import 'package:betweener_app/provider/link_provider.dart';
import 'package:betweener_app/views/main_app_view.dart';
import 'package:betweener_app/views/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingView extends StatefulWidget {
  static const id = '/loadingView';

  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  void checkLogin() async {
    final linkProvider = Provider.of<LinkProvider>(context);
    await linkProvider.getLinks().then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('user') && mounted) {
        Navigator.pushReplacementNamed(context, MainAppView.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginView.id);
      }
    });
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
