import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/services/auth_service.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.lazyPut(() => AuthService());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
