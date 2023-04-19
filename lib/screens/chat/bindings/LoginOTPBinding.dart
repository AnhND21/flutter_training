import 'package:flutter_training/screens/chat/controller/LoginOTPController.dart';
import 'package:get/get.dart';

class LoginOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginOTPController>(() => LoginOTPController());
  }
}
