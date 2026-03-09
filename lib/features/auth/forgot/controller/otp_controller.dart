import 'package:get/get.dart';

class OtpController extends GetxController {
  void onContinue() {
    final nextRoute = Get.arguments?['nextRoute'];

    if (nextRoute != null) {
      Get.toNamed(nextRoute);
    }
  }
}