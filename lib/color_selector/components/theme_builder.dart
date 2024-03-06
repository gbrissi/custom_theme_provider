import 'package:custom_theme_provider/color_selector/providers/custom_color_provider.dart';
import 'package:custom_theme_provider/color_selector/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget Function(ColorScheme colorScheme) builder;

  const ThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CustomColorsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, provider, __) {
          return builder(
            provider.colorScheme,
          );
        },
      ),
    );
  }
}
