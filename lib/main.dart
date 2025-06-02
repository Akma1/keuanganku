import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/common/serializer.dart';
import 'package:keuanganku/app/services/auth_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.defaultSerializer = const MySerializer();
  await FlutterLocalization.instance.ensureInitialized();
  final FlutterLocalization localization = FlutterLocalization.instance;

  Get.lazyPut(() => AuthService());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      locale: localization.currentLocale,
      localizationsDelegates: localization.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('id'), // Indonesian
      ],
    ),
  );
}
