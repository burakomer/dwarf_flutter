import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import '../widgets/components/generic_badge.dart';
import 'app_icons.dart';
import 'app_theme.dart';

class CupertinoAppTheme extends AppTheme {
  CupertinoAppTheme({
    required MaterialColor primaryColor,
  }) : super(
          primaryColor: primaryColor,
          icons: CupertinoAppIcons(),
          hasFAB: false,
          genericBadgeTheme: GenericBadgeThemeData(outlined: true),
        );

  @override
  ThemeData getThemeData({
    required Brightness brightness,
    Color? brightnessModeColor,
  }) {
    final modeColor = brightnessModeColor ?? AppTheme.getDefaultModeColor(brightness);
    final modeColorAccent = AppTheme.getModeAccentColor(brightness);
    // final barColor = modeColor;
    final barColor = AppTheme.getDefaultModeColor(brightness);
    final barIconColor = primaryColor;
    final shadowColor = Colors.black26;

    // final borderSide = BorderSide(width: 1, color: modeColor.contrastingTextColor()!);
    final shapeBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    final superThemeData = super.getThemeData(brightnessModeColor: modeColor, brightness: brightness);
    return superThemeData.copyWith(
      appBarTheme: AppBarTheme(
        color: barColor,
        titleTextStyle: TextStyle(
          color: barColor.contrastingTextColor(),
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        elevation: 0.7,
        // shadowColor: shadowColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
        shape: Border(
          bottom: BorderSide(width: 0.4, color: modeColor.contrastingTextColor()!.withAlpha(40)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: barColor,
        selectedItemColor: primaryColor,
        elevation: 10.0,
      ),
      cardTheme: CardTheme(
        color: barColor,
        elevation: 10.0,
        // elevation: 0.0,
        shape: shapeBorder,
        shadowColor: shadowColor,
        margin: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: hasFAB ? primaryColor : Colors.transparent,
        foregroundColor: hasFAB ? null : primaryColor,
        // splashColor: primaryColor,
        elevation: hasFAB ? null : 0.0,
        focusElevation: hasFAB ? null : 0.0,
        hoverElevation: hasFAB ? null : 0.0,
        disabledElevation: hasFAB ? null : 0.0,
        highlightElevation: hasFAB ? null : 0.0,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: modeColor,
        elevation: 0.0,
      ),
      inputDecorationTheme: superThemeData.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          // borderRadius: BorderRadius.circular(0),
        ),
        filled: true,
        fillColor: modeColorAccent,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      dialogTheme: superThemeData.dialogTheme.copyWith(
        backgroundColor: barColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all<Color>(modeColor),
          // overlayColor: MaterialStateProperty.all<Color>(primaryColor.withOpacity(0.2)),
          // foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          // shadowColor: MaterialStateProperty.all<Color>(shadowColor),
          elevation: MaterialStateProperty.all<double>(0.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(shapeBorder),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(shapeBorder.copyWith(side: BorderSide.none)),
        ),
      ),
    );
  }
}
