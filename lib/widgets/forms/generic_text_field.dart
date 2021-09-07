import 'package:dwarf_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenericTextField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final void Function(String) onSaved;
  final TextEditingController? controller;
  final bool required;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function()? onTap;
  final int? maxLength;
  final String? prefixText;
  final String? suffixText;
  final Widget? leading;
  final Widget? trailing;
  final Widget? leadingOutside;
  final Widget? trailingOutside;

  GenericTextField({
    Key? key,
    required this.labelText,
    required this.initialValue,
    required this.onSaved,
    this.controller,
    this.required = false,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.maxLength,
    this.prefixText,
    this.suffixText,
    this.leading,
    this.trailing,
    this.leadingOutside,
    this.trailingOutside,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller != null) controller!.text = initialValue;
    return Row(
      children: [
        ...leadingOutside.toList(),
        Expanded(
          child: TextFormField(
            controller: controller,
            initialValue: controller != null ? null : initialValue,
            decoration: InputDecoration(
              counterText: "",
              labelText: labelText,
              prefixText: prefixText,
              suffixText: suffixText,
              prefixIcon: leading,
              suffixIcon: trailing,
              suffixIconConstraints: BoxConstraints(maxHeight: 48.0, maxWidth: 48.0),
            ),
            readOnly: readOnly,
            validator: _validateField,
            onSaved: (value) {
              onSaved(value ?? "");
            },
            onTap: onTap,
            maxLength: maxLength,
          ),
        ),
        ...trailingOutside.toList(),
      ],
    );
  }

  String? _validateField(String? value) {
    if (required) {
      if (value == null || value.isEmpty) return "Required";
    }

    if (keyboardType != null && value != null && value.isNotEmpty) {
      var inputType = keyboardType.toString();
      if (inputType == TextInputType.number.toString()) {
        if (int.tryParse(value) == null) {
          return "Enter a valid integer";
        } else if (int.parse(value) < 0) {
          return "Enter a positive integer";
        }
      } else if (inputType == TextInputType.numberWithOptions(decimal: true).toString()) {
        if (double.tryParse(value) == null) {
          return "Enter a valid number";
        } else if (double.parse(value) < 0) {
          return "Enter a positive number";
        }
      } else if (inputType == TextInputType.numberWithOptions(signed: true).toString()) {
        if (int.tryParse(value) == null) {
          return "Enter a valid integer";
        }
      } else if (inputType == TextInputType.numberWithOptions(signed: true, decimal: true).toString()) {
        if (double.tryParse(value) == null) {
          return "Enter a valid number";
        }
      } else if (inputType == TextInputType.emailAddress.toString()) {
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return "Invalid email";
        }
      }
    }

    return null;
  }
}
