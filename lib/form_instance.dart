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
    "address1": FormControl<String>(validators: [Validators.required]),
    "address2": FormControl<String>(validators: [Validators.required]),
    "address3": FormControl<String>(),
    "address4": FormControl<String>(),
    // "address": FormArray([
    //   FormControl<String>(validators: [Validators.required]),
    // ]),
    "addressButton": FormControl<int>(value: 1),
  });

  FormGroup getFormInstance({Map<String, Object?>? value}) {
    if (value != null) {
      //   (int i =0; i<(value["address"] as List).length-1; i++)
      // {
      // temp.add(      FormControl<String>(validators: [Validators.required]),
      // );
      // }
      _form.patchValue(value);
    }
    return _form;
  }
}
