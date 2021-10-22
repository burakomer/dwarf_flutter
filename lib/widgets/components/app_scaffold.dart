import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'refreshable.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget? body;
  final Widget? bottomBar;
  final Widget? navigationRail;
  final List<Widget>? actions;
  final List<Widget>? bottomActions;
  final Widget? floatingActionButton;

  final sliverMode;
  final Future<void> Function()? sliverOnRefresh;

  final bool hasScaffold;

  const AppScaffold({
    Key? key,
    this.title = "",
    required this.body,
    this.bottomBar,
    this.navigationRail,
    this.actions,
    this.bottomActions,
    this.floatingActionButton,
  })  : hasScaffold = false,
        sliverMode = false,
        sliverOnRefresh = null,
        super(key: key);

  const AppScaffold.sliver({
    Key? key,
    this.title = "",
    required this.body,
    this.bottomBar,
    this.navigationRail,
    this.actions,
    this.bottomActions,
    this.floatingActionButton,
    Future<void> Function()? onRefresh,
  })  : hasScaffold = true,
        sliverMode = true,
        sliverOnRefresh = onRefresh,
        super(key: key);

  bool isPhone(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return screenSize.width < 768;
  }

  bool shouldUseNavigationRail(BuildContext context) {
    return !isPhone(context) && navigationRail != null;
  }

  @override
  Widget build(BuildContext context) {
    final hasFAB = AppTheme.of(context).hasFAB;

    return Scaffold(
      appBar: sliverMode ? null : _getAppBar(context, hasFAB) as PreferredSizeWidget,
      body: _getBody(context),
      // body: _getBody(context, hasFAB),
      bottomNavigationBar: shouldUseNavigationRail(context) ? null : _getBottomNavigationBar(context),
      floatingActionButton: hasFAB ? floatingActionButton : null,
    );
  }

  Widget _getBody(BuildContext context) {
    if (!sliverMode) return body!;

    final hasFAB = AppTheme.of(context).hasFAB;
    var appBar = _getAppBar(context, hasFAB);

    var scrollView = CustomScrollView(
      slivers: [
        appBar,
        body!,
      ],
    );

    final appBarHeight = appBar is SliverAppBar
        ? appBar.toolbarHeight
        : appBar is AppBar
            ? appBar.preferredSize.height
            : 0.0;
    final refreshOffset = MediaQuery.of(context).padding.top + appBarHeight;
    final sliver = sliverOnRefresh != null
        ? Refreshable(
            child: scrollView,
            onRefresh: sliverOnRefresh!,
            edgeOffset: refreshOffset,
          )
        : scrollView;

    return shouldUseNavigationRail(context)
        ? Row(
            children: [
              _getNavigationRail(context) ?? SizedBox.shrink(),
              Expanded(child: sliver),
            ],
          )
        : sliver;
  }

  Widget? _getLeading(BuildContext context) {
    return Navigator.of(context).canPop()
        ? IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.chevron_left_rounded),
          )
        : null;
  }

  Widget _getAppBar(BuildContext context, bool hasFAB) {
    final border = Theme.of(context).dividerTheme.thickness != null && Theme.of(context).dividerTheme.color != null
        ? Border(
            bottom: BorderSide(
              width: Theme.of(context).dividerTheme.thickness!,
              color: Theme.of(context).dividerTheme.color!.withAlpha(60),
            ),
          )
        : null;

    final shape = border != null ? border : null;
    final title = Text(this.title, style: Theme.of(context).appBarTheme.titleTextStyle);
    final actions = [
      ...this.actions != null ? this.actions! : <Widget>[],
      ...!hasFAB && floatingActionButton != null ? [floatingActionButton!] : <Widget>[],
    ];
    final automaticallyImplyLeading = false;
    final leading = _getLeading(context);

    return sliverMode
        ? SliverAppBar(
            shape: shape,
            title: title,
            actions: actions,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading,
            pinned: true,
          )
        : AppBar(
            shape: shape,
            title: title,
            actions: actions,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading,
          );
  }

  Widget? _getNavigationRail(BuildContext context) {
    return navigationRail;
  }

  Widget? _getBottomNavigationBar(BuildContext context) {
    final border = Theme.of(context).dividerTheme.thickness != null && Theme.of(context).dividerTheme.color != null
        ? Border(
            top: BorderSide(
              width: Theme.of(context).dividerTheme.thickness!,
              color: Theme.of(context).dividerTheme.color!.withAlpha(60),
            ),
          )
        : null;

    final decoration = border != null ? ShapeDecoration(shape: border) : null;

    return bottomBar != null
        ? Container(
            decoration: decoration,
            child: bottomBar,
          )
        : (bottomActions != null
            ? Theme(
                data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
                child: Container(
                  decoration: decoration,
                  child: BottomAppBar(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: bottomActions!,
                      ),
                    ),
                  ),
                ),
              )
            : null);
  }
}
