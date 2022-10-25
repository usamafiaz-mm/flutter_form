import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

class CustomDateValueAccessor extends ControlValueAccessor<String, String> {
  final DateFormat format;

  /// Constructs an instance of the [DateTimeValueAccessor]
  ///
  /// Can optionally provide [format] argument.
  CustomDateValueAccessor({required DateFormat format})
      : format = (format ?? DateFormat.yMMMd('en'));
  @override
  modelToViewValue(modelValue) {
    return modelValue == null ? '' : format.format(DateTime.parse(modelValue));
  }

  @override
  viewToModelValue(viewValue) {
    return (viewValue == null || viewValue.trim().isEmpty) ? null : viewValue;
  }
}
