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

  const FormColorPicker({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.initialValue,
    required this.onSelectColor,
  }) : super(key: key);

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
      trailing: Card(
        color: initialColor,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            width: 32.0,
            height: 32.0,
          ),
        ),
      ),
    );
  }
}
