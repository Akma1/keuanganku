import 'package:get/get.dart';
import 'package:keuanganku/app/services/auth_service.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();

  //TODO: Implement SignInController

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

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signInWithEmail(email, password);
      Get.snackbar('Sukses', 'Login berhasil');
      // TODO: Navigasi ke halaman utama
    } catch (e) {
      Get.snackbar('Error', 'Login gagal: \\${e.toString()}');
    }
  }
}
