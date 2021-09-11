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
    final shadowColor =  Colors.black26;

    // final borderSide = BorderSide(width: 1, color: modeColor.contrastingTextColor()!);
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
        elevation: 0.0,
        shadowColor: shadowColor,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: barIconColor),
        iconTheme: IconThemeData(color: barIconColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: modeColor,
        selectedItemColor: primaryColor,
        elevation: 7.0,
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
        elevation: 10.0,
        // elevation: 0.0,
        shape: shapeBorder,
        shadowColor: shadowColor,
        margin: EdgeInsets.zero,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: shapeBorder.copyWith(borderRadius: BorderRadius.circular(4.0)),
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
      dividerTheme: DividerThemeData(
          //indent: 12.0,
          color: Colors.grey),
      bottomAppBarTheme: BottomAppBarTheme(
        color: modeColor,
        elevation: 0.0,
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
          backgroundColor: MaterialStateProperty.all<Color>(modeColor),
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shadowColor: MaterialStateProperty.all<Color>(shadowColor),
          // elevation: MaterialStateProperty.all<double>(10.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(shapeBorder.copyWith(side:BorderSide.none)),
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
