import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/routes/app_pages.dart';
import 'package:keuanganku/app/widgets/custom_button.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Text', style: TextStyle(fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  Get.toNamed(Routes.SIGN_IN);
                },
                text: 'Sign In',
                buttonType: ButtonType.elevated,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
