import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';
import '../widgets/tab_layout.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Project> projects;
  final Function(Project) onFavorite;
  final ValueChanged<int> onNavTap;
  final VoidCallback onDonate;

  const FavoritesScreen({
    super.key,
    required this.projects,
    required this.onFavorite,
    required this.onNavTap,
    required this.onDonate,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = projects.where((project) => project.isFavorite).toList();

    return TabLayout(
      title: 'FAVORITES',
      selectedIndex: 0,
      onNavTap: onNavTap,
      child: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 50, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Favorite Projects Yet',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart icon on projects to add them here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Your Favorite Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 16),
                ...favorites.map(
                  (project) => ProjectCard(
                    project: project,
                    onFavorite: () => onFavorite(project),
                    onDonate: onDonate,
                  ),
                ),
              ],
            ),
    );
  }
}
