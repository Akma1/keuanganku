import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuanganku/app/widgets/custom_logout_dialog.dart';
import 'package:keuanganku/app/routes/app_pages.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => CustomLogoutDialog(
            onConfirm: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(Routes.SIGN_IN);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: Center(child: ElevatedButton(onPressed: () => _showLogoutDialog(context), child: const Text('Logout'))),
    );
  }
}
