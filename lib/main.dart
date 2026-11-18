import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'models/project_model.dart';
import 'screens/donate_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/login_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/projects_screen.dart';

void main() {
  runApp(const CrowdfundApp());
}

class CrowdfundApp extends StatelessWidget {
  const CrowdfundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowdfund',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          primary: AppColors.primaryBlue,
          secondary: AppColors.cyan,
        ),
        fontFamily: 'Roboto',
      ),
      home: const CrowdfundHome(),
    );
  }
}

class CrowdfundHome extends StatefulWidget {
  const CrowdfundHome({super.key});

  @override
  State<CrowdfundHome> createState() => _CrowdfundHomeState();
}

class _CrowdfundHomeState extends State<CrowdfundHome> {
  bool isLoggedIn = false;
  bool showDonate = false;
  int currentTab = 1;

  final List<Project> projects = [
    Project(
      title: 'Education For Everyone',
      category: 'Education',
      description: 'Help children get access to quality education and learning materials.',
      amount: '\$2,500',
      progress: 78,
      icon: Icons.school,
      isFavorite: true,
    ),
    Project(
      title: 'Help Poor Families',
      category: 'Community',
      description: 'Support families who need food, shelter and basic necessities.',
      amount: '\$5,200',
      progress: 65,
      icon: Icons.volunteer_activism,
    ),
    Project(
      title: 'Save The Environment',
      category: 'Environment',
      description: 'Plant trees and protect our environment for future generations.',
      amount: '\$3,100',
      progress: 45,
      icon: Icons.eco,
    ),
  ];

  void changeTab(int index) {
    setState(() {
      currentTab = index;
      showDonate = false;
    });
  }

  void openDonate() {
    setState(() {
      showDonate = true;
    });
  }

  void goBackFromDonate() {
    setState(() {
      showDonate = false;
      currentTab = 1;
    });
  }

  void toggleFavorite(Project project) {
    setState(() {
      project.isFavorite = !project.isFavorite;
    });
  }

  void logout() {
    setState(() {
      isLoggedIn = false;
      showDonate = false;
      currentTab = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: !isLoggedIn
                ? LoginScreen(
                    onLogin: () {
                      setState(() {
                        isLoggedIn = true;
                        currentTab = 1;
                      });
                    },
                  )
                : showDonate
                    ? DonateScreen(onBack: goBackFromDonate, onNavTap: changeTab)
                    : IndexedStack(
                        index: currentTab,
                        children: [
                          FavoritesScreen(
                            projects: projects,
                            onFavorite: toggleFavorite,
                            onNavTap: changeTab,
                            onDonate: openDonate,
                          ),
                          ProjectsScreen(
                            projects: projects,
                            onFavorite: toggleFavorite,
                            onDonate: openDonate,
                            onNavTap: changeTab,
                          ),
                          MessagesScreen(onNavTap: changeTab),
                          ProfileScreen(onNavTap: changeTab, onLogout: logout),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
