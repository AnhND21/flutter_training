import 'package:flutter_training/screens/root/controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () {
        return RootController();
      },
    );
  }
}
