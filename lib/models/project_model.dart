import 'package:flutter/material.dart';

class Project {
  final String title;
  final String category;
  final String description;
  final String amount;
  final int progress;
  final IconData icon;
  bool isFavorite;

  Project({
    required this.title,
    required this.category,
    required this.description,
    required this.amount,
    required this.progress,
    required this.icon,
    this.isFavorite = false,
  });
}
