import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormInstance {
  final _form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'image': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'age': FormControl<int>(validators: [Validators.required]),
    'cnic': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(15),
      Validators.minLength(15)
    ]),
    'gender': FormControl<String>(validators: [Validators.required]),
    "designation": FormControl<int>(validators: [Validators.required]),
    "university": FormControl<String>(),
    "company": FormControl<String>(validators: [Validators.required]),
    "dob": FormControl<String>(),
    "firstNumber": FormControl<int>(validators: [Validators.required]),
    "secondNumber": FormControl<int>(validators: [Validators.required]),
    "resultNumber": FormControl<int>(validators: [Validators.required]),
    "address": FormArray([
      FormControl<String>(validators: [Validators.required]),
      FormControl<String>(validators: [Validators.required]),
    ]),
    "fav": FormControl<List>(validators: [Validators.required]),
    "dt": FormControl<String>(validators: [Validators.required])
  });

  FormGroup getFormInstance({Map<String, Object?>? value}) {
    if (value != null) {
      final temp = _form.control("address") as FormArray;
      final list = value?["address"] as List;
      debugPrint(list.runtimeType.toString());
      temp.clear();
      for (int i = 0; i < list.length; i++) {
        final ctrl = FormControl<String>(validators: [Validators.required]);
        ctrl.patchValue(list[i]);
        temp.add(ctrl);
      }
      value.remove("address");
      _form.patchValue(value);
    }
    return _form;
  }
}
