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

  List<Widget> putInBetween(Widget? widget) {
    if (widget == null || this.length == 0) return this;
    var list = this.map((e) => [e, widget]).expand((pair) => pair).toList();
    list.removeLast();
    return list;
  }
}

extension NullableWidgetListExtensions on List<Widget?> {
  List<Widget> removeNulls() {
    this.removeWhere((element) => element == null);
    return this.map((e) => e!).toList();
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
    }
    return Color(int.parse("0xFF$code"));
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
    NumberFormat? numberFormat,
    String leading = "",
    String trailing = "",
  }) {
    final format = numberFormat ?? NumberFormat("#,###.##", "en_US");
    return "$leading${format.format(this)}$trailing";
  }
}

extension BoolExtensions on bool {
  int convertToInt({t: 1, f: -1}) => this ? t : f;
}

extension DateTimeExtensions on DateTime {
  static final _shortDateFormat = DateFormat('yMd');
  static final _longDateFormat = DateFormat('dd MMMM yyyy');
  static final _longDateFormatWithTime = DateFormat('dd MMMM yyyy HH:mm');
  static final _justTimeDateFormat = DateFormat('HH:mm');

  static final _shortDateFormatWithTime = DateFormat('dd MMMM HH:mm');
  static final _timeFormat = DateFormat('HH:mm');

  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  DateTime get datePart {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime get beginningOfDay {
    return DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 1);
  }

  DateTime get endOfDay {
    return DateTime(this.year, this.month, this.day, 23, 59, 59, 999, 999);
  }

  String get longDateFormat => _longDateFormat.format(this);
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
