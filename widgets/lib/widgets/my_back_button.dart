import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_theme/my_theme.dart';

import '../constants/constants.dart';

class MyBackButton extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  const MyBackButton({
    super.key,
    this.onBackPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: GestureDetector(
        onTap: onBackPressed ?? Get.back,
        child: Icon(
          Icons.arrow_back_ios,
          color: backgroundColor,
        ),
      ),
    );
  }
}
