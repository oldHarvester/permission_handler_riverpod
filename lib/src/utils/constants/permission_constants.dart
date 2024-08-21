import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permissions_preview_mode/src/utils/extensions/permission_extension.dart';

import '../../presentation/views/permission_view/permission_view.dart';

abstract final class PermissionConstants {
  static final requiredPermissions = {
    Permission.notification,
    Permission.location,
  };

  static final List<GoRoute> requiredPermissionRoutes = List.generate(
    requiredPermissions.length,
    (index) {
      final permission = requiredPermissions.elementAt(index);
      return GoRoute(
        path: permission.routePath,
        name: permission.routeName,
        builder: (context, state) {
          return PermissionView(
            permission: permission,
          );
        },
      );
    },
  );
}
