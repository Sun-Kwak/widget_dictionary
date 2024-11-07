import 'package:flutter/material.dart';
import 'package:widget_dictionary/slide_bar/sidebar_cell.dart';
import 'package:widget_dictionary/slide_bar/sidebar_controller.dart';
import 'package:widget_dictionary/slide_bar/sidebar_menuItem.dart';
import 'package:widget_dictionary/slide_bar/sidebar_theme.dart';

typedef SidebarBuilder = Widget Function(BuildContext context, bool extended);

class ExpandableSidebar extends StatefulWidget {
  const ExpandableSidebar({
    super.key,
    required this.controller,
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
    required this.theme,
  });

  final SideBarTheme theme;
  final SideBarTheme? extendedTheme;
  final List<SidebarMenuItem> items;
  final List<SidebarMenuItem> footerItems;
  final SidebarController controller;
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
  State<ExpandableSidebar> createState() => _ExpandableSidebarState();
}

class _ExpandableSidebarState extends State<ExpandableSidebar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  final OverlayPortalController portalController = OverlayPortalController();

  late List<LayerLink> _layerLink;
  LayerLink mainLayer = LayerLink();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    if (widget.controller.extended) {
      _animationController?.forward();
    } else {
      _animationController?.reverse();
    }
    widget.controller.extendStream.listen(
          (extended) {
        if (_animationController?.isCompleted ?? false) {
          _animationController?.reverse();
        } else {
          _animationController?.forward();
        }
      },
    );
    _layerLink = List.generate(widget.items.length, (_) => LayerLink());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal.targetsRootOverlay(
      controller: portalController,
      overlayChildBuilder: (context) {
        return AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            final extendedT = widget.extendedTheme?.mergeWith(widget.theme);
            final selectedTheme = widget.controller.extended
                ? extendedT ?? widget.theme
                : widget.theme;

            final t = selectedTheme.mergeFlutterTheme(context);

            return Column(
              children: [
                if (!widget.controller.extended && widget.controller.selectedIndex != null)
                  CompositedTransformFollower(
                    link: _layerLink[widget.controller.selectedIndex!],
                    offset: Offset(t.collapsedWidth, 5),
                    showWhenUnlinked: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.items[widget.controller.selectedIndex!].subItems.map((subItem) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: t.subDecoration,
                            height: 40,
                            width: t.extendedWidth,
                            child: GestureDetector(
                              onTap: subItem.onTap,
                              child: Center(
                                child: Text(
                                  subItem.title,
                                  style: TextStyle(color: t.iconTheme?.color),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            );
          },
        );
      },
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          final extendedT = widget.extendedTheme?.mergeWith(widget.theme);
          final selectedTheme = widget.controller.extended
              ? extendedT ?? widget.theme
              : widget.theme;

          final t = selectedTheme.mergeFlutterTheme(context);

          return AnimatedContainer(
            duration: widget.animationDuration,
            width: widget.controller.extended ? t.extendedWidth : t.collapsedWidth,
            height: t.height,
            padding: t.padding,
            margin: t.margin,
            decoration: t.decoration,
            child: Column(
              children: [
                widget.headerBuilder?.call(context, widget.controller.extended) ?? const SizedBox(),
                widget.headerDivider ?? const SizedBox(),
                Expanded(
                  child: ListView.separated(
                    itemCount: widget.items.length,
                    separatorBuilder: widget.separatorBuilder ?? (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CompositedTransformTarget(
                            link: _layerLink[index],
                            child: SidebarCell(
                              item: item,
                              extended: widget.controller.extended,
                              selected: widget.controller.selectedIndex == index,
                              theme: t,
                              onTap: () {
                                _onItemSelected(item, index);

                                if (!widget.controller.extended && widget.controller.selectedIndex != null) {
                                  portalController.show();
                                }
                              },
                              onLongPress: () => _onItemLongPressSelected(item, index),
                              onSecondaryTap: () => _onItemSecondaryTapSelected(item, index),
                              animationController: _animationController!,
                            ),
                          ),
                          if (widget.controller.extended && widget.controller.selectedIndex == index)
                            ...item.subItems.map((subItem) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: t.subDecoration,
                                  height: 40,
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: subItem.onTap,
                                    child: Center(
                                      child: Text(
                                        subItem.title,
                                        style: TextStyle(color: t.iconTheme?.color),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ],
                      );
                    },
                  ),
                ),
                widget.footerDivider ?? const SizedBox(),
                widget.footerBuilder?.call(context, widget.controller.extended) ?? const SizedBox(),
                if (widget.footerItems.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      itemCount: widget.footerItems.length,
                      separatorBuilder: widget.separatorBuilder ?? (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = widget.footerItems.reversed.toList()[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SidebarCell(
                              item: item,
                              theme: t,
                              animationController: _animationController!,
                              extended: widget.controller.extended,
                              selected: widget.controller.selectedIndex ==
                                  widget.items.length + widget.footerItems.length - index - 1,
                              onTap: () {
                                _onFooterItemSelected(item, index);

                                // Toggle isSelected state for each subItem
                                setState(() {
                                  for (var subItem in item.subItems) {
                                    subItem.isSelected = !(subItem.isSelected ?? false);
                                  }
                                });
                              },
                              onLongPress: () => _onFooterItemLongPressSelected(item, index),
                              onSecondaryTap: () => _onFooterItemSecondaryTapSelected(item, index),
                            ),
                            // Show subItems only if isSelected is true, with AnimatedContainer and custom decoration
                            ...item.subItems.where((subItem) => subItem.isSelected == true).map((subItem) {
                              return AnimatedContainer(
                                duration: widget.animationDuration,
                                decoration: t.subDecoration,
                                child: GestureDetector(
                                  onTap: subItem.onTap,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                                    child: Text(
                                      subItem.title,
                                      style: TextStyle(color: t.iconTheme?.color),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                if (widget.showToggleButton)
                  _buildToggleButton(t, widget.collapseIcon, widget.extendIcon),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onFooterItemSelected(SidebarMenuItem item, int index) {
    item.onTap?.call();
    if (item.selectable) {
      widget.controller.selectIndex(
          widget.items.length + widget.footerItems.length - index - 1);
    }
  }

  void _onFooterItemLongPressSelected(SidebarMenuItem item, int index) {
    item.onLongPress?.call();
  }

  void _onFooterItemSecondaryTapSelected(SidebarMenuItem item, int index) {
    item.onSecondaryTap?.call();
  }

  void _onItemSelected(SidebarMenuItem item, int index) {
    item.onTap?.call();
    if (item.selectable) {
      widget.controller.selectIndex(index);
    }
  }

  void _onItemLongPressSelected(SidebarMenuItem item, int index) {
    item.onLongPress?.call();
  }

  void _onItemSecondaryTapSelected(SidebarMenuItem item, int index) {
    item.onSecondaryTap?.call();
  }

  Widget _buildToggleButton(SideBarTheme sidebarXTheme,
      IconData collapseIcon,
      IconData extendIcon,) {
    final buildedToggleButton =
    widget.toggleButtonBuilder?.call(context, widget.controller.extended);
    if (buildedToggleButton != null) {
      return buildedToggleButton;
    }

    return InkWell(
      key: const Key('sidebarx_toggle_button'),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        if (_animationController!.isAnimating) return;
        widget.controller.toggleExtended();

        if(!widget.controller.extended && widget.controller.selectedIndex != null) {
          portalController.show();
        } else {
          portalController.hide();
        }
      },
      child: Row(
        mainAxisAlignment: widget.controller.extended
            ? MainAxisAlignment.end
            : MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(
              widget.controller.extended ? collapseIcon : extendIcon,
              color: sidebarXTheme.iconTheme?.color,
              size: sidebarXTheme.iconTheme?.size,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}
