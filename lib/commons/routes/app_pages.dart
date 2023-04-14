// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_training/commons/routes/app_routes.dart';
import 'package:flutter_training/screens/root.dart';
import 'package:flutter_training/screens/welcome/index.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL_ROUTE = AppRoutes.WELCOME_SCREEN;
  static const ROOT_ROUTE = AppRoutes.ROOT;

  static final List<String> history = [];
  static final RouteObserver routeObserver = RouteObserver();

  static final List<GetPage> routes = [
    GetPage(
        name: INITIAL_ROUTE,
        page: () => const WelcomePage(),
        binding: WelcomeBinding()),
    GetPage(
      name: ROOT_ROUTE,
      page: () => const RootScreen(),
    ),
  ];
}
