import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_theme/my_theme.dart';

import '../buttons/buttons.dart';
import 'dialog_layout.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onTap;
  final String? message, buttonText;

  const SuccessDialog(
      {Key? key, required this.onTap, this.message, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogLayout(
      child: Padding(
        padding: kPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/animations/success.json'),
            const Gap(20),
            Text(
              message ?? 'Success',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(15),
            MyElevatedButton(
              text: buttonText ?? 'Close',
              // color: Colors.teal.shade300,
              onPressed: () async => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
