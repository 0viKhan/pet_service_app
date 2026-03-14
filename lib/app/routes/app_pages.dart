import 'package:get/get.dart';
import 'package:untitled1/features/auth/login/bindings/login_binding.dart';
import 'package:untitled1/features/order_history/view/order_history_view.dart';
import '../../features/add_animal/bindings/add_animal_binding.dart';
import '../../features/add_animal/view/add_animal_view.dart';
import '../../features/auth/forgot/bindings/forgot_password_binding.dart';
import '../../features/auth/forgot/view/create_new_password_view.dart';
import '../../features/auth/forgot/view/otp.dart';
import '../../features/auth/forgot/view/password_changed_view.dart';
import '../../features/auth/forgot/view/reset_password_view.dart';
import '../../features/auth/login/view/login_view.dart';
import '../../features/auth/profile/controller/ChangePasswordController.dart';
import '../../features/auth/profile/view/change_password_screen.dart';
import '../../features/auth/registration/binding/register_binding.dart';
import '../../features/auth/registration/view/register_view.dart';
import '../../features/notification/view/notification_screen.dart';
import '../../features/pet_description/view/pet_details.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/welcome/bindings/welcome_binding.dart';
import '../../features/welcome/onboarding screen/welcome_view.dart';
import '../../main_view.dart';
import '../bindings/main_binding.dart';
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
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const VerificationCodeView(),
    ),
    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => const CreateNewPasswordView(),
      binding: ForgotPasswordBinding(),
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
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.addAnimal,
      page: () => const AddAnimalView(),
      binding: AddAnimalBinding(),
    ),
    GetPage(
      name: AppRoutes.petdetails,
      page: () => const PetDetailsView(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationView(),
    ),
    // Route file এ
    GetPage(
      name: '/change-password',
      page: () => ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChangePasswordController());
      }),
    ),
    GetPage(
      name: AppRoutes.orderhistory,
      page: ()=>OrderHistoryView()
    )

  ];
}