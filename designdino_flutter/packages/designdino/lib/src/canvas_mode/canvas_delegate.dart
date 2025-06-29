import 'package:flutter/rendering.dart';

import 'canvas_controller.dart';

class CanvasDelegate extends MultiChildLayoutDelegate {
  CanvasDelegate({required CanvasController controller})
    : _controller = controller;

  CanvasController get controller => _controller;
  final CanvasController _controller;

  Size backgroundSize = const Size(100000, 100000);
  late Offset backgroundOffset = Offset(
    -backgroundSize.width / 2,
    -backgroundSize.height / 2,
  );

  @override
  void performLayout(Size size) {
    for (final widget in controller.children) {
      layoutChild(widget, BoxConstraints.tight(widget.size));
      positionChild(widget, widget.offset);
    }
  }

  @override
  bool shouldRelayout(CanvasDelegate oldDelegate) => true;
}
