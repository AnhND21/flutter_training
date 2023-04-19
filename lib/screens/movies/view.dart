import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movies/controller.dart';
import 'package:get/get.dart';

class MoviePage extends GetView<MovieController> {
  const MoviePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          padding: const EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Text(controller.state.name.value.toString()),
        ),
      ),
    );
  }
}
