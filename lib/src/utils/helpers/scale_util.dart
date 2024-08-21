import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:permissions_preview_mode/src/utils/extensions/context_extension.dart';

import '../constants/app_constants.dart';

extension ScaleUtilExtension on num {
  double get s => ScaleUtil.scaleSize(this);

  double get h => ScaleUtil.scaleHeight(this);

  double get w => ScaleUtil.scaleWidth(this);
}

abstract class ScaleUtil {
  static Size get physicalSize {
    final resolution =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
    final pixelRatio =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return Size(resolution.width / pixelRatio, resolution.height / pixelRatio);
  }

  static double getScreenHeight({BuildContext? context}) {
    return context == null ? physicalSize.height : context.screenHeight;
  }

  static double getScreenWidth({BuildContext? context}) {
    return context == null ? physicalSize.width : context.screenWidth;
  }

  static double getScaleFactor({BuildContext? context}) {
    final designWidth = AppConstants.designSize.width;

    final designHeight = AppConstants.designSize.height;

    final widthNew = getScreenWidth(context: context);

    final heightNew = getScreenHeight(context: context);

    final baseDiagonal =
        math.sqrt(math.pow(designWidth, 2) + math.pow(designHeight, 2));

    final currentDiagonal =
        math.sqrt(math.pow(widthNew, 2) + math.pow(heightNew, 2));

    final scaleFactor = currentDiagonal / baseDiagonal;

    return scaleFactor;
  }

  static double scaleSize(
    num size, {
    BuildContext? context,
  }) {
    final scaleFactor = getScaleFactor(context: context);
    return size * scaleFactor;
  }

  static double scaleHeight(
    num height, {
    BuildContext? context,
  }) {
    const designHeight = AppConstants.designHeight;
    final screenHeight = getScreenHeight(context: context);
    return screenHeight * height / designHeight;
  }

  static double scaleWidth(num width, {BuildContext? context}) {
    final screenWidth = getScreenWidth(context: context);
    return screenWidth * width / AppConstants.designWidth;
  }
}
