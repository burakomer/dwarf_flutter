import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppIcons {
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
}

class MaterialAppIcons extends AppIcons {
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
}

class CupertinoAppIcons extends AppIcons {
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
}
