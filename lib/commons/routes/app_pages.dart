// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_training/commons/routes/app_routes.dart';
import 'package:flutter_training/screens/chat/bindings/LoginOTPBinding.dart';
import 'package:flutter_training/screens/chat/chat_welcome_screen.dart';
import 'package:flutter_training/screens/chat/create_profile_screen.dart';
import 'package:flutter_training/screens/chat/login_phone_screen.dart';
import 'package:flutter_training/screens/listing_screen.dart';
import 'package:flutter_training/screens/movie_details.dart';
import 'package:flutter_training/screens/movies/bindings.dart';
import 'package:flutter_training/screens/movies/model/movie_detail.dart';
import 'package:flutter_training/screens/movies/screens/movie_search.dart';
import 'package:flutter_training/screens/movies_screens.dart';
import 'package:flutter_training/screens/notes/screens/add_note_screen.dart';
import 'package:flutter_training/screens/notes/screens/note_screen.dart';
import 'package:flutter_training/screens/notes/screens/search_note_screen.dart';
import 'package:flutter_training/screens/profile_screen.dart';
import 'package:flutter_training/screens/root.dart';
import 'package:flutter_training/screens/root/bingdings.dart';
import 'package:flutter_training/screens/search/next_search_screen.dart';
import 'package:flutter_training/screens/search/next_two_search_screen.dart';
import 'package:flutter_training/screens/search/result_search_screen.dart';
import 'package:flutter_training/screens/search/search_screen.dart';
import 'package:flutter_training/screens/weather_location_screen.dart';
import 'package:flutter_training/screens/weather_screen.dart';
import 'package:flutter_training/screens/weather_setting_screen.dart';
import 'package:flutter_training/screens/welcome/index.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL_ROUTE = AppRoutes.WELCOME_SCREEN;
  static const ROOT_ROUTE = AppRoutes.ROOT;

  //chat
  static const CHAT_ROUTE = AppRoutes.WELCOME_CHAT_SCREEN;
  static const LOGIN_OTP_ROUTE = AppRoutes.LOGIN_PHONE_CHAT_SCREEN;
  static const CREATE_PROFILE_ROUTE = AppRoutes.CREATE_PROFILE_SCREEN;

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
  static const SEARCH_NOTE_ROUTE = AppRoutes.SEARCH_NOTE_SCREEN;

  // weather
  static const WEATHER_ROUTE = AppRoutes.WEATHER_SCREEN;
  static const WEATHER_SETTING_ROUTE = AppRoutes.WEATHER_SETTING_SCREEN;
  static const WEATHER_LOCATION_ROUTE = AppRoutes.WEATHER_LOCATION_SCREEN;

  // routes
  static const SCREEN_ROUTE = AppRoutes.SEARCH_SCREEN;
  static const SCREEN_FIRST_ROUTE = AppRoutes.SEARCH_FIRST_SCREEN;
  static const SCREEN_SECOND_ROUTE = AppRoutes.SEARCH_SECOND_SCREEN;
  static const SCREEN_RESULT_ROUTE = AppRoutes.SEARCH_RESULT_SCREEN;

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
        name: MOVIE_ROUTE,
        page: () => const MoviesScreen(),
        binding: MovieBinding()),
    GetPage(
      name: MOVIE_SEARCH_ROUTE,
      page: () => const MovieSearchScreen(),
    ),
    GetPage(
      name: WEATHER_ROUTE,
      page: () => const WeatherScreen(),
    ),
    GetPage(
      name: WEATHER_LOCATION_ROUTE,
      page: () => const WeatherLocationScreen(),
    ),
    GetPage(
      name: WEATHER_SETTING_ROUTE,
      page: () => const WeatherSettingScreen(),
    ),
    GetPage(
      name: NOTE_ROUTE,
      page: () => const NoteScreen(),
    ),
    GetPage(
      name: ADD_NOTE_ROUTE,
      page: () => const AddNoteScreen(),
    ),
    GetPage(
      name: SEARCH_NOTE_ROUTE,
      page: () => const SearchNoteScreen(),
    ),
    GetPage(name: SCREEN_ROUTE, page: () => const SearchScreen()),
    GetPage(name: SCREEN_FIRST_ROUTE, page: () => const NextSearchScreen()),
    GetPage(name: SCREEN_SECOND_ROUTE, page: () => const NextTwoSearchScreen()),
    GetPage(name: SCREEN_RESULT_ROUTE, page: () => const ResultSearchScreen()),
    // Firebase chat route
    GetPage(name: CHAT_ROUTE, page: () => const ChatWelcomeScreen()),
    GetPage(
        name: LOGIN_OTP_ROUTE,
        page: () => LoginPhoneScreen(),
        binding: LoginOTPBinding()),
    GetPage(
      name: CREATE_PROFILE_ROUTE,
      page: () => const CreateProfileScreen(),
    ),
  ];
}
