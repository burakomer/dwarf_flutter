import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'generic_text_field.dart';

class AutocompleteTextField<T extends Object> extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String initialValue;
  final void Function(String)? onSaved;
  final void Function(T) onSelected;
  final String Function(T) textSelector;
  final Iterable<T> Function(TextEditingValue) optionsBuilder;
  final Widget Function(T) itemBuilder;
  final bool required;
  final BorderRadius? borderRadius;

  AutocompleteTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.initialValue,
    required this.onSaved,
    required this.onSelected,
    required this.textSelector,
    required this.optionsBuilder,
    required this.itemBuilder,
    this.required = false,
    this.borderRadius,
  }) : super(key: key){
    controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      textEditingController: controller,
      focusNode: focusNode,
      onSelected: onSelected,
      displayStringForOption: textSelector,
      optionsBuilder: optionsBuilder,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        // controller.text = initialValue;
        return GenericTextField(
          controller: controller,
          focusNode: focusNode,
          labelText: labelText,
          initialValue: initialValue,
          required: required,
          onSaved: onSaved,
          onChanged: onSaved, // ? Is this feasible?
        );
      },
      optionsViewBuilder: (context, onSelected, options) { // TODO: Fix this. It gives an error when dismissed with tapping outside.
        return Align(
          alignment: Alignment.topLeft,
          child: Card(
            elevation: 20.0,
            margin: const EdgeInsets.only(top: 12.0),
            shape: RoundedRectangleBorder(
              // side: BorderSide(width: 2, color: AppTheme.of(context).primaryColor),
              borderRadius: AppTheme.of(context).borderRadius,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 64.0,
                maxHeight: 250.0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero, //const EdgeInsets.all(8.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    borderRadius: borderRadius,
                    onTap: () {
                      onSelected(option);
                    },
                    child: itemBuilder(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
