// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_theme/my_theme.dart';
import 'package:widgets/widgets.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Color? color;
  final bool isLoading;
  final bool isDisabled;
  final FutureVoidCallback? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width, height;

  const MyElevatedButton({
    super.key,
    this.child,
    this.text,
    this.color,
    this.isLoading = false,
    this.isDisabled = false,
    this.onPressed,
    this.padding,
    this.height,
    this.width,
    this.margin,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return LoadingSwitcher(
      onPressed: _getOnTap,
      loadingChild: _loadingChild(context),
      child: _buttonLayout(context),
    );
  }

  _MyElevatedButtonLayout _buttonLayout(BuildContext context) {
    return _MyElevatedButtonLayout(
      color: getColor(context),
      padding: padding,
      width: width,
      height: height,
      margin: margin,
      child: _getChild(),
    );
  }

  _MyElevatedButtonLayout _loadingChild(BuildContext context) {
    return _MyElevatedButtonLayout(
      color: context.theme.disabledColor.withOpacity(0.10),
      padding: padding,
      width: width,
      height: height,
      margin: margin,
      child: _showLoading(),
    );
  }

  Future<void> Function()? get _getOnTap {
    if (isDisabled || isLoading) return null;
    return onPressed;
  }

  Widget _getChild() {
    if (isLoading) {
      return _showLoading();
    } else if (child != null) {
      return child!;
    } else {
      return _showText();
    }
  }

  Row _showLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
          ),
        )
      ],
    );
  }

  Color getColor(BuildContext context) {
    if (isDisabled || isLoading) {
      return context.theme.disabledColor.withOpacity(0.10);
    } else {
      return color ?? context.theme.primaryColor;
    }
  }

  Text _showText() {
    Color color = Colors.white;

    if (isDisabled) {
      color = Get.theme.disabledColor.withOpacity(0.40);
    }
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}

class _MyElevatedButtonLayout extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const _MyElevatedButtonLayout({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.margin,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: padding,
      margin: margin,
      duration: 200.milliseconds,
      alignment: Alignment.center,
      width: width ?? context.mediaQuery.size.width,
      height: height ?? 50,
      decoration: _decoration(),
      child: child,
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: color,
      borderRadius: kBorderRadius,
    );
  }
}
