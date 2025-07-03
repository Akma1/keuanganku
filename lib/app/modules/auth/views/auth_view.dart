import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuanganku/app/modules/dashboard/views/dashboard_view.dart';
import 'package:keuanganku/app/modules/auth/sign_in/views/sign_in_view.dart';

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
          // Sudah login, tampilkan dashboard
          return const DashboardView();
        } else {
          // Belum login, tampilkan sign in
          return const SignInView();
        }
      },
    );
  }
}
