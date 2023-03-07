import 'package:flutter/material.dart';
import 'package:text_fields/text_fields.dart';
import 'package:validators/validators.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  const PhoneTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: controller,
      textInputType: TextInputType.phone,
      prefixIcon: const Icon(Icons.phone),
      hintText: 'Mobile',
      validator: Validator.mobileNo,
    );
  }
}
