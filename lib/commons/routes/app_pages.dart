// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_training/commons/routes/app_routes.dart';
import 'package:flutter_training/screens/listing_screen.dart';
import 'package:flutter_training/screens/movie_details.dart';
import 'package:flutter_training/screens/movies/bindings.dart';
import 'package:flutter_training/screens/movies/model/movie_detail.dart';
import 'package:flutter_training/screens/movies/screens/movie_search.dart';
import 'package:flutter_training/screens/movies_screens.dart';
import 'package:flutter_training/screens/profile_screen.dart';
import 'package:flutter_training/screens/root.dart';
import 'package:flutter_training/screens/root/bingdings.dart';
import 'package:flutter_training/screens/welcome/index.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL_ROUTE = AppRoutes.WELCOME_SCREEN;
  static const ROOT_ROUTE = AppRoutes.ROOT;

  //chat
  static const CHAT_ROUTE = AppRoutes.WELCOME_CHAT_SCREEN;

  // profile
  static const PROFILE_ROUTE = AppRoutes.PROFILE_SCREEN;

  // listing
  static const LISTING_ROUTE = AppRoutes.LISTING_SCREEN;

  // movie
  static const MOVIE_ROUTE = AppRoutes.MOVIE_SCREEN;
  static const MOVIE_SEARCH_ROUTE = AppRoutes.MOVIE_SEARCH_SCREEN;

  // note
  static const NOTE_ROUTE = AppRoutes.NOTE_SCREEN;
  static const ADD_NOTE_ROUTE = AppRoutes.ADD_NOTE_SCREEN;

  // weather
  static const WEATHER_ROUTE = AppRoutes.WEATHER_SCREEN;
  static const WEATHER_SETTING_ROUTE = AppRoutes.WEATHER_SETTING_SCREEN;
  static const WEATHER_LOCATION_ROUTE = AppRoutes.WEATHER_LOCATION_SCREEN;

  static final List<String> history = [];
  static final RouteObserver routeObserver = RouteObserver();
  static final List<GetPage> routes = [
    GetPage(
        name: INITIAL_ROUTE,
        page: () => const WelcomePage(),
        binding: WelcomeBinding()),
    GetPage(name: ROOT_ROUTE, page: () => RootScreen(), binding: RootBinding()),
    GetPage(
      name: LISTING_ROUTE,
      page: () => const ListingScreen(),
    ),
    GetPage(
      name: PROFILE_ROUTE,
      page: () => const ProfileScreen(),
    ),
    GetPage(
        name: MOVIE_ROUTE, page: () => MoviesScreen(), binding: MovieBinding()),
    GetPage(
      name: MOVIE_SEARCH_ROUTE,
      page: () => const MovieSearchScreen(),
    ),
  ];
}
