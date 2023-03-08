import 'package:flutter/material.dart';
import 'package:my_theme/my_theme.dart';

class MyAssetImage extends StatelessWidget {
  final String path;
  final double? width, height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const MyAssetImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? kBorderRadius,
      child: Image.asset(
        path,
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }
}
