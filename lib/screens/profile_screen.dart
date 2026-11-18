import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/tab_layout.dart';

class ProfileScreen extends StatelessWidget {
  final ValueChanged<int> onNavTap;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.onNavTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return TabLayout(
      title: 'MY PROFILE',
      selectedIndex: 3,
      onNavTap: onNavTap,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryBlue,
              child: Icon(Icons.person, color: Colors.white, size: 55),
            ),
          ),
          const SizedBox(height: 14),
          const Center(
            child: Text(
              'Name Surname',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
          ),
          const Center(
            child: Text(
              'surname@gmail.com',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
          ),
          const SizedBox(height: 30),
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () => showMessage(context, 'Edit Profile'),
          ),
          ProfileMenuItem(
            icon: Icons.favorite_outline,
            title: 'My Favorites',
            onTap: () => onNavTap(0),
          ),
          ProfileMenuItem(
            icon: Icons.volunteer_activism,
            title: 'My Donations',
            onTap: () => showMessage(context, 'My Donations'),
          ),
          ProfileMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => showMessage(context, 'Notifications'),
          ),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => showMessage(context, 'Settings'),
          ),
          ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => showMessage(context, 'Help & Support'),
          ),
          ProfileMenuItem(
            icon: Icons.logout,
            title: 'Log out',
            isLogout: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onLogout();
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$message selected')),
  );
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: isLogout ? Colors.red : AppColors.primaryBlue),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : AppColors.textDark,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.textMuted,
        ),
        onTap: onTap,
      ),
    );
  }
}
