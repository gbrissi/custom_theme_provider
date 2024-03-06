import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _brightnessKey = "brightness";
  static const String _colorSeedKey = "colorSeed";
  static const String _customColorsKey = "customColors";
  static const String _isSystemThemeSelectedKey = "isSystemThemeSelected";

  static Future<void> setColorSeed(Color colorSeed) async =>
      _prefs.setInt(_colorSeedKey, colorSeed.value);

  static Future<Color?> getColorSeed() async {
    Color? colorSeed;
    final int? value = _prefs.getInt(_colorSeedKey);

    if (value != null) {
      colorSeed = Color(value);
    }

    return colorSeed;
  }

  static Future<void> setBrightness(Brightness brightness) =>
      _prefs.setInt(_brightnessKey, brightness.index);

  static Future<Brightness?> getBrightness() async {
    Brightness? brightness;

    final int? index = _prefs.getInt(_brightnessKey);
    if (index != null) {
      brightness = Brightness.values[index];
    }

    return brightness;
  }

  static Future<void> setIsSelectedSystemTheme(bool value) =>
      _prefs.setBool(_isSystemThemeSelectedKey, value);

  static Future<bool> getIsSelectedSystemTheme() async =>
      _prefs.getBool(_isSystemThemeSelectedKey) ?? false;

  static Future<List<Color>?> getCustomColors() async {
    List<Color>? colors;
    final String? colorsVal = _prefs.getString(_customColorsKey);
    if (colorsVal != null) {
      final List<String> decodedColorsVal =
          jsonDecode(colorsVal).cast<String>();
      colors = decodedColorsVal.map((e) => Color(int.parse(e))).toList();
    }

    return colors;
  }

  static Future<void> addCustomColor(Color color) async {
    List<Color>? storedColors = await getCustomColors();
    storedColors = storedColors != null ? [...storedColors, color] : [color];
    final String stringifiedColors = jsonEncode(
      storedColors.map((e) => e.value.toString()).toList(),
    );

    await _prefs.setString(
      _customColorsKey,
      stringifiedColors,
    );
  }

  static Future<void> removeCustomColor(Color color) async {
    final String? colorsVal = _prefs.getString(_customColorsKey);
    if (colorsVal != null) {
      final List<String> decodedColorsVal =
          jsonDecode(colorsVal).cast<String>();
      final int colorIndex = decodedColorsVal.indexOf(color.value.toString());
      if (colorIndex != -1) decodedColorsVal.removeAt(colorIndex);
      final encodedColorsVal = jsonEncode(decodedColorsVal);

      await _prefs.setString(
        _customColorsKey,
        encodedColorsVal,
      );
    }
  }
}
