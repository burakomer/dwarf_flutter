import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
import '../../utils/helpers.dart';
import 'generic_text_field.dart';

class FormColorPicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String initialValue;
  final void Function(Color) onSelectColor;

  Color? get initialColor => initialValue.colorFromHexCode();

  FormColorPicker({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.initialValue,
    required this.onSelectColor,
  }) : super(key: key) {
    controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GenericTextField(
      controller: controller,
      labelText: labelText,
      initialValue: initialValue,
      onSaved: (value) {},
      readOnly: true,
      onTap: () async {
        final color = await showColorPickerDialog(
          context: context,
          initialColor: initialColor,
        );
        if (color != null) {
          onSelectColor(color);
        }
      },
      prefixText: "#",
      trailing: Card(
        elevation: 2.0,
        color: initialColor,
        child: Container(
          width: 32.0,
          height: 32.0,
        ),
      ),
    );
  }
}
