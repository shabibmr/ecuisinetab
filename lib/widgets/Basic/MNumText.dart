// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/extensions/string_extension.dart';

class MNumField extends StatefulWidget {
  const MNumField({
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.onSaved,
    this.initialText,
    this.onSubmitted,
    this.inputDecoration,
    this.textStyle,
    this.focusNode,
    this.obscureText = false,
    this.autoCorrect = false,
    this.autoFocus = false,
    this.keyboardType = TextInputType.number,
    this.textInputAction,
    this.controller,
    this.inputFormatters = const [],
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.textData,
    this.decimalPoints = 0,
    this.showSuffix = true,
    this.showBorder = true,
    this.showCursor = true,
    this.selectAllOnClick = false,
  });

  final String? hintText;
  final String? label;
  final String? initialText;
  final ValueChanged<num>? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onSaved;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool autoCorrect;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool readOnly;
  final String? textData;
  final int decimalPoints;
  final bool showSuffix;
  final bool showBorder;
  final bool showCursor;
  final bool selectAllOnClick;

  @override
  _MNumFieldState createState() => _MNumFieldState();
}

class _MNumFieldState extends State<MNumField> {
  late final TextEditingController controller;

  late final InputDecoration? inputDecoration;
  bool isEditing = false;
  @override
  void initState() {
    super.initState();

    // print('init State ${widget.label}');

    // controller = widget.controller ?? TextEditingController();

    // controller.text = widget.textData ?? '';

    widget.focusNode?.addListener(() {
      if (widget.focusNode!.hasFocus && isEditing == false) {
        isEditing = true;
        if (widget.selectAllOnClick) {
          print('Selecting All');
          controller.selection = TextSelection(
              baseOffset: 0, extentOffset: controller.text.length);
        }
      } else if (!widget.focusNode!.hasFocus && isEditing == true) {
        isEditing = false;
      }
      if (!widget.focusNode!.hasFocus) {
        // remove focus
        print('Lost Focus');
        widget.focusNode?.unfocus();
      }
    });
    controller =
        widget.controller ?? TextEditingController(text: widget.textData ?? '');
    inputDecoration = widget.inputDecoration ??
        InputDecoration(
          border: widget.showBorder ? null : InputBorder.none,
          label: Text(widget.label ?? ''),
          contentPadding: const EdgeInsets.all(4),
          fillColor: const Color.fromRGBO(0, 0, 0, .5),
          suffixIcon: widget.showSuffix
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    widget.onChanged!(0);
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ))
              : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    // controller.text = widget.textData ?? '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: widget.key,
        controller: controller,
        onSaved: (newValue) => widget.onSaved!(newValue ?? ''),
        // ..text = widget.textData ?? ''
        // ..selection = TextSelection.fromPosition(
        //     TextPosition(offset: controller.text.length)),
        onChanged: ((value) {
          // print('Change : $value');
          if (value.isEmpty) {
            widget.onChanged!(0);
          } else if (value.substring(value.length - 1) != '.' &&
              value.isNumeric()) {
            print('Updating');
            widget.onChanged!(double.tryParse(value)!);
          }
        }),
        showCursor: widget.showCursor,
        // onSubmitted: (value) => widget.onSubmitted!(value),
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        autofocus: widget.autoFocus,
        autocorrect: widget.autoCorrect,
        decoration: inputDecoration,
        style: widget.textStyle,
        inputFormatters: widget.inputFormatters ??
            ((widget.decimalPoints == 0)
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ]
                : <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, //RegExp(r'^\D+|(?<=\d),(?=\d)')),
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\D+|(?<=\d),(?=\d)'))
                  ]),
        obscureText: widget.obscureText,
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
      ),
    );
  }
}

class Debouncer {
  late final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
    this.action,
  });

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
