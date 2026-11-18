import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/tab_layout.dart';
import 'conversation_screen.dart';

class MessagesScreen extends StatelessWidget {
  final ValueChanged<int> onNavTap;

  const MessagesScreen({super.key, required this.onNavTap});

  static const List<Map<String, String>> messages = [
    {
      'name': 'Admin Support',
      'message': 'Welcome to Crowdfund! How can we assist you today?',
      'time': '09:10 AM',
    },
    {
      'name': 'Project Manager',
      'message': 'Your sponsored education project has been updated.',
      'time': 'Yesterday',
    },
    {
      'name': 'Donation Team',
      'message': 'Thank you for your generous contribution!',
      'time': 'Monday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TabLayout(
      title: 'MESSAGES',
      selectedIndex: 2,
      onNavTap: onNavTap,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your Conversations',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 16),
          ...messages.map(
            (message) => Card(
              elevation: 0,
              color: AppColors.lightGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryBlue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  message['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    message['message']!,
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Text(
                  message['time']!,
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConversationScreen(name: message['name']!),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
