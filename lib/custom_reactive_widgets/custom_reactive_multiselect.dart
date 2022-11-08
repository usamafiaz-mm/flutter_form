import 'package:flutter/material.dart';
import 'package:flutter_form/test.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../screens/FormScreen.dart';

class CustomReactiveMultiSelectPicker extends ReactiveFormField<List?, List?> {
  CustomReactiveMultiSelectPicker(
      {super.key,
      required FormControl<List> formControl,
      required List<String> animals})
      : super(
            formControl: formControl,
            builder: (ReactiveFormFieldState<List?, List?> field) {
              final items = animals
                  .map((animal) => MultiSelectItem<String>(animal, animal))
                  .toList();

              return TestMultiSelectDialogField(
                items: items,
                initialValue: formControl.value,

                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (values) {
                  if (formControl.invalid) return "Required";
                },

                title: const Text("Animals"),
                selectedColor: Colors.blue,
                // validator: ,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: (formControl.invalid && formControl.touched)
                        ? Colors.red
                        : Colors.blue,
                    width: 1,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Favorite Animals",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                // onSelectionChanged: (results) {
                //   field.didChange(results);
                // },
                onConfirm: (results) {
                  field.didChange(results.isEmpty ? null : results);
                },
                formControl: formControl,
              );
            });
}
