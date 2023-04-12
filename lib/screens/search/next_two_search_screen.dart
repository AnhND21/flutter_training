import 'package:flutter/material.dart';
import 'package:flutter_training/screens/search/components/background_route.dart';
import 'package:flutter_training/screens/search/components/button_bottom.dart';
import 'package:flutter_training/screens/search/components/search_content.dart';
import 'package:flutter_training/screens/search/controller/search_controller.dart';
import 'package:flutter_training/screens/search/result_search_screen.dart';
import 'package:get/get.dart';

class NextTwoSearchScreen extends StatefulWidget {
  const NextTwoSearchScreen({super.key});

  @override
  State<NextTwoSearchScreen> createState() => _NextTwoSearchScreenState();
}

class _NextTwoSearchScreenState extends State<NextTwoSearchScreen> {
  TextEditingController editingController = TextEditingController();
  final searchController = Get.put(SearchController());

  void navigateToNextScreen() {
    searchController.updateKeywordThird(text: editingController.text.obs);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ResultSearchScreen()));
  }

  @override
  Widget build(BuildContext context) {
    String url =
        "https://cdn.shopify.com/s/files/1/0037/8008/3782/products/BlackWidowReleaseMoviePoster-124438.jpg?v=1628086812";
    return Scaffold(
      body: Stack(
        children: [
          BackgroundRoute(url: url),
          SearchContent(
              content:
                  "Create profiles for diffrent members & get personalised recommendations",
              editingController: editingController),
          ButtonBottom(
            title: 'Continue',
            onPress: navigateToNextScreen,
          )
        ],
      ),
    );
  }
}
