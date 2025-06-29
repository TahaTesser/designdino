import 'package:designdino/designdino.dart';
import 'package:example/views/color_scheme_view.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:window_manager/window_manager.dart';

import 'views/cupertino_view.dart';
import 'views/nav_rail_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const DesignDinoExample());
}

class DesignDinoExample extends StatelessWidget {
  const DesignDinoExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
      ),
      themeMode: ThemeMode.light,
      home: DesignDino(
        layers: [
          DesignDinoLayer(
            config: const LayerConfig(
              name: 'Cupertino',
              layout: DesignDinoLayout.phone,
            ),
            child: const NavBarApp(),
          ),
          DesignDinoLayer(
            config: const LayerConfig(
              name: 'Navigation Rail',
              layout: DesignDinoLayout.tablet,
            ),
            child: const NavigationRailExampleApp(),
          ),
          DesignDinoLayer(
            config: const LayerConfig(
              name: 'Color Scheme',
              layout: DesignDinoLayout.desktop,
              showFrame: false,
            ),
            child: const ColorSchemeExample(),
          ),
        ],
      ),
    );
  }
}
