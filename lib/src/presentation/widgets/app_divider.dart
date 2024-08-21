import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.margin,
    this.height,
    this.width,
    this.isVertical = false,
    this.color,
  });

  final bool isVertical;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? 1 : width,
      height: isVertical ? height : 1,
      margin: margin ?? EdgeInsets.zero,
      color: color ?? Colors.grey,
    );
  }
}
