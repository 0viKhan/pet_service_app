import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

import '../../../core/services/local_storage_service.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    goToNextPage();
  }

  Future<void> goToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await LocalStorageService.getAccessToken();

    print('Saved token: $token');

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.home);
    } else {
     // Get.offAllNamed(AppRoutes.welcome);(corrrect )
      Get.offAllNamed(AppRoutes.home);

    }
  }
}