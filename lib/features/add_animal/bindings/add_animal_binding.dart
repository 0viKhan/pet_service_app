import 'package:get/get.dart';
import '../controller/add_animal_controller.dart';

class AddAnimalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAnimalController>(() => AddAnimalController(), fenix: true);
  }
}