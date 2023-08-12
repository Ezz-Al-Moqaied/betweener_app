import 'package:betweener_app/constants.dart';
import 'package:betweener_app/provider/auth_provider.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:betweener_app/views/add_link_view.dart';
import 'package:betweener_app/views/home_view.dart';
import 'package:betweener_app/views/loading_view.dart';
import 'package:betweener_app/views/main_app_view.dart';
import 'package:betweener_app/views/profile_view.dart';
import 'package:betweener_app/views/receive_view.dart';
import 'package:betweener_app/views/views/login_view.dart';
import 'package:betweener_app/views/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LinkProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              scaffoldBackgroundColor: kScaffoldColor),
          home: const LoadingView(),
          routes: {
            LoadingView.id: (context) => const LoadingView(),
            LoginView.id: (context) => const LoginView(),
            RegisterView.id: (context) => const RegisterView(),
            HomeView.id: (context) => const HomeView(),
            MainAppView.id: (context) => const MainAppView(),
            ProfileView.id: (context) => const ProfileView(),
            ReceiveView.id: (context) => const ReceiveView(),
            AddLinkView.id: (context) => const AddLinkView(),
          },
        );
      },
    );
  }
}
