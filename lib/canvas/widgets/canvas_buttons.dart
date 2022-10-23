import 'package:flutter/material.dart';

import '../../util/widgets/filled_tonal_button.dart';

/// Row of buttons with actions relevant to [CanvasView].
class CanvasButtons extends StatelessWidget {
  const CanvasButtons({
    Key? key,
    required this.onClearPressed,
    required this.onCheckPressed,
  }) : super(key: key);

  final void Function() onClearPressed;
  final void Function() onCheckPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: onClearPressed,
          icon: const Icon(Icons.clear),
          label: const Text('Clear'),
        ),
        FilledTonalButton(
          onPressed: onCheckPressed,
          icon: Icons.check,
          label: const Text('Check'),
        ),
      ],
    );
  }
}
