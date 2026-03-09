import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../onboarding_model/welcome_model.dart';

class WelcomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<WelcomeModel> welcomePages = const [
    WelcomeModel(
      image: 'assets/images/cat.png',
      title: 'All Pet Services in One App',
      subtitle: 'Find vets, groomers, trainers & sitters near you with ease.',
    ),
    WelcomeModel(
      image: 'assets/images/dog.png',
      title: 'Book Trusted Pet Experts Easily',
      subtitle: 'Schedule appointments with verified pet care professionals.',
    ),
    WelcomeModel(
      image: 'assets/images/dog_child.png',
      title: 'Care For Your Pet Anytime',
      subtitle: 'Manage bookings, services and support from one place.',
    ),
  ];

  bool get isLastPage => currentIndex.value == welcomePages.length - 1;

  WelcomeModel get currentPage => welcomePages[currentIndex.value];

  void nextPage() {
    if (isLastPage) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      currentIndex.value++;
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  void skip() {
    Get.offAllNamed(AppRoutes.login);
  }
}