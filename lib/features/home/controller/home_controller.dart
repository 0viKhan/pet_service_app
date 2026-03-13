import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../services/pet_service.dart';
import '../services/park_service.dart';

class HomeController extends GetxController {
  final PetService _petService = PetService();
  final ParkService _parkService = ParkService();

  RxList<dynamic> pets = <dynamic>[].obs;
  RxList<dynamic> parks = <dynamic>[].obs;

  RxBool loading = false.obs;
  RxBool parkLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets();
    fetchParks();
  }

  // PETS
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

  // PARKS
  Future<void> fetchParks() async {
    try {
      parkLoading.value = true;

      final token = await LocalStorageService.getAccessToken();

      if (token == null || token.isEmpty) {
        return;
      }

      final data = await _parkService.getParks(token);

      parks.value = data;

    } catch (e) {
      Get.snackbar("Park Error", e.toString());
    } finally {
      parkLoading.value = false;
    }
  }
}