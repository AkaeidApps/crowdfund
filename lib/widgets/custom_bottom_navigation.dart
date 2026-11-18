import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const List<IconData> icons = [
    Icons.favorite,
    Icons.dashboard,
    Icons.chat_bubble,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(38)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(icons.length, (index) {
          final bool selected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 70,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      icons[index],
                      size: 24,
                      color: selected ? AppColors.cyan : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
