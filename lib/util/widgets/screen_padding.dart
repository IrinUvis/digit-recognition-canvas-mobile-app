import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).viewPadding.left,
        MediaQuery.of(context).viewPadding.top,
        MediaQuery.of(context).viewPadding.right,
        MediaQuery.of(context).viewPadding.bottom,
      ),
      child: child,
    );
  }
}
