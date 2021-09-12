import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/extensions.dart';
import '../widgets/components/generic_badge.dart';
import 'app_icons.dart';

class AppTheme {
  static AppTheme of(BuildContext context) {
    return context.read<AppTheme>();
  }

  static Color getCurrentModeColor(BuildContext context, {bool lightAccent = false, bool darkAccent = false}) {
    final brightness = Theme.of(context).brightness;
    if ((brightness == Brightness.light && lightAccent) || (brightness == Brightness.dark && darkAccent)) {
      return AppTheme.of(context).getModeAccentColor(Theme.of(context).brightness);
    } else {
      return AppTheme.of(context).getModeColor(Theme.of(context).brightness);
    }
  }

  int get darkColorValue => 17;
  int get lightColorValue => 255;
  Color get darkColor => Color.fromARGB(255, darkColorValue, darkColorValue, darkColorValue);
  Color get lightColor => Color.fromARGB(255, lightColorValue, lightColorValue, lightColorValue);

  int get darkColorAccentValue => 31;
  int get lightColorAccentValue => 200;
  Color get darkColorAccent => Color.fromARGB(255, darkColorAccentValue, darkColorAccentValue, darkColorAccentValue);
  Color get lightColorAccent => Color.fromARGB(255, lightColorAccentValue, lightColorAccentValue, lightColorAccentValue);

  final AppIcons icons;
  final MaterialColor primaryColor;

  final borderRadius = BorderRadius.circular(8.0);

  final bool hasFAB;
  final GenericBadgeThemeData? genericBadgeTheme;

  AppTheme({
    required this.primaryColor,
    this.icons = const MaterialAppIcons(),
    this.hasFAB = true,
    this.genericBadgeTheme,
  });

  Color getModeColor(Brightness brightness) {
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  Color getModeAccentColor(Brightness brightness) {
    return brightness == Brightness.light ? lightColorAccent : darkColorAccent;
  }

  ThemeData getThemeData({
    required Brightness brightness,
  }) {
    final barColor = primaryColor;
    final barIconColor = Colors.white;
    final shapeBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    final modeColor = getModeColor(brightness);

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
        color: brightness == Brightness.light ? primaryColor : darkColorAccent,
        titleTextStyle: TextStyle(
          color: barColor.contrastingTextColor(),
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        elevation: 2.0,
        // shadowColor: barColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: modeColor,
        elevation: 10.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: modeColor,
        selectedItemColor: primaryColor,
        elevation: 10.0,
        showUnselectedLabels: false,
        // selectedIconTheme: IconThemeData(size: 48.0)
        // type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        // border: InputBorder.none,
        //contentPadding: const EdgeInsets.only(left: 8.0),
        isDense: true,
      ),
      cardTheme: CardTheme(
        color: brightness == Brightness.light ? lightColor : darkColorAccent,
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
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: primaryColor,
          shape: shapeBorder,
          side: BorderSide(
            width: 1.5,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
