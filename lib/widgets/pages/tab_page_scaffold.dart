import 'package:flutter/material.dart';

import '../components/app_scaffold.dart';
import 'tab_scaffold.dart';

class TabPageScaffold extends StatefulWidget {
  final List<TabScaffold> Function(BuildContext) tabBuilder;
  final List<BottomNavigationBarItem> tabButtons;
  final int initialTab;

  TabPageScaffold({
    Key? key,
    required this.tabBuilder,
    required this.tabButtons,
    this.initialTab = 0,
  }) : super(key: key);

  @override
  _TabPageScaffoldState createState() => _TabPageScaffoldState(initialTab);
}

class _TabPageScaffoldState extends State<TabPageScaffold> {
  late int _tabIndex;

  _TabPageScaffoldState(this._tabIndex);

  @override
  Widget build(BuildContext context) {
    final tabs = widget.tabBuilder(context);
    final currentTab = tabs[_tabIndex];
    return AppScaffold(
      title: currentTab.title,
      body: IndexedStack(
        index: _tabIndex,
        children: tabs.map((e) => e.body).toList(),
      ),
      actions: currentTab.actions,
      bottomBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (value) => setState(() => _tabIndex = value),
        items: widget.tabButtons,
      ),
      floatingActionButton: currentTab.floatingActionButton,
    );
  }
}
