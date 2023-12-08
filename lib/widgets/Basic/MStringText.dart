import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MTextField extends StatefulWidget {
  const MTextField({
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.initialText,
    this.onSubmitted,
    this.onTap,
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
    this.hideSuffixIcon = true,
  });

  final String? hintText;
  final String? label;
  final String? initialText;
  final ValueChanged<String>? onChanged;
  final void Function()? onTap;
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
  final bool hideSuffixIcon;

  @override
  _MTextFieldState createState() => _MTextFieldState();
}

class _MTextFieldState extends State<MTextField> {
  late final TextEditingController controller;

  late final InputDecoration? inputDecoration;
  @override
  void initState() {
    super.initState();

    print('init State ${widget.label}');

    controller = widget.controller ?? TextEditingController();

    controller.text = widget.textData ?? '';
    // controller =
    //     widget.controller ?? TextEditingController(text: widget.textData ?? '');
    inputDecoration = widget.inputDecoration ??
        InputDecoration(
          label: Text(widget.label ?? ''),
          contentPadding: const EdgeInsets.all(4),
          fillColor: const Color.fromRGBO(0, 0, 0, .5),
          suffixIcon: widget.hideSuffixIcon
              ? null
              : IconButton(
                  onPressed: () => widget.controller!.clear(),
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  )),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   Color.fromARGB(80, 255, 255, 255),
        //   Color.fromARGB(80, 80, 80, 80)
        // ])),

        child: TextField(
          key: widget.key,
          controller: controller, //!..text = widget.textData ?? '',
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
          onTap: widget.onTap,
          style: const TextStyle(height: 1.5),
        ),
      ),
    );
  }
}
