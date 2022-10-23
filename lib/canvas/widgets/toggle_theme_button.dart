import 'package:flutter/material.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.brightness_6),
    );
  }
}
