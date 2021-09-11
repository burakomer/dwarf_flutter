import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/extensions.dart';
import '../widgets/components/generic_badge.dart';
import 'app_icons.dart';

class AppTheme {
  final AppIcons icons;
  final MaterialColor primaryColor;

  final borderRadius = BorderRadius.circular(8.0);

  final bool hasFAB;
  final GenericBadgeThemeData? genericBadgeTheme;

  static AppTheme of(BuildContext context) {
    return context.read<AppTheme>();
  }

  AppTheme({
    required this.primaryColor,
    required this.icons,
    this.hasFAB = true,
    this.genericBadgeTheme,
  });

  ThemeData getThemeData({
    required Color modeColor,
    required Brightness brightness,
  }) {
    final barColor = primaryColor;
    final barIconColor = Colors.white;
    final shapeBorder = RoundedRectangleBorder(borderRadius: borderRadius);

    return ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      primarySwatch: primaryColor,
      brightness: brightness,
      scaffoldBackgroundColor: modeColor,
      fontFamily: "Rubik",
      appBarTheme: AppBarTheme(
        color: barColor,
        titleTextStyle: TextStyle(
          color: barColor.contrastingTextColor(),
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        elevation: 2.0,
        shadowColor: barColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: modeColor,
        selectedItemColor: primaryColor,
        //elevation: 10.0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // border: OutlineInputBorder(
        //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        // ),
        border: InputBorder.none,
        //contentPadding: const EdgeInsets.only(left: 8.0),
        isDense: true,
      ),
      cardTheme: CardTheme(
        color: modeColor,
        elevation: 4.0,
        shape: shapeBorder,
        margin: EdgeInsets.zero,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: shapeBorder.copyWith(borderRadius: BorderRadius.circular(4.0)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: hasFAB ? primaryColor : Colors.transparent,
        foregroundColor: hasFAB ? primaryColor.contrastingTextColor() : primaryColor,
        splashColor: primaryColor,
        elevation: hasFAB ? null : 0.0,
      ),
      dividerTheme: DividerThemeData(
          //indent: 12.0,
          color: Colors.grey),
      bottomAppBarTheme: BottomAppBarTheme(
        color: modeColor,
        elevation: 1.0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: modeColor,
        modalBackgroundColor: modeColor,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: modeColor,
        shape: shapeBorder,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: modeColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(shapeBorder),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(shapeBorder),
        ),
      ),
    );
  }
}
