import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/common/serializer.dart';
import 'package:keuanganku/app/data/database/db.dart';
import 'package:keuanganku/app/services/auth_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  driftRuntimeOptions.defaultSerializer = const MySerializer();
  await FlutterLocalization.instance.ensureInitialized();
  final FlutterLocalization localization = FlutterLocalization.instance;

  Get.lazyPut(() => AuthService());
  Get.lazyPut(() => AppDb());
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
