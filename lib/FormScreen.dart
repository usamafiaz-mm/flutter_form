import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form/DataModel.dart';
import 'package:flutter_form/DbHandler.dart';
import 'package:flutter_form/ReactiveImagePicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key? key, required this.form, this.id}) : super(key: key);
  final FormGroup form;
  int? id;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // FormArray get formArray =>
  //     widget.form.control('address') as FormArray<String>;

  // void addAddress() {
  //   if (formArray.controls.length <= 3)
  //     formArray.add(
  //       FormControl<String>(validators: [Validators.required]),
  //     );
  // }
  //
  // void removeAddress() {
  //   if (formArray.controls.length >= 3)
  //     formArray.remove(formArray.controls[formArray.controls.length - 1]);
  // }

  @override
  Widget build(BuildContext context) {
    widget.form.control("firstNumber").valueChanges.listen((event) {
      if (widget.form.control("secondNumber").value != null && event != null) {
        widget.form
            .control("resultNumber")
            .updateValue(widget.form.control("secondNumber").value + event);
      } else {
        widget.form.control("resultNumber").updateValue(null);
      }
    });
    widget.form.control("secondNumber").valueChanges.listen((event) {
      if (widget.form.control("firstNumber").value != null && event != null) {
        widget.form
            .control("resultNumber")
            .updateValue(widget.form.control("firstNumber").value + event);
      } else {
        widget.form.control("resultNumber").updateValue(null);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: ReactiveForm(
        formGroup: widget.form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ReactiveImagePicker(
                  formControlName:
                      widget.form.control("image") as FormControl<String>),
              ReactiveTextField(
                formControl: widget.form.control("name") as FormControl<String>,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl:
                    widget.form.control("email") as FormControl<String>,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validationMessages: {
                  'email': (error) => 'Must be a valid email',
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: widget.form.control("age") as FormControl<int>,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                  //I have set this so the input is only numbers/digits
                ],
                // validationMessages: {
                //   'required': (error) => 'Must be a number',
                // },
                decoration: const InputDecoration(
                  hintText: "Age",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveTextField(
                formControl: widget.form.control("cnic") as FormControl<String>,
                keyboardType: TextInputType.number,
                validationMessages: {
                  'required': (error) => 'The CNIC must not be empty',
                  'minLength': (error) => 'Not proper CNIC'
                },
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: '#####-#######-#',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.eager),
                  // FilteringTextInputFormatter.digitsOnly
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
                formControl:
                    widget.form.control("gender") as FormControl<String>,
              ),
              ReactiveRadioListTile(
                // toggleable: true,
                title: const Text("Female"),
                value: "female",
                formControl:
                    widget.form.control("gender") as FormControl<String>,
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveDropdownField(
                  hint: const Text("Select Designation"),
                  formControl:
                      widget.form.control("designation") as FormControl<int>,
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
                formControl: widget.form.control("designation"),
                builder: (context, control, child) {
                  if (control.value == 0) {
                    widget.form.control("university").markAsEnabled();
                    widget.form.control("company").markAsDisabled();
                  }
                  return Visibility(
                    visible: control.value == 0,
                    child: ReactiveTextField(
                      formControl: widget.form.control("university")
                          as FormControl<String>,
                      decoration: const InputDecoration(hintText: "University"),
                    ),
                  );
                },
              ),
              ReactiveValueListenableBuilder(
                formControl: widget.form.control("designation"),
                builder: (context, control, child) {
                  if (control.value == 1) {
                    widget.form.control("company").markAsEnabled();
                    widget.form.control("university").markAsDisabled();
                  }
                  return Visibility(
                    visible: control.value == 1,
                    child: ReactiveTextField(
                      formControl:
                          widget.form.control("company") as FormControl<String>,
                      decoration: const InputDecoration(hintText: "Company"),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ReactiveDatePicker(
                formControl: widget.form.control("dob") as FormControl<String>,
                firstDate: DateTime(1990, 1, 1),
                lastDate: DateTime.now(),
                builder: (context, picker, child) {
                  return ReactiveTextField(
                    formControl:
                        widget.form.control("dob") as FormControl<String>,
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
                      formControl: widget.form.control("firstNumber")
                          as FormControl<int>,
                      validationMessages: {
                        'required': (error) => 'Must be a number',
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                        //I have set this so the input is only numbers/digits
                      ],
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
                      formControl: widget.form.control("secondNumber")
                          as FormControl<int>,
                      validationMessages: {
                        'required': (error) => 'Must be a number',
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                        //I have set this so the input is only numbers/digits
                      ],
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
                formControl:
                    widget.form.control("resultNumber") as FormControl<int>,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Result", enabled: false),
              ),
              // ReactiveFormArray(
              //   formArray: formArray,
              //   builder: (context, formArray, child) {
              //     return Column(
              //       children: [
              //         for (int i = 0; i < formArray.controls.length; i++)
              //           Padding(
              //             padding: const EdgeInsets.only(top: 10),
              //             child: ReactiveTextField(
              //               formControl:
              //                   formArray.controls[i] as FormControl<String>,
              //               decoration: InputDecoration(
              //                   hintText: "Address Line ${i + 1}"),
              //             ),
              //           ),
              //       ],
              //     );
              //   },
              // ),
              ReactiveValueListenableBuilder(
                formControl: widget.form.control("addressButton"),
                builder: (context, control, child) {
                  return Visibility(
                    visible: control.value >= 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControl: widget.form.control("address1")
                              as FormControl<String>,
                          decoration:
                              const InputDecoration(hintText: "Address Line 1"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ReactiveValueListenableBuilder(
                formControl: widget.form.control("addressButton"),
                builder: (context, control, child) {
                  return Visibility(
                    visible: control.value >= 1,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControl: widget.form.control("address2")
                              as FormControl<String>,
                          decoration:
                              const InputDecoration(hintText: "Address Line 2"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ReactiveValueListenableBuilder(
                formControl: widget.form.control("addressButton"),
                builder: (context, control, child) {
                  if (control.value >= 2) {
                    widget.form.control("address3").markAsEnabled();
                  } else {
                    widget.form.control("address3").markAsDisabled();
                  }
                  return Visibility(
                    visible: control.value >= 2,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControl: widget.form.control("address3")
                              as FormControl<String>,
                          decoration:
                              const InputDecoration(hintText: "Address Line 3"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ReactiveValueListenableBuilder(
                formControl: widget.form.control("addressButton"),
                builder: (context, control, child) {
                  if (control.value >= 3) {
                    widget.form.control("address4").markAsEnabled();
                  } else {
                    widget.form.control("address4").markAsDisabled();
                  }
                  return Visibility(
                    visible: control.value >= 3,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControl: widget.form.control("address4")
                              as FormControl<String>,
                          decoration:
                              const InputDecoration(hintText: "Address Line 4"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ReactiveValueListenableBuilder(
                    formControl: widget.form.control("addressButton"),
                    builder: (BuildContext context,
                        AbstractControl<dynamic> control, Widget? child) {
                      return Visibility(
                        visible: control.value <= 2,
                        child: Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text("ADD"),
                            onPressed: () {
                              control.updateValue(control.value + 1);
                              // addAddress();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ReactiveValueListenableBuilder(
                    formControl: widget.form.control("addressButton"),
                    builder: (BuildContext context,
                        AbstractControl<dynamic> control, Widget? child) {
                      return Visibility(
                          visible: control.value >= 2,
                          child: Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Remove"),
                              onPressed: () {
                                control.updateValue(control.value - 1);
                                // removeAddress();
                              },
                            ),
                          ));
                    },
                  )
                ],
              ),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 20)),
                      onPressed: formGroup.valid
                          ? () {
                              debugPrint(widget.form.value.toString());
                              if (widget.id != null) {
                                DBHandler.updateData(
                                    widget.id!,
                                    DataModel.fromJson(
                                        {"formValue": widget.form.value}));

                                Fluttertoast.showToast(
                                    msg: "Successfully Updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.of(context).pop();
                              } else {
                                DBHandler.insertFormData(DataModel.fromJson(
                                    {"formValue": widget.form.value}));
                                Navigator.of(context).pop();
                              }
                            }
                          : null,
                      child: widget.id != null
                          ? const Text("Update")
                          : const Text("Save"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
