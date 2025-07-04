import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keuanganku/app/routes/app_pages.dart';
import 'package:keuanganku/app/modules/main_menu/views/main_menu_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          // Sudah login, tampilkan MainMenuView (dengan bottom nav)
          return const MainMenuView();
        } else {
          // Belum login, navigasi ke SIGN_IN agar binding berjalan
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAllNamed(Routes.SIGN_IN);
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}
