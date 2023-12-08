import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MMultiLineTextField extends StatefulWidget {
  const MMultiLineTextField({
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.initialText,
    this.onSubmitted,
    this.inputDecoration,
    this.textStyle,
    this.focusNode,
    this.obscureText = false,
    this.autoCorrect = false,
    this.autoFocus = false,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.inputFormatters = const [],
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.textData,
  });

  final String? hintText;
  final String? label;
  final String? initialText;
  final ValueChanged<String>? onChanged;
  final void Function(String value)? onSubmitted;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool autoCorrect;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool readOnly;
  final String? textData;

  @override
  _MMultiLineTextFieldState createState() => _MMultiLineTextFieldState();
}

class _MMultiLineTextFieldState extends State<MMultiLineTextField> {
  late final TextEditingController controller;

  late final InputDecoration? inputDecoration;
  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    controller.text = widget.textData ?? '';

    inputDecoration = widget.inputDecoration ??
        InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
          label: Text(widget.label ?? ''),
          fillColor: const Color.fromRGBO(0, 0, 0, .5),
          // fillColor: Colors.black,
          // filled: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        key: widget.key,
        controller: controller, //..text = widget.textData ?? '',
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        autofocus: widget.autoFocus,
        autocorrect: widget.autoCorrect,
        decoration: inputDecoration,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
        minLines: 3,
        maxLines: 5,
      ),
    );
  }
}
