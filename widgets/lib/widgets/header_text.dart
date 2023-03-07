import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double? fontSize;
  const HeaderText({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = context.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: fontSize,
    );
    return Text(
      text,
      style: style,
    );
  }
}
