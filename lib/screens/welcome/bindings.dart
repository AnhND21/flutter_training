import 'package:flutter_training/screens/welcome/controller.dart';
import 'package:get/get.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(
      () {
        return WelcomeController();
      },
    );
  }
}
