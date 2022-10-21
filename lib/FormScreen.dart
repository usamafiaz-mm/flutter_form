import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final form = FormGroup({
    'name': FormControl<String>(),
    'email': FormControl<String>(),
    'age': FormControl<int>(),
    'cnic': FormControl<String>(),
    'gender': FormControl<String>(),
    "designation": FormControl<int>(),
    "university": FormControl<String>(),
    "company": FormControl<String>(),
    "dob": FormControl<DateTime>(),
    "firstNumber": FormControl<int>(),
    "secondNumber": FormControl<int>(),
    "resultNumber": FormControl<int>(),
  });

  @override
  Widget build(BuildContext context) {
    form.control("name").valueChanges.listen((event) {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ReactiveTextField(
                formControl: form.control("name") as FormControl<String>,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: form.control("email") as FormControl<String>,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: form.control("age") as FormControl<int>,
                decoration: const InputDecoration(
                  hintText: "Age",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: form.control("cnic") as FormControl<String>,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: '#####-#######-#',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.eager)
                ],
                decoration: const InputDecoration(
                  hintText: "CNIC",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveRadioListTile(
                title: const Text("Male"),
                // toggleable: true,
                value: "male",
                formControl: form.control("gender") as FormControl<String>,
              ),
              ReactiveRadioListTile(
                // toggleable: true,
                title: const Text("Female"),
                value: "female",
                formControl: form.control("gender") as FormControl<String>,
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveDropdownField(
                  hint: const Text("Select Designation"),
                  formControl: form.control("designation") as FormControl<int>,
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Student'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Employee'),
                    ),
                  ]),
              const SizedBox(
                height: 10,
              ),
              ReactiveValueListenableBuilder(
                formControl: form.control("designation"),
                builder: (context, control, child) {
                  return Visibility(
                    visible: control.value == 0,
                    child: ReactiveTextField(
                      formControl:
                          form.control("university") as FormControl<String>,
                      decoration: const InputDecoration(hintText: "University"),
                    ),
                  );
                },
              ),
              ReactiveValueListenableBuilder(
                formControl: form.control("designation"),
                builder: (context, control, child) {
                  return Visibility(
                    visible: control.value == 1,
                    child: ReactiveTextField(
                      formControl:
                          form.control("company") as FormControl<String>,
                      decoration: const InputDecoration(hintText: "Company"),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveDatePicker(
                formControl: form.control("dob") as FormControl<DateTime>,
                firstDate: DateTime(1990, 1, 1),
                lastDate: DateTime.now(),
                builder: (context, picker, child) {
                  return ReactiveTextField(
                    formControl: form.control("dob") as FormControl<DateTime>,
                    readOnly: true,
                    onTap: (_) {
                      picker.showPicker();
                    },
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "Date of Birth",
                        enabled: false),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ReactiveTextField(
                      formControl:
                          form.control("firstNumber") as FormControl<int>,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "First Number",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ReactiveTextField(
                      formControl:
                          form.control("secondNumber") as FormControl<int>,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Second Number",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: form.control("resultNumber") as FormControl<int>,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Result",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
