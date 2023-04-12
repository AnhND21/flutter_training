import 'package:flutter/material.dart';
import 'package:flutter_training/screens/search/components/background_route.dart';
import 'package:flutter_training/screens/search/components/button_bottom.dart';
import 'package:flutter_training/screens/search/components/search_content.dart';
import 'package:flutter_training/screens/search/controller/search_controller.dart';
import 'package:flutter_training/screens/search/next_two_search_screen.dart';
import 'package:flutter_training/screens/search/result_search_screen.dart';
import 'package:get/get.dart';

class NextSearchScreen extends StatefulWidget {
  const NextSearchScreen({
    super.key,
  });

  @override
  State<NextSearchScreen> createState() => _NextSearchScreenState();
}

class _NextSearchScreenState extends State<NextSearchScreen> {
  TextEditingController editingController = TextEditingController();
  final SearchController searchController = Get.put(SearchController());

  void navigateToNextScreen() {
    final thirdValue = searchController.keywordThird.value;
    searchController.updateKeywordSecond(text: editingController.text.obs);
    if (thirdValue.isNotEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ResultSearchScreen()));
      return;
    }

    if (thirdValue.isEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NextTwoSearchScreen()));
      return;
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NextTwoSearchScreen()));
  }

  @override
  Widget build(BuildContext context) {
    String url =
        "https://cdna.artstation.com/p/assets/images/images/043/514/630/large/arjun-somasekharan-marvel-poster5.jpg?1637565554";
    return Scaffold(
      body: Stack(
        children: [
          BackgroundRoute(url: url),
          SearchContent(
              content: "Watch Online \n or \n Download Offline",
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
