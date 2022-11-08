import 'package:flutter_form/custom_reactive_widgets/custom_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveImagePicker extends ReactiveFormField<String?, String?> {
  ReactiveImagePicker({required FormControl<String> formControlName})
      : super(
            formControl: formControlName,
            builder: (ReactiveFormFieldState<String?, String?> field) {
              return CustomImagePicker(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.camera);
                  field.didChange(photo?.path);
                },
                path: field.value,
              );
            });

  @override
  ReactiveFormFieldState<String?, String?> createState() {
    return ReactiveFormFieldState<String?, String?>();
  }
}
