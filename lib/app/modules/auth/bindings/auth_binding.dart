import 'package:get/get.dart';
import 'package:keuanganku/app/modules/auth/sign_in/controllers/sign_in_controller.dart';
import 'package:keuanganku/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
