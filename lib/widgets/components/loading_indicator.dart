import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool center;

  const LoadingIndicator({
    Key? key,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return center ? Center(child: CircularProgressIndicator()) : CircularProgressIndicator();
  }
}
