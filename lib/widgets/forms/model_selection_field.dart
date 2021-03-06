import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'generic_text_field.dart';

class ModelSelectionField<M> extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int initialId;
  final String initialValue;
  final String routeName;
  final void Function(M) onSelected;
  final void Function()? onClear;
  final Icon Function(int)? iconMapper;
  final bool required;

  ModelSelectionField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.initialId,
    required this.initialValue,
    required this.routeName,
    required this.onSelected,
    this.onClear,
    this.iconMapper,
    this.required = false,
  }) : super(key: key) {
    controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    void onTap() async {
      final model = await Navigator.of(context).pushNamed(
        routeName,
        arguments: true,
      );
      if (model == null || !(model is M)) return;
      onSelected(model as M);
    }

    return GenericTextField(
      controller: controller,
      initialValue: initialValue,
      labelText: labelText,
      onSaved: (_) {},
      readOnly: true,
      required: required,
      leading: iconMapper == null
          ? null
          : initialId < 0
              ? null
              : IconButton(
                  icon: iconMapper!.call(initialId),
                  onPressed: null,
                ),
      trailing: Icon(AppTheme.of(context).icons.chevronRight),
      trailingOutside: initialValue.isNotEmpty && onClear != null
          ? IconButton(
              icon: Icon(AppTheme.of(context).icons.clear),
              onPressed: onClear,
            )
          : null,
      onTap: onTap,
    );
  }
}
