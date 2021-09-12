import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

import '../../theme/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottomBar;
  final List<Widget>? actions;
  final List<Widget>? bottomActions;
  final FloatingActionButton? floatingActionButton;

  final bool hasScaffold;

  const AppScaffold({
    Key? key,
    this.title = "",
    required this.body,
    this.bottomBar,
    this.actions,
    this.bottomActions,
    this.floatingActionButton,
  })  : hasScaffold = false,
        super(key: key);

  const AppScaffold.tab({
    Key? key,
    this.title = "",
    required this.body,
    this.bottomBar,
    this.actions,
    this.bottomActions,
    this.floatingActionButton,
  })  : hasScaffold = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasFAB = AppTheme.of(context).hasFAB;

    return Scaffold(
      appBar: _getAppBar(context, hasFAB),
      body: body,
      // body: _getBody(context, hasFAB),
      bottomNavigationBar: _getBottomNavigationBar(context),
      floatingActionButton: hasFAB ? floatingActionButton : null,
    );
  }

  Widget _getBody(BuildContext context, bool hasFAB) {
    final border = Theme.of(context).dividerTheme.thickness != null && Theme.of(context).dividerTheme.color != null
        ? Border(
            bottom: BorderSide(
              width: Theme.of(context).dividerTheme.thickness!,
              color: Theme.of(context).dividerTheme.color!.withAlpha(50),
            ),
          )
        : null;

    return NestedScrollView(
      // physics: RangeMaintainingScrollPhysics(),
      body: body,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        // SliverPersistentHeader(
        //   pinned: true,
        //   delegate: FlexibleHeaderDelegate(
        //     expandedHeight: kToolbarHeight * 1.5,
        //     collapsedHeight: kToolbarHeight / 1.5,
        //     leading: _getLeading(context),
        //     // backgroundColor: Colors.white,
        //     // expandedElevation: 0.0,
        //     collapsedElevation: 0.0,
        //     statusBarHeight: MediaQuery.of(context).padding.top,
        //     children: [
        //       FlexibleTextItem(
        //         text: title,
        //         expandedStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontSize: 28.0),
        //         collapsedStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
        //         expandedAlignment: Alignment.bottomLeft,
        //         collapsedAlignment: Alignment.center,
        //         // collapsedPadding: const EdgeInsets.all(4.0),
        //         collapsedPadding: EdgeInsets.zero,
        //         expandedPadding: const EdgeInsets.all(16.0),
        //       ),
        //     ],
        //   ),
        // ),
        SliverAppBar(
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            // titlePadding: EdgeInsets.zero,
            centerTitle: false,
            title: Text(
              title,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          shape: border != null ? border : null,
          actions: [
            ...actions != null ? actions! : [],
            ...!hasFAB && floatingActionButton != null
                ? [
                    floatingActionButton!,
                    // TextButton(
                    //   onPressed: floatingActionButton!.onPressed,
                    //   child: floatingActionButton!.child ?? SizedBox(),
                    // ),
                  ]
                : [],
          ],
          automaticallyImplyLeading: false,
          leading: _getLeading(context),
          pinned: true,
        ),
      ],
      // SliverList(delegate: SliverChildListDelegate([body])),
    );
  }

  Widget? _getLeading(BuildContext context) {
    return Navigator.of(context).canPop()
        ? IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.chevron_left_rounded),
          )
        : null;
  }

  PreferredSizeWidget? _getAppBar(BuildContext context, bool hasFAB) {
    final border = Theme.of(context).dividerTheme.thickness != null && Theme.of(context).dividerTheme.color != null
        ? Border(
            bottom: BorderSide(
              width: Theme.of(context).dividerTheme.thickness!,
              color: Theme.of(context).dividerTheme.color!.withAlpha(60),
            ),
          )
        : null;

    return AppBar(
      shape: border != null ? border : null,
      title: Text(
        title,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: [
        ...actions != null ? actions! : [],
        ...!hasFAB && floatingActionButton != null
            ? [
                floatingActionButton!,
                // TextButton(
                //   onPressed: floatingActionButton!.onPressed,
                //   child: floatingActionButton!.child ?? SizedBox(),
                // ),
              ]
            : [],
      ],
      automaticallyImplyLeading: false,
      leading: _getLeading(context),
    );
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
