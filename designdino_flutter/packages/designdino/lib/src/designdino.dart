import 'package:designdino/src/canvas_mode/canvas_chid.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import 'canvas_mode/canvas_controller.dart';
import 'canvas_mode/canvas_delegate.dart';

import 'components/button_pair.dart';
import 'components/separator.dart';
import 'utils/view_mode.dart';

import 'components/toolbar.dart';
import 'layers/designdino_layer.dart';

class DesignDino extends StatefulWidget {
  const DesignDino({super.key, required this.layers});

  final List<DesignDinoLayer> layers;

  @override
  State<DesignDino> createState() => _DesignDinoState();
}

class _DesignDinoState extends State<DesignDino> {
  late final CanvasController _controller;
  static const Size _gridSize = Size.square(50);

  @override
  void initState() {
    super.initState();

    double xOffset = 0;
    _controller = CanvasController(
      children: [
        for (int i = 0; i < widget.layers.length; i++)
          () {
            final layer = widget.layers[i];
            final deviceInfo = switch (layer.config.layout) {
              DesignDinoLayout.phone => Devices.ios.iPhone16ProMax,
              DesignDinoLayout.tablet => Devices.ios.iPadPro11Inches,
              DesignDinoLayout.desktop => Devices.macOS.macBookPro,
            };
            final child = WidgetCanvasChild(
              size: deviceInfo.frameSize,
              key: UniqueKey(),
              offset: Offset(xOffset, 0),
              deviceInfo: deviceInfo,
              showFrame: layer.config.showFrame,
              child: layer.child,
            );
            xOffset +=
                (deviceInfo.frameSize.width) + 40; // 40px margin between frames
            return child;
          }(),
      ],
    );
    _controller.addListener(onUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (mounted) setState(() {});
  }

  Rect axisAlignedBoundingBox(Quad quad) {
    double xMin = quad.point0.x;
    double xMax = quad.point0.x;
    double yMin = quad.point0.y;
    double yMax = quad.point0.y;
    for (final Vector3 point in <Vector3>[
      quad.point1,
      quad.point2,
      quad.point3,
    ]) {
      if (point.x < xMin) {
        xMin = point.x;
      } else if (point.x > xMax) {
        xMax = point.x;
      }

      if (point.y < yMin) {
        yMin = point.y;
      } else if (point.y > yMax) {
        yMax = point.y;
      }
    }

    return Rect.fromLTRB(xMin, yMin, xMax, yMax);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: ShadTheme.of(context).colorScheme.background,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return InteractiveViewer.builder(
                transformationController: _controller.transform,
                panEnabled: _controller.canvasMoveEnabled,
                scaleEnabled: _controller.canvasMoveEnabled,
                onInteractionStart: (details) {
                  _controller.mousePosition = details.focalPoint;
                },
                onInteractionUpdate: (details) {
                  if (!_controller.mouseDown) {
                    _controller.scale = details.scale;
                  }
                  _controller.mousePosition = details.focalPoint;
                },
                onInteractionEnd: (details) {},
                minScale: 0.1,
                maxScale: 4,
                boundaryMargin: const EdgeInsets.all(double.infinity),
                builder: (context, viewport) {
                  return SizedBox(
                    width: 1,
                    height: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: GridBackgroundBuilder(
                            cellWidth: _gridSize.width,
                            cellHeight: _gridSize.height,
                            viewport: axisAlignedBoundingBox(viewport),
                          ),
                        ),
                        Positioned.fill(
                          child: CustomMultiChildLayout(
                            delegate: CanvasDelegate(controller: _controller),
                            children: _controller.children
                                .map(
                                  (e) => LayoutId(
                                    id: e,
                                    child: DeviceFrame(
                                      device: e.deviceInfo,
                                      screen: e.child,
                                      isFrameVisible: e.showFrame,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        DesignDinoToolbar(
          items: [
            DesignDinoButtonPair(
              onPressedEnd: () {},
              iconStart: Icons.arrow_back,
              iconEnd: Icons.arrow_forward,
            ),
            DesignDinoSeparator(),
            const Spacer(),
            DesignDinoSeparator(),
            ShadSelect<ViewMode>(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              minWidth: 60,
              initialValue: ViewMode.canvas,
              options: ViewMode.values
                  .map((e) => ShadOption(value: e, child: Text(e.name)))
                  .toList(),
              selectedOptionBuilder: (context, ViewMode value) =>
                  Text(value.name, textAlign: TextAlign.center),
              trailing: const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}

class GridBackgroundBuilder extends StatelessWidget {
  const GridBackgroundBuilder({
    super.key,
    required this.cellWidth,
    required this.cellHeight,
    required this.viewport,
  });

  final double cellWidth;
  final double cellHeight;
  final Rect viewport;

  @override
  Widget build(BuildContext context) {
    final int firstRow = (viewport.top / cellHeight).floor();
    final int lastRow = (viewport.bottom / cellHeight).ceil();
    final int firstCol = (viewport.left / cellWidth).floor();
    final int lastCol = (viewport.right / cellWidth).ceil();

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        for (int row = firstRow; row < lastRow; row++)
          for (int col = firstCol; col < lastCol; col++)
            Positioned(
              left: col * cellWidth,
              top: row * cellHeight,
              child: Container(
                height: cellHeight,
                width: cellWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
