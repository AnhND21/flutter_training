import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_training/screens/search/components/background_route.dart';
import 'package:flutter_training/screens/search/components/button_bottom.dart';
import 'package:flutter_training/screens/search/components/search_content.dart';
import 'package:flutter_training/screens/search/controller/search_controller.dart';
import 'package:flutter_training/screens/search/next_search_screen.dart';
import 'package:flutter_training/screens/search/next_two_search_screen.dart';
import 'package:flutter_training/screens/search/result_search_screen.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  final SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.updateKeywordFirst(text: RxString(''));
    searchController.updateKeywordSecond(text: RxString(''));
    searchController.updateKeywordThird(text: RxString(''));
  }

  void navigateToNextScreen() {
    final secondValue = searchController.keywordSecond.value;
    final thirdValue = searchController.keywordThird.value;
    searchController.updateKeywordFirst(text: editingController.text.obs);

    if (secondValue.isNotEmpty && thirdValue.isNotEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ResultSearchScreen()));
      return;
    }
    if (secondValue.isEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NextSearchScreen()));
      return;
    }
    if (thirdValue.isEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NextTwoSearchScreen()));
      return;
    }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NextSearchScreen()));
  }

  @override
  Widget build(BuildContext context) {
    String url = "https://m.media-amazon.com/images/I/815oKqKUo4L.jpg";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            BackgroundRoute(url: url),
            SearchContent(
                content:
                    "All your favorite Marvel Movies & Series at one place \n",
                editingController: editingController),
            ButtonBottom(
              title: 'Continue',
              onPress: navigateToNextScreen,
            )
          ],
        ),
      ),
    );
  }
}
