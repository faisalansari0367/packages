import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final VoidCallback onTap;
  const AlreadyHaveAnAccount({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final recognizer = TapGestureRecognizer()..onTap = onTap;
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
            ),
            TextSpan(
              text: ' Login Now',
              recognizer: recognizer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.theme.primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
