import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_training/screens/search/components/background_route.dart';
import 'package:flutter_training/screens/search/components/button_bottom.dart';
import 'package:flutter_training/screens/search/components/search_content.dart';
import 'package:flutter_training/screens/search/controller/search_controller.dart';
import 'package:get/get.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({super.key});

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}
//

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  final SearchController searchController = Get.put(SearchController());
  bool isLoggedIn = false;
  void onLogin() {
    final firstValue = searchController.keywordFirst.value;
    final secondValue = searchController.keywordSecond.value;
    final thirdValue = searchController.keywordThird.value;
    if (firstValue.isEmpty) {
      Navigator.of(context).popUntil(ModalRoute.withName('/search'));
      return;
    }
    if (secondValue.isEmpty) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      return;
    }
    if (thirdValue.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    if (firstValue.isNotEmpty &&
        secondValue.isNotEmpty &&
        thirdValue.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        content: Text(
          "Logged in!",
          style: TextStyle(fontSize: 22),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String url =
        "https://media.comicbook.com/2020/03/black-widow-poster-marvel-1210170.jpeg";
    return Scaffold(
      body: Stack(
        children: [
          BackgroundRoute(url: url),
          const SearchContent(),
          isLoggedIn
              ? ContentWidget(searchController: searchController)
              : Container(),
          !isLoggedIn
              ? ButtonBottom(
                  title: 'Login',
                  onPress: onLogin,
                )
              : Container()
        ],
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.searchController,
  });

  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 2),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Screen first: ${searchController.keywordFirst.value}",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text("Screen second: ${searchController.keywordSecond.value}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          Text("Screen third: ${searchController.keywordThird.value}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ],
      )),
    );
  }
}
