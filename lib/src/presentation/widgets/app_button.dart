import 'package:flutter/material.dart';
import 'package:permissions_preview_mode/src/config/themes/app_colors.dart';
import 'package:permissions_preview_mode/src/config/themes/app_styles.dart';
import 'package:permissions_preview_mode/src/utils/extensions/color_extension.dart';
import 'package:permissions_preview_mode/src/utils/helpers/scale_util.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    this.side,
    required this.title,
    this.backgroundColor,
    this.style,
  });

  final VoidCallback? onPressed;
  final BorderSide? side;
  final String title;
  final Color? backgroundColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? AppColors.purple61;
    final isLight = backgroundColor.isLightColor;
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(double.maxFinite, 56.h),
        ),
        alignment: Alignment.center,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        elevation: const WidgetStatePropertyAll(0),
        overlayColor: WidgetStatePropertyAll(
          isLight
              ? Colors.black.withOpacity(0.05)
              : Colors.white.withOpacity(0.05),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.greyE9;
            } else {
              return backgroundColor;
            }
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.grey7A;
            } else {
              return style?.color ?? AppColors.white;
            }
          },
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: side ?? BorderSide.none,
          ),
        ),
      ),
      label: Text(
        title,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: style ?? AppStyles.s18w500,
      ),
    );
  }
}
