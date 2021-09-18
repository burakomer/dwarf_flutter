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

    return
        // currentTab.sliverMode ?
        AppScaffold.sliver(
      title: currentTab.title,
      body: tabs[_tabIndex].body,
      actions: currentTab.actions,
      bottomBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (value) => setState(() => _tabIndex = value),
        items: widget.tabButtons,
      ),
      navigationRail: NavigationRail(
        selectedIndex: _tabIndex,
        onDestinationSelected: (value) => setState(() => _tabIndex = value),
        labelType: NavigationRailLabelType.selected,
        destinations: widget.tabButtons
            .map(
              (e) => NavigationRailDestination(
                icon: e.icon,
                selectedIcon: e.activeIcon,
                label: Text(e.label ?? ""),
              ),
            )
            .toList(),
      ),
      floatingActionButton: currentTab.floatingActionButton,
      onRefresh: currentTab.onRefresh,
    )
        // : AppScaffold(
        //     title: currentTab.title,
        //     body: tabs[_tabIndex].body,
        //     actions: currentTab.actions,
        //     bottomBar: BottomNavigationBar(
        //       currentIndex: _tabIndex,
        //       onTap: (value) => setState(() => _tabIndex = value),
        //       items: widget.tabButtons,
        //     ),
        //     navigationRail: NavigationRail(
        //       selectedIndex: _tabIndex,
        //       onDestinationSelected: (value) => setState(() => _tabIndex = value),
        //       labelType: NavigationRailLabelType.selected,
        //       destinations: widget.tabButtons
        //           .map(
        //             (e) => NavigationRailDestination(
        //               icon: e.icon,
        //               selectedIcon: e.activeIcon,
        //               label: Text(e.label ?? ""),
        //             ),
        //           )
        //           .toList(),
        //     ),
        //     floatingActionButton: currentTab.floatingActionButton,
        //   );
        ;
  }
}
