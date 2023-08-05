import 'package:betweener_app/constants.dart';
import 'package:flutter/material.dart';
class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomFloatingNavBar(
      {super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: kPrimaryColor,
          selectedItemColor: Colors.white,
          selectedIconTheme: const IconThemeData(size: 28),
          unselectedItemColor: Colors.grey.shade300,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: currentIndex == 0
                    ? const Icon(
                        Icons.emergency_share,
                        color: kSecondaryColor,
                        size: 30,
                      )
                    : const Icon(
                        Icons.emergency_share_outlined,
                        size: 30,
                      ),
                label: ''),
            BottomNavigationBarItem(
                icon: currentIndex == 1
                    ? const Icon(
                        Icons.home,
                        color: kSecondaryColor,
                        size: 30,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                label: ''),
            BottomNavigationBarItem(
                icon: currentIndex == 2
                    ? const Icon(
                        Icons.person,
                        color: kSecondaryColor,
                        size: 30,
                      )
                    : const Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
                label: '')
          ],
        ),
      ),
    );
  }
}
