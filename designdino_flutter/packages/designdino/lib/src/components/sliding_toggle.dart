import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesignDinoSlidingToggle extends StatefulWidget {
  const DesignDinoSlidingToggle({
    super.key,
    required this.iconStart,
    required this.iconEnd,
    this.onPressedStart,
    this.onPressedEnd,
    this.initialIndex = 0,
  }) : assert(
         initialIndex == 0 || initialIndex == 1,
         'initialIndex must be 0 or 1',
       );

  final Widget iconStart;
  final Widget iconEnd;
  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedEnd;
  final int initialIndex;

  @override
  State<DesignDinoSlidingToggle> createState() =>
      _DesignDinoSlidingToggleState();
}

class _DesignDinoSlidingToggleState extends State<DesignDinoSlidingToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _selectedIndex.toDouble(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    _controller.animateWith(
      SpringSimulation(
        const SpringDescription(mass: 0.5, stiffness: 100, damping: 15),
        _controller.value,
        _selectedIndex.toDouble(),
        0,
      ),
    );
    if (index == 0) {
      widget.onPressedStart?.call();
    } else {
      widget.onPressedEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final selectedColor = theme.colorScheme.primaryForeground;
    final unselectedColor = theme.colorScheme.primary.withValues(alpha: 0.5);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.muted,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final colorStart = Color.lerp(
                selectedColor,
                unselectedColor,
                _controller.value,
              );
              final colorEnd = Color.lerp(
                unselectedColor,
                selectedColor,
                _controller.value,
              );
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Transform.translate(
                    offset: Offset(_controller.value * 32, 0),
                    child: Container(
                      width: 28,
                      height: 30,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _IconToggle(
                        icon: widget.iconStart,
                        onTap: () => _onTap(0),
                        color: colorStart,
                      ),
                      const SizedBox(width: 4),
                      _IconToggle(
                        icon: widget.iconEnd,
                        onTap: () => _onTap(1),
                        color: colorEnd,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _IconToggle extends StatelessWidget {
  const _IconToggle({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  final Widget icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: IconTheme(
          data: IconThemeData(color: color),
          child: SizedBox.square(dimension: 20, child: icon),
        ),
      ),
    );
  }
} 