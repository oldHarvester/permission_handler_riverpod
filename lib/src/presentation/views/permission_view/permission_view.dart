import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permissions_preview_mode/src/config/themes/app_colors.dart';
import 'package:permissions_preview_mode/src/utils/extensions/permission_extension.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../config/themes/app_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/separated_widgets.dart';
import 'provider/permissions_provider.dart';

class PermissionView extends ConsumerStatefulWidget {
  const PermissionView({
    super.key,
    required this.permission,
  });

  final Permission permission;

  @override
  ConsumerState<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends ConsumerState<PermissionView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (mounted) {
            ref.read(permissionsProvider.notifier).refreshPermissions();
          }
        },
      );
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permissionController = ref.watch(permissionsProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: SafeArea(
          child: SeparatedColumn(
            separator: const Gap(16),
            children: [
              Expanded(
                child: SeparatedColumn(
                  separator: const Gap(12),
                  children: [
                    if (widget.permission.title != null)
                      Expanded(
                        child: SvgPicture.asset(
                          widget.permission.image!,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          fit: BoxFit.contain,
                        ),
                      ),
                    Text(
                      widget.permission.title!,
                      textAlign: TextAlign.center,
                      style: AppStyles.s20w600.copyWith(
                        height: 32 / 20,
                      ),
                    ),
                    if (widget.permission.subtitle != null)
                      Text(
                        widget.permission.subtitle!,
                        textAlign: TextAlign.center,
                        style: AppStyles.s14w400.copyWith(
                          color: AppColors.grey81,
                          height: 22 / 14,
                        ),
                      ),
                  ],
                ),
              ),
              SeparatedColumn(
                separator: const Gap(12),
                children: [
                  AppButton(
                    title: LocaleKeys.allow.tr(),
                    onPressed: () {
                      permissionController.requestPermission(widget.permission);
                    },
                  ),
                  AppButton(
                    title: LocaleKeys.later.tr(),
                    backgroundColor: AppColors.white,
                    side: const BorderSide(
                      color: AppColors.greyE9,
                    ),
                    style: AppStyles.s18w500.copyWith(
                      color: AppColors.grey7A,
                    ),
                    onPressed: () {
                      permissionController.skipPermission(widget.permission);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
