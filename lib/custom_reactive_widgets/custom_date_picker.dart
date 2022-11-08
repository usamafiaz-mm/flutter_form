import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

class CustomReactiveDateTimePicker extends ReactiveFormField<String, String> {
  CustomReactiveDateTimePicker(
      {super.key, required FormControl<String> formControl})
      : super(
            formControl: formControl,
            builder: (ReactiveFormFieldState<String?, String?> field) {
              return ReactiveTextField(
                formControl: formControl,
                readOnly: true,
                onTap: (val) async {
                  formControl.markAsTouched();
                  final date = await showDatePicker(
                      context: field.context,
                      initialDate: DateTime(1990, 1, 1),
                      firstDate: DateTime(1970, 1, 1),
                      lastDate: DateTime.now());
                  final time = await showTimePicker(
                      context: field.context, initialTime: TimeOfDay.now());
                  if (date != null && time != null) {
                    DateTime dateTime = _combine(date, time);
                    field.didChange(
                        DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime));
                  }
                },
              );
            });

  static DateTime _combine(DateTime? date, TimeOfDay? time) {
    DateTime dateTime = DateTime(0);

    if (date != null) {
      dateTime = dateTime.add(date.difference(dateTime));
    }

    if (time != null) {
      dateTime = dateTime.add(Duration(hours: time.hour, minutes: time.minute));
    }

    return dateTime;
  }
}
