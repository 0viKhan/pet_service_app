import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../model/pet_service.dart';

class HomeController extends GetxController {
  final PetService _petService = PetService();

  RxList<dynamic> pets = <dynamic>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets();
  }

  Future<void> fetchPets() async {
    try {
      loading.value = true;

      final token = await LocalStorageService.getAccessToken();

      if (token == null || token.isEmpty) {
        return;
      }

      final data = await _petService.getPets(token);
      pets.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }
}