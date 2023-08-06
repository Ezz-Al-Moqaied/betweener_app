import 'package:betweener_app/views/home_view.dart';
import 'package:betweener_app/views/profile_view.dart';
import 'package:betweener_app/views/receive_view.dart';
import 'package:betweener_app/views/widgets/custom_floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class MainAppView extends StatefulWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 1;

  late List<Widget?> screensList = [
    const ReceiveView(),
    const HomeView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    print(true);
    return Scaffold(
      body: screensList[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
