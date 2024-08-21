import 'package:flutter/material.dart';
import 'package:permissions_preview_mode/src/utils/extensions/list_extension.dart';

enum SeparateType {
  toTheEnd,
  between,
  around,
}

enum SeparatorParent {
  column,
  row,
}

class SeparatedColumn extends StatelessWidget {
  const SeparatedColumn({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.padding,
    this.separator,
    this.separateType = SeparateType.between,
    this.children = const [],
  });
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Widget? separator;
  final SeparateType separateType;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: (children.isNotEmpty && separator != null)
            ? children.separateWith(
                context,
                separator: separator!,
                separateType: separateType,
              )
            : children,
      ),
    );
  }
}

class SeparatedRow extends StatelessWidget {
  const SeparatedRow({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.padding,
    this.separator,
    this.separateType = SeparateType.between,
    this.children = const [],
  });
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  final SeparateType separateType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: (children.isNotEmpty && separator != null)
            ? children.separateWith(
                context,
                separator: separator!,
                separateType: separateType,
                separatorParent: SeparatorParent.row,
              )
            : children,
      ),
    );
  }
}
