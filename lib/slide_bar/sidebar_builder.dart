import 'package:flutter/cupertino.dart';

typedef SidebarBuilder = Widget Function(
    bool selected,
    bool hovered,
    );

class SidebarItem {
  const SidebarItem({
    this.label,
    this.icon,
    @Deprecated('Use iconBuilder instead') this.iconWidget,
    this.iconBuilder,
    this.onTap,
    this.onLongPress,
    this.onSecondaryTap,
    this.selectable = true,
  }) : assert(
  (icon != null || iconBuilder != null || iconWidget != null),
  'You can create SidebarXItem with IconData? icon or with Widget? iconWidget',
  );

  final String? label;
  final IconData? icon;
  @Deprecated('Use iconBuilder instead')
  final Widget? iconWidget;
  final bool selectable;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onSecondaryTap;

  final SidebarBuilder? iconBuilder;
}
