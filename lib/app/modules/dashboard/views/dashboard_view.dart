import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:keuanganku/app/widgets/custom_button.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          CustomButton(
            onPressed: () {
              //
            },
            icon: Icons.logout_rounded,
            textColor: Colors.black,
            buttonType: ButtonType.icon,
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
      body: const Center(child: Text('DashboardView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
