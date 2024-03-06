import 'dart:ui';

import 'package:custom_theme_provider/color_selector/services/shared_prefs.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ThemeInitializer {
  static bool _isLoad = false;
  static bool get isLoad => _isLoad;

  static Color _colorSeed = Colors.indigoAccent;
  static Brightness _brightness = Brightness.light;
  static bool _isSystemThemeSelected = false;
  static late ColorScheme _systemColorScheme;

  static Color get colorSeed => _colorSeed;
  static Brightness get brightness => _brightness;
  static bool get isSystemThemeSelected => _isSystemThemeSelected;
  static ColorScheme get systemColorScheme => _systemColorScheme;

  static ColorScheme get _cstmColorScheme => ColorScheme.fromSeed(
        seedColor: colorSeed,
        brightness: brightness,
      );

  ColorScheme get colorScheme =>
      _isSystemThemeSelected ? _systemColorScheme : _cstmColorScheme;

  static Future<void> load() async {
    await SharedPrefs.initializePrefs();

    Brightness? storedBrightness = await SharedPrefs.getBrightness();
    _brightness = storedBrightness ?? _brightness;

    Color? storedColor = await SharedPrefs.getColorSeed();
    _colorSeed = storedColor ?? _colorSeed;

    bool isSystemThemeSelected = await SharedPrefs.getIsSelectedSystemTheme();
    _isSystemThemeSelected = isSystemThemeSelected;

    // Loading system theme.
    final Color? systemColor = await DynamicColorPlugin.getAccentColor();
    final Color colorSeed = systemColor ?? _cstmColorScheme.primary;
    final Brightness platformBrightness = window.platformBrightness;

    _systemColorScheme = ColorScheme.fromSeed(
      seedColor: colorSeed,
      brightness: platformBrightness,
    );

    _isLoad = true;
  }
}
