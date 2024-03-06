import 'package:custom_theme_provider/color_selector/providers/custom_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomColorsConsumer extends StatelessWidget {
  const CustomColorsConsumer({super.key, required this.builder});
  final Widget Function(BuildContext, CustomColorsProvider, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomColorsProvider>(
      builder: builder,
    );
  }
}
