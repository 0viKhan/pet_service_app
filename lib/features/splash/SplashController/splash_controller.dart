import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextPage();
  }

  Future<void> goToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.welcome);
  }
}