import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuanganku/app/routes/app_pages.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
