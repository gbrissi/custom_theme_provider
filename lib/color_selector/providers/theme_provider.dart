import 'package:custom_theme_provider/color_selector/services/theme_initializer.dart';
import 'package:flutter/material.dart';
import '../services/shared_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  late Color _colorSeed;
  late Brightness _brightness;
  late bool _isSystemThemeSelected;
  late ColorScheme _systemColorScheme;

  Color get colorSeed => _colorSeed;
  bool get isDarkMode => _brightness == Brightness.dark ? true : false;
  bool get isSystemThemeSelected => _isSystemThemeSelected;

  ColorScheme get _cstmColorScheme => ColorScheme.fromSeed(
        seedColor: _colorSeed,
        brightness: _brightness,
      );

  ColorScheme get colorScheme =>
      _isSystemThemeSelected ? _systemColorScheme : _cstmColorScheme;

  ThemeProvider() {
    if (!ThemeInitializer.isLoad) {
      throw "Theme Initializer is not loaded, check the documentation for the correct implementation";
    }

    _colorSeed = ThemeInitializer.colorSeed;
    _brightness = ThemeInitializer.brightness;
    _isSystemThemeSelected = ThemeInitializer.isSystemThemeSelected;
    _systemColorScheme = ThemeInitializer.systemColorScheme;
  }

  Future<void> setColorSeed(Color seed) async {
    _colorSeed = seed;
    await SharedPrefs.setColorSeed(_colorSeed);
    notifyListeners();
  }

  Future<void> setIsSelectedSystemTheme(bool value) async {
    _isSystemThemeSelected = value;
    await SharedPrefs.setIsSelectedSystemTheme(value);
    notifyListeners();
  }

  Future<void> toggleIsSelectedSystemTheme() async {
    _isSystemThemeSelected = !_isSystemThemeSelected;
    await SharedPrefs.setIsSelectedSystemTheme(_isSystemThemeSelected);
    notifyListeners();
  }

  Future<void> setBoolBrightness(bool enableDarkMode) async {
    _brightness = enableDarkMode ? Brightness.dark : Brightness.light;
    await SharedPrefs.setBrightness(_brightness);
    notifyListeners();
  }

  Future<void> toggleBrightness() async {
    _brightness = !isDarkMode ? Brightness.dark : Brightness.light;
    await SharedPrefs.setBrightness(_brightness);
    notifyListeners();
  }

  Future<void> setBrightness(Brightness brightness) async {
    _brightness = brightness;
    await SharedPrefs.setBrightness(brightness);
    notifyListeners();
  }
}
