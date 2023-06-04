import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class PaginationButton extends StatelessWidget {
  final FutureVoidCallback onBack;
  final FutureVoidCallback onNext;
  final String? nextButtonText;
  const PaginationButton({
    super.key,
    required this.onBack,
    required this.onNext,
    this.nextButtonText,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: MyElevatedButton(
            text: 'Back',
            color: Colors.black,
            onPressed: onBack,
          ),
        ),
        SizedBox(width: size.width * 0.15),
        Expanded(
          child: MyElevatedButton(
            text: nextButtonText ?? 'Next',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
