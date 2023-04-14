import 'package:flutter_training/screens/root/states.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final state = RootState();
  RootController();

  onTabChaged(int index) async {
    state.tabIndex.value = index;
  }

  goToPage(String appRoute) {
    Get.toNamed(appRoute);
  }
}
