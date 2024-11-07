import 'package:flutter/material.dart';
import 'package:widget_dictionary/slide_bar/sidebar_builder.dart';
import 'package:widget_dictionary/slide_bar/sidebar_subItem.dart';

class SidebarMenuItem {
  final List<SidebarSubItem> subItems;
  final VoidCallback? onTap;

  // New properties from SidebarItem
  final String? label;
  final IconData? icon;
  @Deprecated('Use iconBuilder instead')
  final Widget? iconWidget;
  final SidebarBuilder? iconBuilder;
  final bool selectable;
  final VoidCallback? onLongPress;
  final VoidCallback? onSecondaryTap;

  SidebarMenuItem({
    this.subItems = const [],
    this.onTap,

    // New properties
    this.label,
    this.icon,
    @Deprecated('Use iconBuilder instead') this.iconWidget,
    this.iconBuilder,
    this.selectable = true,
    this.onLongPress,
    this.onSecondaryTap,
  }) : assert(
  icon != null || iconBuilder != null || iconWidget != null,
  'You can create SidebarMenuItem with IconData? icon or with Widget? iconWidget',
  );
}
