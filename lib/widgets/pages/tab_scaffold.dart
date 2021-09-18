import 'package:flutter/material.dart';

class TabScaffold {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  final Future<void> Function()? onRefresh;

  TabScaffold({
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    bool refreshable = false,
    Future<void> Function()? onRefresh,
  }) : onRefresh = onRefresh;
}
