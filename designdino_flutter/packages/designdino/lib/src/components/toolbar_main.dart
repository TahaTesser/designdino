import 'dart:ui' show Brightness;
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesignDinoToolbar extends StatelessWidget {
  const DesignDinoToolbar({super.key, required this.items});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.maybeOf(context) ??
        ShadThemeData(
          brightness: Brightness.light,
          colorScheme: ShadColorScheme.fromName('neutral'),
        );
    return ShadTheme(
      data: theme,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ShadDecorator(
          decoration: ShadDecoration(
            color: theme.colorScheme.background,
            border: ShadBorder(radius: BorderRadius.circular(10)),
            shadows: ShadShadows.regular,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 32, maxWidth: 560),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: items,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 