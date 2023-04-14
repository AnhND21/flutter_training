import 'package:flutter_training/commons/routes/app_routes.dart';
import 'package:flutter_training/screens/welcome/states.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  onPageChaged(int index) async {
    state.slideIndex.value = index;
  }

  goToMainPage() {
    Get.offAndToNamed(AppRoutes.ROOT);
  }
}
