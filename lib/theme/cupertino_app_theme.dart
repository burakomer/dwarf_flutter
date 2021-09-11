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
    required Color modeColor,
    required Brightness brightness,
  }) {
    final barColor = modeColor;
    final barIconColor = primaryColor;
    final shadowColor = Colors.black26;

    // final borderSide = BorderSide(width: 1, color: modeColor.contrastingTextColor()!);
    final shapeBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    final superThemeData = super.getThemeData(modeColor: modeColor, brightness: brightness);
    return superThemeData.copyWith(
      appBarTheme: AppBarTheme(
        color: barColor,
        titleTextStyle: TextStyle(
          color: barColor.contrastingTextColor(),
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        elevation: 0.0,
        shadowColor: shadowColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: modeColor,
        selectedItemColor: primaryColor,
        elevation: 10.0,
      ),
      cardTheme: CardTheme(
        color: modeColor,
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
