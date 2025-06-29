import 'canvas_controller.dart';
import 'package:flutter/widgets.dart';

class DesigndinoCanvas extends StatelessWidget {
  const DesigndinoCanvas({super.key, this.size, required this.controller});

  final Size? size;
  final CanvasController controller;

  @override
  Widget build(BuildContext context) {
    final canvas = Stack(
      children: [
        for (final child in controller.children)
          Positioned.fromRect(rect: child.rect, child: child.child),
      ],
    );

    return Center(
      child: Container(
        width: size?.width,
        height: size?.height,
        decoration: BoxDecoration(
          border: size != null ? Border.all() : null,
          color: const Color(0xFFFFFFFF),
        ),
        child: canvas,
      ),
    );
  }
}
