import 'package:flutter/material.dart';

class MText extends StatelessWidget {
  const MText(
    this.text, {
    super.key,
    this.textStyle,
    this.textAlign,
    this.softWrap,
  });

  final String text;
  final TextStyle? textStyle;

  final TextAlign? textAlign;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}
