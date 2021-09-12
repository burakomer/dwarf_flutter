import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import '../widgets/components/generic_badge.dart';
import 'app_icons.dart';
import 'app_theme.dart';

class CupertinoAppTheme extends AppTheme {
  @override
  int get darkColorAccentValue => 24;
  @override
  int get lightColorAccentValue => 240;
  @override
  int get darkColorValue => 0;

  CupertinoAppTheme({
    required MaterialColor primaryColor,
  }) : super(
          primaryColor: primaryColor,
          icons: CupertinoAppIcons(),
          hasFAB: false,
          genericBadgeTheme: GenericBadgeThemeData(outlined: true),
        );

  @override
  Color getModeColor(Brightness brightness) {
    return brightness == Brightness.light ? Colors.white : Colors.black;
  }
  

  @override
  ThemeData getThemeData({
    required Brightness brightness,
  }) {
    final modeColor = getModeColor(brightness);
    final modeAccentColor = getModeAccentColor(brightness);
    // final barColor = modeColor;
    // final barColor = AppTheme.getDefaultModeColor(brightness);
    final barColor = brightness == Brightness.light ? modeColor : modeAccentColor;
    // final barColor = modeAccentColor;
    final barIconColor = primaryColor;
    final shadowColor = Colors.black38;

    // final borderSide = BorderSide(width: 1, color: modeColor.contrastingTextColor()!);
    final shapeBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    final superThemeData = super.getThemeData(brightness: brightness);
    return superThemeData.copyWith(
      dividerTheme: DividerThemeData(thickness: 0.3, color: modeColor.contrastingTextColor()!),
      appBarTheme: AppBarTheme(
        color: barColor,
        titleTextStyle: TextStyle(
          color: barColor.contrastingTextColor(),
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        elevation: 0,
        // shadowColor: shadowColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
        shape: Border(
          bottom: BorderSide(width: 0.3, color: modeColor.contrastingTextColor()!.withAlpha(50)),
        ),
      ),
      bottomNavigationBarTheme: superThemeData.bottomNavigationBarTheme.copyWith(
        backgroundColor: barColor,
        elevation: 0.0,
      ),
      cardTheme: CardTheme(
        color: modeAccentColor,
        elevation: 8.0,
        // elevation: 0.0,
        shape: shapeBorder,
        // shadowColor: shadowColor,
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
        color: barColor,
        elevation: 0.0,
      ),
      inputDecorationTheme: superThemeData.inputDecorationTheme.copyWith(
        border: superThemeData.inputDecorationTheme.border?.copyWith(
          borderSide: BorderSide.none,
          // borderRadius: BorderRadius.circular(0),
        ),
        filled: true,
        fillColor: modeAccentColor,
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
