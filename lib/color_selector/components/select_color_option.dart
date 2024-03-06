import 'package:custom_theme_provider/color_selector/components/small_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/custom_color_provider.dart';
import '../providers/theme_provider.dart';

class SelectColorOption extends StatefulWidget {
  const SelectColorOption({super.key});

  @override
  State<SelectColorOption> createState() => _SelectColorOptionState();
}

class _SelectColorOptionState extends State<SelectColorOption> {
  late final _controller = context.read<ThemeProvider>();
  late final _customColorsController = context.read<CustomColorsProvider>();
  late Color _selectedColor = _controller.colorSeed;

  void setSelectedColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _openColorSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Theme.of(context).colorScheme.primary,
              onColorChanged: setSelectedColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                _controller.setColorSeed(_selectedColor);
                _customColorsController.addCustomColor(_selectedColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmallCircularButton(
      color: Theme.of(context).canvasColor,
      onTap: _openColorSelector,
      child: const Center(
        child: Icon(
          Icons.add,
          size: 14,
        ),
      ),
    );
  }
}
