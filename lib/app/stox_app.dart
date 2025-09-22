import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../core/localization/app_translations.dart';
import '../shared/theme/app_theme.dart';
import 'router/app_router.dart';

class MedicalCityApp extends StatelessWidget {
  const MedicalCityApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => getIt<AuthBloc>()),
        // BlocProvider(create: (_) => getIt<UserBloc>()),
        // BlocProvider(create: (_) => getIt<StockBloc>()),
        // BlocProvider(create: (_) => getIt<OptionBloc>()),
        // BlocProvider(create: (_) => getIt<ArchiveBloc>()),
      ],
      child: GetMaterialApp.router(
        title: 'Medical City',
        theme: lightTheme,
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        // Localization configuration
        locale: Get.locale ?? const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        translations: AppTranslations(),
        builder: EasyLoading.init(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
