import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class Refreshable extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double edgeOffset;

  const Refreshable({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.edgeOffset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppTheme.getCurrentModeColor(context, darkAccent: true),
      onRefresh: onRefresh,
      child: child,
      edgeOffset: edgeOffset,
    );
  }
}
