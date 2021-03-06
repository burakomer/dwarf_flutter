import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../config/localization.dart';

void showSnackbar({
  required BuildContext context,
  required Widget content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: content),
  );
}

Future<T?> showTallBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext, ScrollController) builder,
}) async {
  final theme = Theme.of(context).bottomSheetTheme;
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.6,
        builder: (context, controller) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            child: builder(context, controller),
          );
        },
      );
    },
  );
}

Future<bool?> showBooleanDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? okayText,
  String? cancelText,
  bool elevatedOkayButton = false,
  bool elevatedCancelButton = true,
  bool tristate = false,
}) async {
  final okayTextStr = okayText ?? getStr(context, "okay");
  final cancelTextStr = cancelText ?? getStr(context, "cancel");

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: tristate,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                children: [
                  elevatedCancelButton
                      ? ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(cancelTextStr),
                        )
                      : TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(cancelTextStr),
                        ),
                  elevatedOkayButton
                      ? ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(okayTextStr),
                        )
                      : TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(okayTextStr),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return tristate ? result : result ?? false;
}

Future<Color?> showColorPickerDialog({
  required BuildContext context,
  Color? initialColor,
}) async {
  final result = await showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      Color? selectedColor = initialColor;
      return StatefulBuilder(
        builder: (context, setBuilderState) {
          return AlertDialog(
            title: Text(getStr(context, "pick_a_color")),
            contentPadding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
            content: MaterialColorPicker(
              shrinkWrap: true,
              selectedColor: selectedColor,
              onlyShadeSelection: true,
              onColorChange: (color) {
                Navigator.of(context).pop(color);
                // setBuilderState(() => selectedColor = color);
              },
            ),
            actions: [
              TextButton(
                child: Text(getStr(context, "cancel")),
                onPressed: () => Navigator.of(context).pop(null),
              ),
              // TextButton(
              //   child: Text("Select"),
              //   onPressed: () => Navigator.of(context).pop(selectedColor),
              // ),
            ],
          );
        },
      );
    },
  );

  return result as Color?;
}
