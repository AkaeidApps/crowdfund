import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_header.dart';
import 'custom_bottom_navigation.dart';

class TabLayout extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;
  final Widget child;

  const TabLayout({
    super.key,
    required this.title,
    required this.selectedIndex,
    required this.onNavTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader(title: title),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomRight: Radius.circular(38),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomRight: Radius.circular(38),
              ),
              child: child,
            ),
          ),
        ),
        CustomBottomNavigation(selectedIndex: selectedIndex, onTap: onNavTap),
      ],
    );
  }
}
