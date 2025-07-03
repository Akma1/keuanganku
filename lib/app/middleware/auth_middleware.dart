import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const RouteSettings(name: Routes.SIGN_IN);
    }
    return null;
  }
}
