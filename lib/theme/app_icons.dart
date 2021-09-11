import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppIcons {
  const AppIcons() : super();

  IconData get pieChart;
  IconData get receiptLong;
  IconData get settings;
  IconData get calendar;
  IconData get calendarToday;
  IconData get save;
  IconData get delete;
  IconData get add;
  IconData get category;
  IconData get share;
  IconData get clear;
  IconData get chevronLeft;
  IconData get chevronRight;
}

class MaterialAppIcons extends AppIcons {
  const MaterialAppIcons() : super();

  IconData get pieChart => Icons.pie_chart_rounded;
  IconData get receiptLong => Icons.receipt_long_rounded;
  IconData get settings => Icons.settings_rounded;
  IconData get calendar => Icons.date_range_rounded;
  IconData get calendarToday => Icons.today_rounded;
  IconData get save => Icons.save_rounded;
  IconData get delete => Icons.delete_rounded;
  IconData get add => Icons.add_rounded;
  IconData get category => Icons.category_rounded;
  IconData get share => Icons.ios_share_rounded;
  IconData get clear => Icons.clear;
  IconData get chevronLeft => Icons.chevron_left_rounded;
  IconData get chevronRight => Icons.chevron_right_rounded;
}

class CupertinoAppIcons extends AppIcons {
  const CupertinoAppIcons() : super();

  IconData get pieChart => CupertinoIcons.chart_pie;
  IconData get receiptLong => CupertinoIcons.square_list;
  IconData get settings => CupertinoIcons.settings;
  IconData get calendar => CupertinoIcons.calendar;
  IconData get calendarToday => CupertinoIcons.calendar_today;
  IconData get save => CupertinoIcons.floppy_disk;
  IconData get delete => CupertinoIcons.delete;
  IconData get add => CupertinoIcons.add;
  IconData get category => CupertinoIcons.collections;
  IconData get share => CupertinoIcons.share;
  IconData get clear => CupertinoIcons.clear;
  IconData get chevronLeft => CupertinoIcons.chevron_back;
  IconData get chevronRight => CupertinoIcons.chevron_forward;
}
