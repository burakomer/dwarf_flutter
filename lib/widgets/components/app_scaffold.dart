import 'package:flutter/material.dart';

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
      appBar: AppBar(
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
      ),
      body: body,
      bottomNavigationBar: bottomBar ??
          (bottomActions != null
              ? Theme(
                  data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
                  child: BottomAppBar(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: bottomActions!,
                      ),
                    ),
                  ),
                )
              : null),
      floatingActionButton: hasFAB ? floatingActionButton : null,
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
}
