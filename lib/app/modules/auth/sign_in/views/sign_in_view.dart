import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/const/app_gap.dart';
import 'package:keuanganku/app/const/app_size.dart';
import 'package:keuanganku/app/widgets/custom_button.dart';
import 'package:keuanganku/app/widgets/custom_form.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.radiusM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(labelText: 'Email', controller: emailController),
            Gaps.h16,
            CustomTextFormField(labelText: 'Password', controller: passwordController, obscureText: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onPressed: () {},
                  text: 'Lupa Password?',
                  textColor: Colors.blue,
                  buttonType: ButtonType.text,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () => controller.signIn(emailController.text.trim(), passwordController.text.trim()),
                text: 'Sign In',
                buttonType: ButtonType.elevated,
              ),
            ),
            Gaps.h16,
            SizedBox(
              width: double.infinity,
              child: CustomButton(onPressed: () {}, text: 'Sign Up', buttonType: ButtonType.outlined),
            ),
          ],
        ),
      ),
    );
  }
}
