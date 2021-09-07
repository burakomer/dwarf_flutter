import 'package:badges/badges.dart';
import 'package:dwarf_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';

class GenericBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const GenericBadge({
    Key? key,
    required this.text,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
    this.elevation = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: padding,
      elevation: elevation,
      badgeColor: color ?? Theme.of(context).cardTheme.color ?? Colors.white,
      badgeContent: Container(
        child: Text(
          text,
          style: textStyle != null ? textStyle!.copyWith(color: color.contrastingTextColor()) : TextStyle(color: color.contrastingTextColor()),
        ),
      ),
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(8.0),
      toAnimate: false,
    );
  }
}
