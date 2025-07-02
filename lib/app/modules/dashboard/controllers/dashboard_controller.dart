import 'package:get/get.dart';
import 'package:keuanganku/app/data/database/db.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  final database = AppDb.to;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
