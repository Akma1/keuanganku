import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth/sign_in/views/sign_in_view.dart';
import '../modules/auth/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/auth/splash_screen/views/splash_screen_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(
            name: _Paths.SIGN_IN,
            page: () => const SignInView(),
            binding: SignInBinding()),
        GetPage(
            name: _Paths.REGISTER,
            page: () => const RegisterView(),
            binding: HistoryBinding()),
        GetPage(
          name: _Paths.SPLASH_SCREEN,
          page: () => const SplashScreenView(),
          binding: SplashScreenBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => const DashboardView(),
        binding: DashboardBinding()),
    GetPage(
        name: _Paths.HISTORY,
        page: () => const HistoryView(),
        binding: HistoryBinding()),
    GetPage(
      name: _Paths.DETAILS,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}
