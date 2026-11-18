import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';
import '../widgets/tab_layout.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Project> projects;
  final Function(Project) onFavorite;
  final VoidCallback onDonate;
  final ValueChanged<int> onNavTap;

  const ProjectsScreen({
    super.key,
    required this.projects,
    required this.onFavorite,
    required this.onDonate,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabLayout(
      title: 'CROWDFUND',
      selectedIndex: 1,
      onNavTap: onNavTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'DISCOVER PROJECTS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: AppColors.primaryBlue),
                  ),
                ],
              ),
              const Text(
                'Support a cause and make a difference.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 20),
              isWide
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.15,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return ProjectCard(
                          project: project,
                          onFavorite: () => onFavorite(project),
                          onDonate: onDonate,
                        );
                      },
                    )
                  : Column(
                      children: projects
                          .map(
                            (project) => ProjectCard(
                              project: project,
                              onFavorite: () => onFavorite(project),
                              onDonate: onDonate,
                            ),
                          )
                          .toList(),
                    ),
            ],
          );
        },
      ),
    );
  }
}
