import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_actions.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A customizable InkWell widget that opens the MultiSelectDialog
// ignore: must_be_immutable
class TestMultiSelectDialogField<V> extends FormField<List<V>> {
  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Style the Container that makes up the field.
  final BoxDecoration? decoration;

  /// Set text that is displayed on the button.
  final Text? buttonText;

  /// Specify the button icon.
  final Icon? buttonIcon;

  /// The text at the top of the dialog.
  final Widget? title;

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Overrides the default MultiSelectChipDisplay attached to this field.
  /// If you want to remove it, use MultiSelectChipDisplay.none().
  final MultiSelectChipDisplay<V>? chipDisplay;

  /// The list of selected values before interaction.
  final List<V>? initialValue;

  /// Fires when confirm is tapped.
  final void Function(List<V>) onConfirm;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// Set the color of the space outside the BottomSheet.
  final Color? barrierColor;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? dialogHeight;

  /// Sets a fixed width on the dialog.
  final double? dialogWidth;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V)? colorator;

  /// Set the background color of the dialog.
  final Color? backgroundColor;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Replaces the deafult search icon when searchable is true.
  final Icon? searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the text that is typed into the search field.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<List<V>>? validator;
  final FormFieldSetter<List<V>>? onSaved;
  final GlobalKey<FormFieldState>? key;
  FormFieldState<List<V>>? state;
  final FormControl formControl;

  TestMultiSelectDialogField({
    required this.items,
    required this.onConfirm,
    required this.formControl,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.chipDisplay,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.barrierColor,
    this.selectedColor,
    this.searchHint,
    this.dialogHeight,
    this.dialogWidth,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.key,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue ?? [],
            builder: (FormFieldState<List<V>> state) {
              _MultiSelectDialogFieldView<V> field =
                  _MultiSelectDialogFieldView<V>(
                title: title,
                items: items,
                formControl: formControl,
                buttonText: buttonText,
                buttonIcon: buttonIcon,
                chipDisplay: chipDisplay,
                decoration: decoration,
                listType: listType,
                onConfirm: onConfirm,
                onSelectionChanged: onSelectionChanged,
                initialValue: initialValue,
                searchable: searchable,
                confirmText: confirmText,
                cancelText: cancelText,
                barrierColor: barrierColor,
                selectedColor: selectedColor,
                searchHint: searchHint,
                dialogHeight: dialogHeight,
                dialogWidth: dialogWidth,
                colorator: colorator,
                backgroundColor: backgroundColor,
                unselectedColor: unselectedColor,
                searchIcon: searchIcon,
                closeSearchIcon: closeSearchIcon,
                itemsTextStyle: itemsTextStyle,
                searchTextStyle: searchTextStyle,
                searchHintStyle: searchHintStyle,
                selectedItemsTextStyle: selectedItemsTextStyle,
                separateSelectedItems: separateSelectedItems,
                checkColor: checkColor,
              );
              return _MultiSelectDialogFieldView<V>._withState(field, state);
            });
}

// ignore: must_be_immutable
class _MultiSelectDialogFieldView<V> extends StatefulWidget {
  final MultiSelectListType? listType;
  final BoxDecoration? decoration;
  final Text? buttonText;
  final Icon? buttonIcon;
  final Widget? title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>)? onSelectionChanged;
  final MultiSelectChipDisplay<V>? chipDisplay;
  final List<V>? initialValue;
  final void Function(List<V>)? onConfirm;
  final bool? searchable;
  final Text? confirmText;
  final Text? cancelText;
  final Color? barrierColor;
  final Color? selectedColor;
  final double? dialogHeight;
  final double? dialogWidth;
  final String? searchHint;
  final Color Function(V)? colorator;
  final Color? backgroundColor;
  final Color? unselectedColor;
  final Icon? searchIcon;
  final Icon? closeSearchIcon;
  final TextStyle? itemsTextStyle;
  final TextStyle? selectedItemsTextStyle;
  final TextStyle? searchTextStyle;
  final TextStyle? searchHintStyle;
  final bool separateSelectedItems;
  final Color? checkColor;
  FormFieldState<List<V>>? state;
  final FormControl formControl;

  _MultiSelectDialogFieldView({
    required this.items,
    required this.formControl,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.chipDisplay,
    this.initialValue,
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.barrierColor,
    this.selectedColor,
    this.searchHint,
    this.dialogHeight,
    this.dialogWidth,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
  });

  /// This constructor allows a FormFieldState to be passed in. Called by MultiSelectDialogField.
  _MultiSelectDialogFieldView._withState(
      _MultiSelectDialogFieldView<V> field, FormFieldState<List<V>> state)
      : items = field.items,
        title = field.title,
        buttonText = field.buttonText,
        buttonIcon = field.buttonIcon,
        listType = field.listType,
        decoration = field.decoration,
        onSelectionChanged = field.onSelectionChanged,
        onConfirm = field.onConfirm,
        chipDisplay = field.chipDisplay,
        initialValue = field.initialValue,
        searchable = field.searchable,
        confirmText = field.confirmText,
        cancelText = field.cancelText,
        barrierColor = field.barrierColor,
        selectedColor = field.selectedColor,
        dialogHeight = field.dialogHeight,
        dialogWidth = field.dialogWidth,
        searchHint = field.searchHint,
        colorator = field.colorator,
        backgroundColor = field.backgroundColor,
        unselectedColor = field.unselectedColor,
        searchIcon = field.searchIcon,
        closeSearchIcon = field.closeSearchIcon,
        itemsTextStyle = field.itemsTextStyle,
        searchHintStyle = field.searchHintStyle,
        searchTextStyle = field.searchTextStyle,
        selectedItemsTextStyle = field.selectedItemsTextStyle,
        separateSelectedItems = field.separateSelectedItems,
        checkColor = field.checkColor,
        formControl = field.formControl,
        state = state;

  @override
  __MultiSelectDialogFieldViewState createState() =>
      __MultiSelectDialogFieldViewState<V>();
}

class __MultiSelectDialogFieldViewState<V>
    extends State<_MultiSelectDialogFieldView<V>> {
  List<V> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedItems.addAll(widget.initialValue!);
    }
  }

  Widget _buildInheritedChipDisplay() {
    List<MultiSelectItem<V>?> chipDisplayItems = [];
    chipDisplayItems = _selectedItems
        .map((e) =>
            widget.items.firstWhereOrNull((element) => e == element.value))
        .toList();
    chipDisplayItems.removeWhere((element) => element == null);
    if (widget.chipDisplay != null) {
      // if user has specified a chipDisplay, use its params
      if (widget.chipDisplay!.disabled!) {
        return Container();
      } else {
        return MultiSelectChipDisplay<V>(
          items: chipDisplayItems,
          colorator: widget.chipDisplay!.colorator ?? widget.colorator,
          onTap: (item) {
            List<V>? newValues;
            if (widget.chipDisplay!.onTap != null) {
              dynamic result = widget.chipDisplay!.onTap!(item);
              if (result is List<V>) newValues = result;
            }
            if (newValues != null) {
              _selectedItems = newValues;
              if (widget.state != null) {
                widget.state!.didChange(_selectedItems);
              }
            }
          },
          decoration: widget.chipDisplay!.decoration,
          chipColor: widget.chipDisplay!.chipColor ??
              ((widget.selectedColor != null &&
                      widget.selectedColor != Colors.transparent)
                  ? widget.selectedColor!.withOpacity(0.35)
                  : null),
          alignment: widget.chipDisplay!.alignment,
          textStyle: widget.chipDisplay!.textStyle,
          icon: widget.chipDisplay!.icon,
          shape: widget.chipDisplay!.shape,
          scroll: widget.chipDisplay!.scroll,
          scrollBar: widget.chipDisplay!.scrollBar,
          height: widget.chipDisplay!.height,
          chipWidth: widget.chipDisplay!.chipWidth,
        );
      }
    } else {
      // user didn't specify a chipDisplay, build the default
      return MultiSelectChipDisplay<V>(
        items: chipDisplayItems,
        colorator: widget.colorator,
        chipColor: (widget.selectedColor != null &&
                widget.selectedColor != Colors.transparent)
            ? widget.selectedColor!.withOpacity(0.35)
            : null,
      );
    }
  }

  /// Calls showDialog() and renders a MultiSelectDialog.
  _showDialog(BuildContext ctx) async {
    await showDialog(
      barrierColor: widget.barrierColor,
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<V>(
          checkColor: widget.checkColor,
          selectedItemsTextStyle: widget.selectedItemsTextStyle,
          searchHintStyle: widget.searchHintStyle,
          searchTextStyle: widget.searchTextStyle,
          itemsTextStyle: widget.itemsTextStyle,
          searchIcon: widget.searchIcon,
          closeSearchIcon: widget.closeSearchIcon,
          unselectedColor: widget.unselectedColor,
          backgroundColor: widget.backgroundColor,
          colorator: widget.colorator,
          searchHint: widget.searchHint,
          selectedColor: widget.selectedColor,
          onSelectionChanged: widget.onSelectionChanged,
          height: widget.dialogHeight,
          width: widget.dialogWidth,
          listType: widget.listType,
          items: widget.items,
          title: widget.title ?? const Text("Select"),
          initialValue: _selectedItems,
          searchable: widget.searchable ?? false,
          confirmText: widget.confirmText,
          cancelText: widget.cancelText,
          separateSelectedItems: widget.separateSelectedItems,
          formControl: widget.formControl,
          onConfirm: (selected) {
            if (widget.state != null) {
              widget.state!.didChange(selected);
            }
            _selectedItems = selected;
            if (widget.onConfirm != null) widget.onConfirm!(selected);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            decoration: widget.state != null
                ? widget.decoration ??
                    BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: widget.state != null && widget.state!.hasError
                              ? Colors.red.shade800.withOpacity(0.6)
                              : _selectedItems.isNotEmpty
                                  ? (widget.selectedColor != null &&
                                          widget.selectedColor !=
                                              Colors.transparent)
                                      ? widget.selectedColor!
                                      : Theme.of(context).primaryColor
                                  : Colors.black45,
                          width: _selectedItems.isNotEmpty
                              ? (widget.state != null && widget.state!.hasError)
                                  ? 1.4
                                  : 1.8
                              : 1.2,
                        ),
                      ),
                    )
                : widget.decoration,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.buttonText ?? const Text("Select"),
                widget.buttonIcon ?? const Icon(Icons.arrow_downward),
              ],
            ),
          ),
        ),
        _buildInheritedChipDisplay(),
        widget.state != null && widget.state!.hasError
            ? const SizedBox(height: 5)
            : Container(),
        widget.state != null && widget.state!.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      widget.state!.errorText!,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}

/// A dialog containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<T> extends StatefulWidget with MultiSelectActions<T> {
  /// List of items to select from.
  final List<MultiSelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;

  /// The text at the top of the dialog.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<T>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<T>)? onConfirm;

  /// Toggles search functionality. Default is false.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? height;

  /// Sets a fixed width on the dialog.
  final double? width;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(T)? colorator;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;
  final FormControl formControl;

  MultiSelectDialog({
    required this.items,
    required this.initialValue,
    required this.formControl,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.searchHint,
    this.height,
    this.width,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchHintStyle,
    this.searchTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<T>(items);
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  List<T> _selectedValues = [];
  bool _showSearch = false;
  List<MultiSelectItem<T>> _items;

  _MultiSelectDialogState(this._items);

  @override
  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValue);

    for (int i = 0; i < _items.length; i++) {
      if (_selectedValues.contains(_items[i].value)) {
        _items[i].selected = true;
      }
    }

    if (widget.separateSelectedItems) {
      _items = widget.separateSelected(_items);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
      ),
      child: CheckboxListTile(
        checkColor: widget.checkColor,
        value: item.selected,
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : widget.selectedColor,
        title: Text(
          item.label,
          style: item.selected
              ? widget.selectedItemsTextStyle
              : widget.itemsTextStyle,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked!);

            if (checked) {
              item.selected = true;
            } else {
              item.selected = false;
            }
            if (widget.separateSelectedItems) {
              _items = widget.separateSelected(_items);
            }
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<T> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        backgroundColor: widget.unselectedColor,
        selectedColor: widget.colorator?.call(item.value) ??
            widget.selectedColor ??
            Theme.of(context).primaryColor.withOpacity(0.35),
        label: Text(
          item.label,
          style: item.selected
              ? TextStyle(
                  color: widget.selectedItemsTextStyle?.color ??
                      widget.colorator?.call(item.value) ??
                      widget.selectedColor?.withOpacity(1) ??
                      Theme.of(context).primaryColor,
                  fontSize: widget.selectedItemsTextStyle?.fontSize,
                )
              : widget.itemsTextStyle,
        ),
        selected: item.selected,
        onSelected: (checked) {
          if (checked) {
            item.selected = true;
          } else {
            item.selected = false;
          }
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.formControl.markAsTouched();
        return Future.value(true);
      },
      child: AlertDialog(
        backgroundColor: widget.backgroundColor,
        title: widget.searchable == false
            ? widget.title ?? const Text("Select")
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _showSearch
                      ? Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              style: widget.searchTextStyle,
                              decoration: InputDecoration(
                                hintStyle: widget.searchHintStyle,
                                hintText: widget.searchHint ?? "Search",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.selectedColor ??
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                List<MultiSelectItem<T>> filteredList = [];
                                filteredList =
                                    widget.updateSearchQuery(val, widget.items);
                                setState(() {
                                  if (widget.separateSelectedItems) {
                                    _items =
                                        widget.separateSelected(filteredList);
                                  } else {
                                    _items = filteredList;
                                  }
                                });
                              },
                            ),
                          ),
                        )
                      : widget.title ?? Text("Select"),
                  IconButton(
                    icon: _showSearch
                        ? widget.closeSearchIcon ?? Icon(Icons.close)
                        : widget.searchIcon ?? Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _showSearch = !_showSearch;
                        if (!_showSearch) {
                          if (widget.separateSelectedItems) {
                            _items = widget.separateSelected(widget.items);
                          } else {
                            _items = widget.items;
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
        contentPadding: widget.listType == null ||
                widget.listType == MultiSelectListType.LIST
            ? EdgeInsets.only(top: 12.0)
            : EdgeInsets.all(20),
        content: Container(
          height: widget.height,
          width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
          child: widget.listType == null ||
                  widget.listType == MultiSelectListType.LIST
              ? ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(_items[index]);
                  },
                )
              : SingleChildScrollView(
                  child: Wrap(
                    children: _items.map(_buildChipItem).toList(),
                  ),
                ),
        ),
        actions: <Widget>[
          TextButton(
            child: widget.cancelText ??
                Text(
                  "CANCEL",
                  style: TextStyle(
                    color: (widget.selectedColor != null &&
                            widget.selectedColor != Colors.transparent)
                        ? widget.selectedColor!.withOpacity(1)
                        : Theme.of(context).primaryColor,
                  ),
                ),
            onPressed: () {
              widget.onCancelTap(context, widget.initialValue);
              widget.formControl.markAsTouched();
            },
          ),
          TextButton(
            child: widget.confirmText ??
                Text(
                  'OK',
                  style: TextStyle(
                    color: (widget.selectedColor != null &&
                            widget.selectedColor != Colors.transparent)
                        ? widget.selectedColor!.withOpacity(1)
                        : Theme.of(context).primaryColor,
                  ),
                ),
            onPressed: () {
              widget.onConfirmTap(context, _selectedValues, widget.onConfirm);
            },
          )
        ],
      ),
    );
  }
}
