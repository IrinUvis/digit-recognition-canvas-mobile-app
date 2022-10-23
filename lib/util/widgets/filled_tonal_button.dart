import 'package:flutter/material.dart';

/// Filled Tonal Button widget compliant with [Material 3 guidelines](https://m3.material.io/components/buttons/guidelines#07a1577b-aaf5-4824-a698-03526421058b).
/// Created manually, because the button has not been added to flutter yet.
class FilledTonalButton extends StatelessWidget {
  const FilledTonalButton({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final IconData? icon;
  final Text label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: onPressed,
        icon: Icon(icon),
        label: label,
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: onPressed,
        child: label,
      );
    }
  }
}
