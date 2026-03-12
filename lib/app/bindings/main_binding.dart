import 'package:get/get.dart';

import '../../core/services/photo_picker_service.dart';
import '../../features/auth/profile/controller/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoPickerService>(() => PhotoPickerService(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}