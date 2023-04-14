import 'package:flutter_training/screens/movies/controller.dart';
import 'package:flutter_training/screens/welcome/controller.dart';
import 'package:get/get.dart';

class MovieBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(
      () {
        return MovieController();
      },
    );
  }
}
