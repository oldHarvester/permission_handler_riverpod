import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permissions_preview_mode/src/presentation/views/home_view/home_view.dart';
import 'package:permissions_preview_mode/src/presentation/views/permission_view/provider/permissions_provider.dart';
import 'package:permissions_preview_mode/src/utils/constants/permission_constants.dart';
import 'package:permissions_preview_mode/src/utils/extensions/permission_extension.dart';

import 'app_routes.dart';

final rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root_navigator');

final routerProvider = Provider<GoRouter>(
  (ref) {
    final permissions = ref.watch(permissionsProvider);
    return GoRouter(
      initialLocation: AppRoutes.home.path,
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) {
        final firstDenied = permissions.firstDenied;
        if (firstDenied != null) {
          return firstDenied.permission.routePath;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: HomeView(),
            );
          },
        ),
        ...PermissionConstants.requiredPermissionRoutes,
      ],
    );
  },
);
