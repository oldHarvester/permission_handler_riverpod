import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionState extends Equatable {
  const PermissionState({
    required this.permission,
    required this.status,
    this.skipped = false,
  });
  final Permission permission;
  final PermissionStatus status;
  final bool skipped;

  @override
  List<Object?> get props => [permission, status, skipped];

  PermissionState copyWith({
    Permission? permission,
    PermissionStatus? status,
    bool? skipped,
  }) {
    return PermissionState(
      permission: permission ?? this.permission,
      status: status ?? this.status,
      skipped: skipped ?? this.skipped,
    );
  }
}

class PermissionsState extends Equatable {
  const PermissionsState({
    required this.permissions,
  });

  final List<PermissionState> permissions;

  PermissionState? get firstDenied {
    final temp = permissions;
    if (temp.isEmpty) return null;
    for (final permission in temp) {
      if (permission.status != PermissionStatus.granted &&
          !permission.skipped) {
        return permission;
      }
    }
    return null;
  }

  int? indexOf(Permission permission) {
    final index = permissions.indexWhere(
      (element) {
        return element.permission == permission;
      },
    );
    if (index < 0) {
      return null;
    }
    return index;
  }

  PermissionState? stateOf(Permission permission) {
    final index = indexOf(permission);
    return index == null ? null : permissions[index];
  }

  PermissionsState? copyWithPermission({
    required Permission permission,
    required PermissionState? Function(PermissionState currentState) onChange,
  }) {
    final index = indexOf(permission);
    if (index == null) return null;
    final state = permissions[index];
    final newState = onChange.call(state);
    if (newState == null) return null;
    return PermissionsState(
      permissions: [...permissions]
        ..removeAt(index)
        ..insert(index, newState),
    );
  }

  @override
  String toString() {
    return permissions.toString();
  }

  @override
  List<Object?> get props => [permissions];

  PermissionsState copyWith({
    List<PermissionState>? permissions,
  }) {
    return PermissionsState(
      permissions: permissions ?? this.permissions,
    );
  }
}
