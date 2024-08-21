import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/constants/permission_constants.dart';
import 'permissions_state.dart';

final permissionsProvider =
    NotifierProvider<PermissionsNotifier, PermissionsState>(
  () {
    throw UnimplementedError('initial PermissionsState not specified');
  },
);

class PermissionsNotifier extends Notifier<PermissionsState> {
  PermissionsNotifier({
    required this.initialState,
  });

  final PermissionsState initialState;

  static Future<PermissionsState> fetchStates() async {
    final temp = <PermissionState>[];

    for (final permission in PermissionConstants.requiredPermissions) {
      final status = await permission.status;
      temp.add(
        PermissionState(
          permission: permission,
          status: status,
        ),
      );
    }

    return PermissionsState(permissions: temp);
  }

  void skipPermission(Permission permission) {
    final newState = state.copyWithPermission(
      permission: permission,
      onChange: (currentState) {
        return currentState.copyWith(
          skipped: true,
        );
      },
    );
    if (newState != null) {
      state = newState;
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    final resultStatus = await permission.request();
    final temp = state.copyWithPermission(
      permission: permission,
      onChange: (currentState) {
        if (currentState.status != resultStatus) {
          return currentState.copyWith(
            status: resultStatus,
          );
        } else {
          return null;
        }
      },
    );
    if (temp != null) {
      state = temp;
    }
    return true;
  }

  Future<void> refreshPermissions() async {
    var newPermissions = await fetchStates();
    final oldPermissions = state;

    for (final newPermission in newPermissions.permissions) {
      final oldPermission = oldPermissions.stateOf(newPermission.permission);
      if (oldPermission != null) {
        final temp = newPermissions.copyWithPermission(
          permission: newPermission.permission,
          onChange: (currentState) {
            return oldPermission.copyWith(
              status: currentState.status,
            );
          },
        );
        if (temp != null) {
          newPermissions = temp;
        }
      }
    }
    if (state != newPermissions) {
      state = newPermissions;
    }
  }

  @override
  PermissionsState build() {
    return initialState;
  }
}
