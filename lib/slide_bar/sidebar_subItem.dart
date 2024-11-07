import 'package:flutter/material.dart';

class SidebarSubItem {
  final String title;
  final VoidCallback? onTap;
  bool? isSelected;

  SidebarSubItem({
    required this.title,
    this.onTap,
    this.isSelected = false,
  });
}
