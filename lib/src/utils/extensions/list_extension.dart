import 'package:flutter/material.dart';

import '../../presentation/widgets/app_divider.dart';
import '../../presentation/widgets/separated_widgets.dart';

extension WidgetListExtension on List<Widget> {
  List<Widget> separateWith(
    BuildContext context, {
    required Widget separator,
    SeparateType separateType = SeparateType.between,
    SeparatorParent separatorParent = SeparatorParent.column,
  }) {
    final currentList = this;
    final listWithSeparator = <Widget>[];

    for (var i = 0; i < currentList.length; i++) {
      if (i == 0 && separateType == SeparateType.around) {
        listWithSeparator.add(separator);
      }
      listWithSeparator.add(currentList[i]);
      if (separator is AppDivider &&
          separateType != SeparateType.between &&
          i == currentList.length - 1) {
        final dividerMargin = separator.margin?.resolve(
          Directionality.of(context),
        );
        if (dividerMargin != null) {
          final AppDivider lastDivider;
          if (separatorParent == SeparatorParent.column) {
            lastDivider = AppDivider(
              margin: EdgeInsets.only(
                top: dividerMargin.top,
              ),
            );
          } else {
            lastDivider = AppDivider(
              margin: EdgeInsets.only(
                left: dividerMargin.left,
              ),
            );
          }
          listWithSeparator.add(lastDivider);
        } else {
          listWithSeparator.add(separator);
        }
      } else {
        if (separateType == SeparateType.between) {
          if (i != currentList.length - 1) {
            listWithSeparator.add(separator);
          }
        } else {
          listWithSeparator.add(separator);
        }
      }
    }

    return listWithSeparator;
  }
}
