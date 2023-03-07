import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class MyElevatedButton extends StatefulWidget {
  final Widget? child;
  final String? text;
  final Color? color;
  final bool isLoading;
  final bool isDisabled;
  final Future<void> Function()? onPressed;
  final EdgeInsets? padding;
  final double? width, height;
  const MyElevatedButton({
    Key? key,
    this.child,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.text,
    this.padding,
    this.color,
    this.height,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  bool isLoading = false;

  Future<void> Function()? get _getOnTap {
    if (widget.isDisabled || isLoading) return null;
    return widget.onPressed;
  }

  void setLoading(bool value) {
    if (!mounted) return;
    setState(() {
      isLoading = value;
    });
  }

  void onTap() async {
    if (widget.onPressed != null) {
      setLoading(true);
      await widget.onPressed!();
      setLoading(false);
    }
  }

  @override
  void initState() {
    isLoading = widget.isLoading;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyElevatedButton oldWidget) {
    final hasChange = widget.isLoading != oldWidget.isLoading;
    if (hasChange) {
      setLoading(widget.isLoading);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getOnTap,
      child: AnimatedContainer(
        duration: 200.milliseconds,
        alignment: Alignment.center,
        width: widget.width ?? context.mediaQuery.size.width,
        height: 50,
        decoration: BoxDecoration(
          // color: isLoading
          //     ? theme.disabledColor.withOpacity(0.10)
          //     : widget.color ?? theme.primaryColor,
          color: color(context),
          borderRadius: kBorderRadius,
        ),
        child: _getChild(),
      ),
    );
  }

  Widget _getChild() {
    if (isLoading) {
      return _showLoading();
    } else if (widget.child != null) {
      return widget.child!;
    } else {
      return _showText();
    }
  }

  Text _showText() {
    Color color = Colors.grey.shade900;
    if (widget.isDisabled) {
      color = Get.theme.disabledColor.withOpacity(0.40);
    }
    return Text(
      widget.text!,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
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

  Color color(BuildContext context) {
    if (widget.isDisabled) {
      return context.theme.disabledColor.withOpacity(0.10);
    } else if (isLoading) {
      // return widget.color ?? context.theme.primaryColor;
      return context.theme.disabledColor.withOpacity(0.10);
    } else {
      return widget.color ?? context.theme.primaryColor;
    }
  }
}
