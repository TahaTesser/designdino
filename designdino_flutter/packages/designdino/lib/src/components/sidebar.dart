import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:ui' show Brightness;

class DesignDinoSidebar extends StatelessWidget {
  const DesignDinoSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.maybeOf(context) ??
        ShadThemeData(
          brightness: Brightness.light,
          colorScheme: ShadColorScheme.fromName('neutral'),
        );
    return ShadTheme(
      data: theme,
      child: ShadDecorator(
        decoration: ShadDecoration(
          color: theme.colorScheme.background,
          border: ShadBorder(radius: BorderRadius.circular(10)),
          shadows: ShadShadows.regular,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
} 