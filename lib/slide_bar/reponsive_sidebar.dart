import 'package:flutter/material.dart';
import 'package:widget_dictionary/slide_bar/sidebar_controller.dart';
import 'package:widget_dictionary/slide_bar/sidebar_menuItem.dart';
import 'package:widget_dictionary/slide_bar/sidebar_theme.dart';

import 'expandable_sidebar.dart';
class ResponsiveSidebar extends StatefulWidget {
  const ResponsiveSidebar({
    super.key,
    required this.controller,
    required this.theme,
    required this.child,
    this.items = const [],
    this.footerItems = const [],
    this.extendedTheme,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.toggleButtonBuilder,
    this.showToggleButton = true,
    this.headerDivider,
    this.footerDivider,
    this.animationDuration = const Duration(milliseconds: 300),
    this.collapseIcon = Icons.arrow_back_ios_new,
    this.extendIcon = Icons.arrow_forward_ios,
  });

  final SidebarController controller;
  final SideBarTheme theme;
  final SideBarTheme? extendedTheme;
  final List<SidebarMenuItem> items;
  final List<SidebarMenuItem> footerItems;
  final Widget child;
  final IndexedWidgetBuilder? separatorBuilder;
  final SidebarBuilder? headerBuilder;
  final SidebarBuilder? footerBuilder;
  final SidebarBuilder? toggleButtonBuilder;
  final bool showToggleButton;
  final Widget? headerDivider;
  final Widget? footerDivider;
  final Duration animationDuration;
  final IconData collapseIcon;
  final IconData extendIcon;

  @override
  _ResponsiveSidebarState createState() => _ResponsiveSidebarState();
}

class _ResponsiveSidebarState extends State<ResponsiveSidebar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('제목 영역'),
            ),
            drawer: Drawer(
              width: widget.controller.extended ? widget.theme.extendedWidth : widget.theme.collapsedWidth,
              child: ExpandableSidebar(
                controller: widget.controller,
                theme: widget.theme,
                extendedTheme: widget.extendedTheme,
                items: widget.items,
                footerItems: widget.footerItems,
                headerBuilder: widget.headerBuilder,
                footerBuilder: widget.footerBuilder,
                separatorBuilder: widget.separatorBuilder,
                toggleButtonBuilder: widget.toggleButtonBuilder,
                showToggleButton: widget.showToggleButton,
                headerDivider: widget.headerDivider,
                footerDivider: widget.footerDivider,
                animationDuration: widget.animationDuration,
                collapseIcon: widget.collapseIcon,
                extendIcon: widget.extendIcon,
              ),
            ),
            body: widget.child,
          );
        } else {
          return Row(
            children: [
              ExpandableSidebar(
                controller: widget.controller,
                theme: widget.theme,
                extendedTheme: widget.extendedTheme,
                items: widget.items,
                footerItems: widget.footerItems,
                headerBuilder: widget.headerBuilder,
                footerBuilder: widget.footerBuilder,
                separatorBuilder: widget.separatorBuilder,
                toggleButtonBuilder: widget.toggleButtonBuilder,
                showToggleButton: widget.showToggleButton,
                headerDivider: widget.headerDivider,
                footerDivider: widget.footerDivider,
                animationDuration: widget.animationDuration,
                collapseIcon: widget.collapseIcon,
                extendIcon: widget.extendIcon,
              ),
              Expanded(child: widget.child),
            ],
          );
        }
      },
    );
  }
}