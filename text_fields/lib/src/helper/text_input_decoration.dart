import 'package:flutter/material.dart';

class TextInputDecoration {
  static const inputRadius = 10.0;
  static final inputBorderRadius = BorderRadius.circular(inputRadius);
  static const inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(inputRadius)),
    borderSide: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
    // borderSide: BorderSide(color: Color(0xfff3f5fc)),
  );
  static InputDecoration recangularInputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      isDense: true,
      fillColor: const Color.fromARGB(255, 68, 68, 68),
      enabledBorder: inputBorder.copyWith(
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: TextStyle(color: Theme.of(context).primaryColor),
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      focusedBorder: inputBorder.copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      disabledBorder: inputBorder,
      border: inputBorder.copyWith(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static InputDecoration stadiumInputDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return InputDecoration(
      enabledBorder: inputBorder,
      focusedBorder: inputBorder.copyWith(
        borderSide: BorderSide(
          width: 2,
          color: theme.primaryColor,
        ),
      ),
      disabledBorder: inputBorder.copyWith(
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey.shade200,
        ),
      ),
      border: inputBorder,
    );
  }
}
