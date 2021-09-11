import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension WidgetListExtensions on List<Widget> {
  List<Widget> wrapWithFlexible({double space = 16.0, List<int>? flexList}) {
    if (this.length == 0) return this;
    flexList = []; // Overflow hatasi veriyor, responsive degil.
    //if (flexList == null) flexList = [];
    if (flexList.length < this.length) {
      var difference = this.length - flexList.length;
      for (var i = 0; i < difference; i++) {
        flexList.add(1);
      }
    }

    var list = this
        .map((w) {
          var flex = flexList![this.indexOf(w)];
          return [
            Flexible(
              child: w,
              flex: flex,
            ),
            SizedBox(
              width: space,
            )
          ];
        })
        .expand((pair) => pair)
        .toList();
    list.removeLast();
    return list;
  }

  List<Widget> wrapWithPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)]) {
    if (this.length == 0) return this;

    var list = this
        .map(
          (w) => Padding(
            padding: padding,
            child: w,
          ),
        )
        .toList();
    return list;
  }

  List<Widget> wrapWithAlign(Alignment alignment, {int skip = 0}) {
    if (this.length == 0) return this;
    var skipLeft = skip + 1;
    var list = this.map(
      (w) {
        if (--skipLeft > 0) return w;
        return Align(
          alignment: alignment,
          child: w,
        );
      },
    ).toList();
    return list;
  }

  List<DataCell> wrapWithDataCell() {
    if (this.length == 0) return [];
    return this.map((w) => DataCell(w)).toList();
  }

  List<DataColumn> wrapWithDataColumn() {
    if (this.length == 0) return [];
    return this.map((w) => DataColumn(label: w)).toList();
  }

  List<Widget> putInBetween(Widget? widget, {bool removeLast = true}) {
    if (widget == null || this.length == 0) return this;
    var list = this.map((e) => [e, widget]).expand((pair) => pair).toList();
    if (removeLast) list.removeLast();
    return list;
  }
}

extension WidgetNListExtensions on List<Widget?> {
  List<Widget> removeNulls() {
    this.removeWhere((element) => element == null);
    return this.map((e) => e!).toList();
  }
}

extension WidgetNExtensions on Widget? {
  List<Widget> toList({List<Widget> ifNull = const []}) {
    return this != null ? [this!] : ifNull;
  }
}

extension StringExtensions on String {
  Color? colorFromHexCode({bool keepAlpha = false}) {
    var code = this;
    if (code == null || code.isEmpty) return null;

    if (code.contains("#")) {
      code = code.substring(1);
    }
    if (code.length < 6) {
      var addCount = 6 - code.length;
      for (var i = 0; i < addCount; i++) {
        code += "0";
      }
    }
    if (code.length == 8 && !keepAlpha) {
      code = code.substring(2);
      return Color(int.parse("0xFF$code"));
    } else {
      return Color(int.parse("0x$code"));
    }
  }
}

extension EdgeInsetsExtensions on EdgeInsets {
  EdgeInsets only({
    bool left: false,
    bool top: false,
    bool right: false,
    bool bottom: false,
  }) {
    return EdgeInsets.fromLTRB(
      left ? this.left : 0,
      top ? this.top : 0,
      right ? this.right : 0,
      bottom ? this.bottom : 0,
    );
  }
}

extension DoubleExtensions on double {
  int floorSafe() {
    return this.isInfinite || this.isNaN ? 0 : this.floor();
  }

  double fixedFraction(int fractionDigits) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }
}

extension NumberExtensions on num {
  String toStringWithOptions({
    bool emptyIfNegative = false,
    bool formatted = true,
    NumberFormat? numberFormat,
    String leading = "",
    String trailing = "",
  }) {
    final isEmpty = emptyIfNegative && this < 0;
    final format = numberFormat ?? NumberFormat("#,###.##", "en_US");

    final number = isEmpty ? "" : (formatted ? format.format(this) : this.toString());
    return isEmpty ? "" : "$leading$number$trailing";
  }
}

extension BoolExtensions on bool {
  int convertToInt({t: 1, f: -1}) => this ? t : f;
}

extension DateTimeExtensions on DateTime {
  static final _shortDateFormat = DateFormat('yMd');
  static final _mediumDateFormat = DateFormat('d MMM yyyy');
  static final _mediumDateFormatWithTime = DateFormat('d MMM yyyy HH:mm');
  static final _longDateFormat = DateFormat('d MMMM yyyy');
  static final _longDateFormatWithTime = DateFormat('d MMM yyyy HH:mm');

  static final _mediumMonthFormat = DateFormat('MMM yyyy');
  static final _longMonthFormat = DateFormat('MMMM yyyy');

  static final _shortDateFormatWithTime = DateFormat('dd MMMM HH:mm');
  static final _timeFormat = DateFormat('HH:mm');

  bool isSameDate(
    DateTime other, {
    bool year = true,
    bool month = true,
    bool day = true,
    bool hour = false,
    bool minute = false,
  }) {
    return (!year || (this.year == other.year)) && (!month || (this.month == other.month)) && (!day || (this.day == other.day)) && (!hour || (this.hour == other.hour)) && (!minute || (this.minute == other.minute));
  }

  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(this);
  DateTime get beginningOfDay => DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 1);
  DateTime get endOfDay => DateTime(this.year, this.month, this.day, 23, 59, 59, 999, 999);

  DateTime getDatePart({
    bool year = true,
    bool month = true,
    bool day = true,
  }) {
    return DateTime(year ? this.year : 2000, month ? this.month : 1, day ? this.day : 1);
  }

  DateTime mergeWithTime(TimeOfDay time) => DateTime(this.year, this.month, this.day, time.hour, time.minute);

  String get shortDateFormat => _shortDateFormat.format(this);
  String get mediumDateFormat => _mediumDateFormat.format(this);
  String get mediumDateFormatWithTime => _mediumDateFormatWithTime.format(this);
  String get longDateFormat => _longDateFormat.format(this);
  String get longDateFormatWithTime => _longDateFormatWithTime.format(this);

  String get mediumMonthFormat => _mediumMonthFormat.format(this);
  String get longMonthFormat => _longMonthFormat.format(this);

  String get timeFormat => _timeFormat.format(this);
}

extension WidgetExtensions on Widget {
  Widget wrapIf(bool condition, Widget Function(Widget) wrapper) {
    return condition ? wrapper(this) : this;
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  Map<K, V> append(Map<K, V> map) {
    this.addAll(map);
    return this;
  }
}

extension JsonMapExtensions on Map<String, dynamic> {
  int getInt(String key) {
    return this[key] ?? 0;
  }

  String getString(String key) {
    return this[key] ?? "";
  }

  double getDouble(String key) {
    return this[key] ?? 0.0;
  }

  DateTime getDateTime(String key) {
    if (this[key] == null) return DateTime(2000);
    return DateTime.parse(this[key]);
  }
}

extension ColorNExtensions on Color? {
  Color? contrastingTextColor({Color light: Colors.white, Color dark: Colors.black}) {
    if (this == null) return null;
    var brigtness = ThemeData.estimateBrightnessForColor(this!);
    return brigtness == Brightness.light ? dark : light;
    // return color.computeLuminance() > 0.6 ? Colors.black : Colors.white;
  }
}
