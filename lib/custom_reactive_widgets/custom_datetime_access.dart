import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

class CustomDateTimeValueAccessor
    extends ControlValueAccessor<DateTime, String> {
  final DateFormat format;

  /// Constructs an instance of the [DateTimeValueAccessor]
  ///
  /// Can optionally provide [format] argument.
  CustomDateTimeValueAccessor({required DateFormat format})
      : format = (format ?? DateFormat.yMMMd('en'));
  @override
  modelToViewValue(modelValue) {
    return modelValue == null ? '' : format.format(modelValue);
  }

  @override
  viewToModelValue(viewValue) {
    return (viewValue == null || viewValue.trim().isEmpty)
        ? null
        : DateTime.parse(viewValue);
  }
}
