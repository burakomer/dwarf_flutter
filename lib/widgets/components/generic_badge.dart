import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/extensions.dart';

class GenericBadgeThemeData {
  final bool outlined;
  final double elevation;

  GenericBadgeThemeData({
    this.outlined = false,
    this.elevation = 4.0,
  });
}

class GenericBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double? elevation;
  final bool? outlined;

  const GenericBadge({
    Key? key,
    required this.text,
    this.outlined,
    this.color,
    this.backgroundColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context).genericBadgeTheme;

    final outlined = this.outlined ?? themeData?.outlined ?? false;
    final elevation = this.elevation ?? themeData?.elevation ?? 1.0;
    final backgroundColor = this.backgroundColor ?? Colors.transparent; //Theme.of(context).scaffoldBackgroundColor;

    return Card(
      shape: outlined
          ? RoundedRectangleBorder(
              borderRadius: AppTheme.of(context).borderRadius,
              side: BorderSide(width: 1.5, color: color ?? Theme.of(context).cardTheme.color.contrastingTextColor() ?? Colors.white),
            )
          : null,
      // borderSide: outlined ? BorderSide(width: 1.5, color: color ?? Theme.of(context).cardTheme.color.contrastingTextColor() ?? Colors.white) : BorderSide.none,
      elevation: outlined ? 0.0 : elevation,
      color: outlined ? backgroundColor : color ?? Theme.of(context).cardTheme.color ?? Colors.white,
      child: Container(
        padding: padding,
        child: Text(
          text,
          style: textStyle != null
              ? textStyle!.copyWith(color: outlined ? color : color.contrastingTextColor())
              : TextStyle(
                  color: outlined ? color : color.contrastingTextColor(),
                ),
        ),
      ),
      // shape: BadgeShape.square,
    );
  }
}
