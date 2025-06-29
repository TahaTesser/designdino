import 'package:flutter/widgets.dart';

import 'canvas_chid.dart';

class CanvasController extends ChangeNotifier {
  CanvasController({required List<WidgetCanvasChild> children})
    : _children = children;

  List<WidgetCanvasChild> get children => _children;
  final List<WidgetCanvasChild> _children;

  late final transform = TransformationController();
  Matrix4 get matrix => transform.value;
  double scale = 1;
  Offset mousePosition = Offset.zero;

  bool get mouseDown => _mouseDown;
  bool _mouseDown = false;
  set mouseDown(bool value) {
    if (_mouseDown == value) return;
    _mouseDown = value;
    notifyListeners();
  }

  bool get canvasMoveEnabled => !mouseDown;

  void add(WidgetCanvasChild child) {
    children.add(child);
    notifyListeners();
  }

  void remove(Key key) {
    children.removeWhere((e) => e.key == key);
    notifyListeners();
  }
}
