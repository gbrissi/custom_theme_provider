import 'package:custom_theme_provider/color_selector/components/color_option.dart';
import 'package:custom_theme_provider/color_selector/components/select_color_option.dart';
import 'package:custom_theme_provider/color_selector/components/theme_builder.dart';
import 'package:custom_theme_provider/color_selector/components/theme_consumer.dart';
import 'package:custom_theme_provider/color_selector/components/custom_colors_consumer.dart';
import 'package:custom_theme_provider/color_selector/services/theme_initializer.dart';
import 'package:custom_theme_provider/color_selector/utils/preset_colors.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeInitializer.load();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colorScheme) {
        return MaterialApp(
          home: const Home(),
          title: 'Theme Provider Demo',
          theme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Provider"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: ThemeConsumer(
              builder: (_, provider, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SwitchListTile(
                        title: const Text("Adaptative theme"),
                        subtitle: const Text(
                          "Replicates your system theme",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: provider.isSystemThemeSelected,
                        onChanged: provider.setIsSelectedSystemTheme,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: provider.isSystemThemeSelected,
                      child: Opacity(
                        opacity: provider.isSystemThemeSelected ? 0.5 : 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Define your theme settings",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SwitchListTile(
                                title: const Text("Dark mode"),
                                subtitle: const Text(
                                  "Activate dark mode UI",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                value: provider.isDarkMode,
                                onChanged: provider.setBoolBrightness,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      "Select your app color",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  CustomColorsConsumer(
                                    builder: (_, provider, __) {
                                      return Wrap(
                                        spacing: 4,
                                        runSpacing: 4,
                                        children: List.from(
                                          [
                                            ...PresetColors.colors.map(
                                              (e) => ColorOption(color: e),
                                            ),
                                            ...provider.customColors.map(
                                              (e) => ColorOption(
                                                color: e,
                                              ),
                                            ),
                                            const SelectColorOption()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
