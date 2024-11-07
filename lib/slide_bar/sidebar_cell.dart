import 'package:flutter/material.dart';
import 'package:widget_dictionary/slide_bar/sidebar_menuItem.dart';
import 'package:widget_dictionary/slide_bar/sidebar_theme.dart';

class SidebarCell extends StatefulWidget {
  const SidebarCell({
    super.key,
    required this.item,
    required this.extended,
    required this.selected,
    required this.theme,
    required this.onTap,
    required this.onLongPress,
    required this.onSecondaryTap,
    required this.animationController,
  });

  final bool extended;
  final bool selected;
  final SidebarMenuItem item;
  final SideBarTheme theme;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onSecondaryTap;
  final AnimationController animationController;

  @override
  State<SidebarCell> createState() => _SidebarCellState();
}

class _SidebarCellState extends State<SidebarCell> {
  late Animation<double> _animation;
  var _hovered = false;

  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = widget.theme;

    final iconTheme = widget.selected
        ? theme.selectedIconTheme
        : _hovered
        ? theme.hoverIconTheme ?? theme.selectedIconTheme
        : theme.iconTheme;
    final textStyle = widget.selected
        ? theme.selectedTextStyle
        : _hovered
        ? theme.hoverTextStyle
        : theme.textStyle;
    final decoration =
    (widget.selected ? theme.selectedItemDecoration : theme.itemDecoration);
    final margin =
    (widget.selected ? theme.selectedItemMargin : theme.itemMargin);
    final padding =
    (widget.selected ? theme.selectedItemPadding : theme.itemPadding);
    final textPadding =
    widget.selected ? theme.selectedItemTextPadding : theme.itemTextPadding;

    return MouseRegion(
      onEnter: (_) => _onEnteredCellZone(),
      onExit: (_) => _onExitCellZone(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onSecondaryTap: widget.onSecondaryTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: decoration?.copyWith(
            color: _hovered && !widget.selected ? theme.hoverColor : null,
          ),
          padding: padding ?? const EdgeInsets.all(8),
          margin: margin ?? const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: widget.extended
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  final value = ((1 - _animation.value) * 6).toInt();
                  if (value <= 0) {
                    return const SizedBox();
                  }
                  return Spacer(flex: value);
                },
              ),
              if (widget.item.iconBuilder != null)
                widget.item.iconBuilder!.call(widget.selected, _hovered)
              else if (widget.item.icon != null)
                _Icon(item: widget.item, iconTheme: iconTheme)
              // ignore: deprecated_member_use_from_same_package
              else if (widget.item.iconWidget != null)
                // ignore: deprecated_member_use_from_same_package
                  widget.item.iconWidget!,
              Flexible(
                flex: 6,
                child: FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: textPadding ?? EdgeInsets.zero,
                    child: Text(
                      widget.item.label ?? '',
                      style: textStyle,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEnteredCellZone() {
    setState(() => _hovered = true);
  }

  void _onExitCellZone() {
    setState(() => _hovered = false);
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    Key? key,
    required this.item,
    required this.iconTheme,
  }) : super(key: key);

  final SidebarMenuItem item;
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    return Icon(
      item.icon,
      color: iconTheme?.color,
      size: iconTheme?.size,
    );
  }
}
