import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions_preview_mode/src/config/app_images.dart';
import 'package:permissions_preview_mode/src/config/locale/locale_data.dart';
import 'package:permissions_preview_mode/src/config/router/router.dart';
import 'package:permissions_preview_mode/src/data/shared_prefs.dart';
import 'package:permissions_preview_mode/src/presentation/views/permission_view/provider/permissions_provider.dart';
import 'package:permissions_preview_mode/src/utils/extensions/context_extension.dart';
import 'package:permissions_preview_mode/src/utils/helpers/svg_cache_handler.dart';

import 'src/config/themes/app_colors.dart';

// dart run easy_localization:generate -S "assets/translations"

// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S "assets/translations"

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await SharedPrefs.init();

  final permissionsState = await PermissionsNotifier.fetchStates();

  await SvgCacheHandler(
    imagePaths: [
      AppImages.locationPermission,
      AppImages.notificationPermission,
    ],
  ).cache();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleData.supportedLocales,
      path: LocaleData.localesPath,
      fallbackLocale: LocaleData.fallbackLocale,
      ignorePluralRules: false,
      saveLocale: true,
      child: ProviderScope(
        overrides: [
          // Override to access permissions states when router initialized
          permissionsProvider.overrideWith(
            () {
              return PermissionsNotifier(
                initialState: permissionsState,
              );
            },
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        textScaler: TextScaler.linear(
          context.scaleFactor,
        ),
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}
