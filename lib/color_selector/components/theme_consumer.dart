import 'package:custom_theme_provider/color_selector/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeConsumer extends StatelessWidget {
  const ThemeConsumer({super.key, required this.builder});
  final Widget Function(BuildContext, ThemeProvider, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: builder,
    );
  }
}
