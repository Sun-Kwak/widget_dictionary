import 'package:flutter/material.dart';

class SideBarTheme {
  const SideBarTheme({
    this.extendedWidth = 250,
    this.collapsedWidth = 70,
    this.height = double.infinity,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.decoration,
    this.iconTheme,
    this.selectedIconTheme,
    this.textStyle,
    this.selectedTextStyle,
    this.itemDecoration,
    this.selectedItemDecoration,
    this.subDecoration,
    this.itemMargin,
    this.selectedItemMargin,
    this.itemPadding,
    this.selectedItemPadding,
    this.itemTextPadding,
    this.selectedItemTextPadding,
    this.hoverColor,
    this.hoverTextStyle,
    this.hoverIconTheme,
  });
  final double extendedWidth;
  final double collapsedWidth;

  final double height;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final BoxDecoration? decoration;

  final BoxDecoration? subDecoration;

  final IconThemeData? iconTheme;

  final IconThemeData? selectedIconTheme;

  final IconThemeData? hoverIconTheme;

  final TextStyle? textStyle;

  final TextStyle? selectedTextStyle;

  final BoxDecoration? itemDecoration;

  final BoxDecoration? selectedItemDecoration;

  final EdgeInsets? itemMargin;

  final EdgeInsets? selectedItemMargin;

  final EdgeInsets? itemPadding;

  final EdgeInsets? selectedItemPadding;

  final EdgeInsets? itemTextPadding;

  final EdgeInsets? selectedItemTextPadding;

  final Color? hoverColor;


  final TextStyle? hoverTextStyle;

  /// Method to get default flutter theme settings
  SideBarTheme mergeFlutterTheme(BuildContext context) {
    final theme = Theme.of(context);
    final mergedTheme = SideBarTheme(
      extendedWidth: extendedWidth,
      collapsedWidth: collapsedWidth,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ?? BoxDecoration(color: theme.cardColor),
      subDecoration: subDecoration ?? BoxDecoration(color: theme.cardColor),
      iconTheme: iconTheme ?? theme.iconTheme,
      selectedIconTheme: selectedIconTheme ??
          theme.iconTheme.copyWith(color: theme.primaryColor),
      hoverIconTheme: hoverIconTheme ??theme.iconTheme.copyWith(color: theme.primaryColor),
      textStyle: textStyle ?? theme.textTheme.bodyMedium,
      selectedTextStyle: selectedTextStyle ??
          theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
      itemDecoration: itemDecoration,
      selectedItemDecoration: selectedItemDecoration,
      itemMargin: itemMargin,
      selectedItemMargin: selectedItemMargin,
      itemPadding: itemPadding,
      selectedItemPadding: selectedItemPadding,
      itemTextPadding: itemTextPadding,
      selectedItemTextPadding: selectedItemTextPadding,
      hoverColor: hoverColor ?? theme.hoverColor,
      hoverTextStyle: hoverTextStyle ??
          theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
    );
    return mergedTheme;
  }

  /// Merges two themes together
  SideBarTheme mergeWith(
      SideBarTheme theme,
      ) {
    return SideBarTheme(
      extendedWidth: extendedWidth,
      collapsedWidth: collapsedWidth,
      height: height,
      padding: padding,
      margin: margin,
      itemTextPadding: itemTextPadding ?? theme.itemTextPadding,
      selectedItemTextPadding:
      selectedItemTextPadding ?? theme.selectedItemTextPadding,
      decoration: decoration ?? theme.decoration,
      subDecoration: subDecoration ?? theme.subDecoration,
      iconTheme: iconTheme ?? theme.iconTheme,
      selectedIconTheme: selectedIconTheme ?? theme.selectedIconTheme,
      textStyle: textStyle ?? theme.textStyle,
      selectedTextStyle: selectedTextStyle ?? theme.selectedTextStyle,
      itemMargin: itemMargin ?? theme.itemMargin,
      selectedItemMargin: selectedItemMargin ?? theme.selectedItemMargin,
      itemPadding: itemPadding ?? theme.itemPadding,
      selectedItemPadding: selectedItemPadding ?? theme.selectedItemPadding,
      itemDecoration: itemDecoration ?? theme.itemDecoration,
      selectedItemDecoration:
      selectedItemDecoration ?? theme.selectedItemDecoration,
      hoverColor: hoverColor ?? theme.hoverColor,
      hoverTextStyle: hoverTextStyle ?? theme.hoverTextStyle,
      hoverIconTheme: hoverIconTheme ?? theme.hoverIconTheme,
    );
  }

  /// Defautl copyWith method
  SideBarTheme copyWith({
    double? extendedWidth,
    double? collapsedWidth,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxDecoration? decoration,
    BoxDecoration? subDecoration,
    IconThemeData? iconTheme,
    IconThemeData? selectedIconTheme,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    BoxDecoration? itemDecoration,
    BoxDecoration? selectedItemDecoration,
    EdgeInsets? itemMargin,
    EdgeInsets? selectedItemMargin,
    EdgeInsets? itemPadding,
    EdgeInsets? selectedItemPadding,
    EdgeInsets? itemTextPadding,
    EdgeInsets? selectedItemTextPadding,
    Color? hoverColor,
    TextStyle? hoverTextStyle,
    IconThemeData? hoverIconTheme,
  }) {
    return SideBarTheme(
      extendedWidth: extendedWidth ?? this.extendedWidth,
      collapsedWidth: collapsedWidth ?? this.collapsedWidth,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      subDecoration: subDecoration ?? this.subDecoration,
      iconTheme: iconTheme ?? this.iconTheme,
      selectedIconTheme: selectedIconTheme ?? this.selectedIconTheme,
      textStyle: textStyle ?? this.textStyle,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      itemDecoration: itemDecoration ?? this.itemDecoration,
      selectedItemDecoration:
      selectedItemDecoration ?? this.selectedItemDecoration,
      itemMargin: itemMargin ?? this.itemMargin,
      selectedItemMargin: selectedItemMargin ?? this.selectedItemMargin,
      itemPadding: itemPadding ?? this.itemPadding,
      selectedItemPadding: selectedItemPadding ?? this.selectedItemPadding,
      itemTextPadding: itemTextPadding ?? this.itemTextPadding,
      selectedItemTextPadding:
      selectedItemTextPadding ?? this.selectedItemTextPadding,
      hoverColor: hoverColor ?? this.hoverColor,
      hoverTextStyle: hoverTextStyle ?? this.hoverTextStyle,
      hoverIconTheme: hoverIconTheme ?? this.hoverIconTheme,
    );
  }
}
