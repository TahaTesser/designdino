import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';

class WidgetCanvasChild extends StatelessWidget {
  const WidgetCanvasChild({
    required Key key,
    required this.size,
    required this.offset,
    required this.deviceInfo,
    required this.showFrame,
    required this.child,
  }) : super(key: key);

  final Size size;
  final Offset offset;
  final DeviceInfo deviceInfo;
  final bool showFrame;
  final Widget child;

  Rect get rect => offset & size;

  WidgetCanvasChild copyWith({
    Size? size,
    Offset? offset,
    DeviceInfo? deviceInfo,
    bool? showFrame,
    Widget? child,
  }) {
    return WidgetCanvasChild(
      key: key!,
      size: size ?? this.size,
      offset: offset ?? this.offset,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      showFrame: showFrame ?? this.showFrame,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
