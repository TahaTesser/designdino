import 'package:flutter/widgets.dart';

import '../utils/view_mode.dart';

enum DesignDinoLayout { phone, tablet, desktop }

@immutable
class LayerConfig {
  final String? name;
  final ViewMode viewMode;
  final DesignDinoLayout layout;
  final bool showFrame;

  const LayerConfig({
    this.name,
    this.viewMode = ViewMode.canvas,
    required this.layout,
    this.showFrame = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayerConfig &&
          runtimeType == other.runtimeType &&
          viewMode == other.viewMode &&
          layout == other.layout &&
          showFrame == other.showFrame;

  @override
  int get hashCode =>
      name.hashCode ^ viewMode.hashCode ^ layout.hashCode ^ showFrame.hashCode;
}

@immutable
class DesignDinoLayer {
  final Widget child;
  final LayerConfig config;

  const DesignDinoLayer({required this.child, required this.config});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesignDinoLayer &&
          runtimeType == other.runtimeType &&
          child == other.child &&
          config == other.config;

  @override
  int get hashCode => child.hashCode ^ config.hashCode;
}
