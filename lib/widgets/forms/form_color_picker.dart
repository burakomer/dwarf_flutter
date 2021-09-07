import 'package:dwarf_flutter/utils/extensions.dart';
import 'package:dwarf_flutter/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'generic_text_field.dart';

class FormColorPicker extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final void Function(Color) onSelectColor;

  Color? get initialColor => initialValue.colorFromHexCode();

  const FormColorPicker({
    Key? key,
    required this.labelText,
    required this.initialValue,
    required this.onSelectColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericTextField(
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
        margin: EdgeInsets.only(right: 12.0),
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
