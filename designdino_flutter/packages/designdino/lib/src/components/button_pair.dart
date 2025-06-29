import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesignDinoButtonPair extends StatelessWidget {
  const DesignDinoButtonPair({
    super.key,
    required this.iconStart,
    required this.iconEnd,
    this.onPressedStart,
    this.onPressedEnd,
  });

  final IconData iconStart;
  final IconData iconEnd;
  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        ShadIconButton.ghost(
          width: 32,
          height: 32,
          onPressed: onPressedStart,
          enabled: onPressedStart != null,

          icon: Icon(iconStart),
        ),
        ShadIconButton.ghost(
          width: 32,
          height: 32,
          onPressed: onPressedEnd,
          enabled: onPressedEnd != null,
          icon: Icon(iconEnd),
        ),
      ],
    );
  }
} 