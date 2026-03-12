import 'package:get/get.dart';

import '../../../core/services/photo_picker_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoPickerService>(() => PhotoPickerService());
  }
}