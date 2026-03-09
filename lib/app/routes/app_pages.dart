import 'package:get/get.dart';
import '../../features/auth/forgot/bindings/OtpBinding.dart';
import '../../features/auth/forgot/view/create_new_password_view.dart';
import '../../features/auth/forgot/view/otp.dart';
import '../../features/auth/forgot/view/password_changed_view.dart';
import '../../features/auth/forgot/view/reset_password_view.dart';
import '../../features/auth/login/login_view.dart';
import '../../features/auth/registration/binding/register_binding.dart';
import '../../features/auth/registration/view/register_view.dart';
import '../../features/home/view/home_view.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/welcome/bindings/welcome_binding.dart';
import '../../features/welcome/onboarding screen/welcome_view.dart';
import '../../main_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const VerificationCodeView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => const CreateNewPasswordView(),
    ),
    GetPage(
      name: AppRoutes.passwordChanged,
      page: () => const PasswordChangedView(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
    ),
  ];
}