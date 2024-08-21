import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../helpers/scale_util.dart';

extension NavigationHelper on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get statusBarHeight => mediaQuery.viewPadding.top;

  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  double get scaleFactor {
    return ScaleUtil.getScaleFactor(context: this);
  }

  double scaleSize(double size) {
    return ScaleUtil.scaleSize(size, context: this);
  }

  double scaleHeight(double height) {
    return ScaleUtil.scaleHeight(height, context: this);
  }

  double scaleWidth(double width) {
    return ScaleUtil.scaleWidth(width, context: this);
  }

  String get path => GoRouter.of(this).routeInformationProvider.value.uri.path;
}
