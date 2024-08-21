import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/locale_keys.g.dart';
import '../../config/app_images.dart';

extension PermissionExtension on Permission {
  String get routePath {
    return switch (this) {
      Permission.notification => '/notification-permission',
      Permission.location => '/location-permission',
      _ => throw UnimplementedError('permission routePath not specified'),
    };
  }

  String get routeName {
    return switch (this) {
      Permission.notification => 'NotificationPermission',
      Permission.location => 'LocationPermission',
      _ => throw UnimplementedError('permission routeName not specified'),
    };
  }

  String? get image {
    return switch (this) {
      Permission.notification => AppImages.notificationPermission,
      Permission.location => AppImages.locationPermission,
      _ => null,
    };
  }

  String? get title {
    return switch (this) {
      Permission.notification => LocaleKeys.notification_permission.tr(),
      Permission.location => LocaleKeys.location_permission.tr(),
      _ => null,
    };
  }

  String? get subtitle {
    return switch (this) {
      Permission.notification =>
        LocaleKeys.notification_permission_description.tr(),
      Permission.location => LocaleKeys.location_permission_description.tr(),
      _ => null,
    };
  }
}
