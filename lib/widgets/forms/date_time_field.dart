import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/extensions.dart';
import 'generic_text_field.dart';

class DateTimeField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool required;
  final bool timePicker;
  final void Function(DateTime) onSelectDateTime;

  DateTimeField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onSelectDateTime,
    this.required = false,
    this.timePicker = false,
  }) : super(key: key) {
    controller.text = initialDate.mediumDateFormatWithTime;
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateTime.now();
    return GenericTextField(
      controller: controller,
      labelText: labelText,
      initialValue: initialDate.mediumDateFormatWithTime,
      required: required,
      readOnly: true,
      onSaved: (_) {},
      onTap: () => _onTap(context),
      // trailing: Icon(Icons.date_range_rounded),
      trailing: Icon(Icons.chevron_right_rounded),
      trailingOutside: !initialDate.isSameDate(dateTimeNow, hour: true, minute: true)
          ? IconButton(
              icon: Icon(AppTheme.of(context).icons.calendarToday),
              onPressed: () => onSelectDateTime(dateTimeNow),
            )
          : null,
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date == null) return;
    if (!timePicker) {
      onSelectDateTime(date);
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: initialDate.timeOfDay,
    );

    if (time == null) return;
    onSelectDateTime(date.mergeWithTime(time));
  }
}
