import 'package:flutter/material.dart';
import 'package:flutter_training/core/theme_data.dart';
import 'package:flutter_training/core/theme_provider.dart';
import 'package:flutter_training/screens/chat/chat_screen.dart';
import 'package:flutter_training/screens/chat/chat_welcome_screen.dart';
import 'package:flutter_training/screens/chat/confirm_otp_screen.dart';
import 'package:flutter_training/screens/chat/create_profile_screen.dart';
import 'package:flutter_training/screens/chat/login_phone_screen.dart';
import 'package:flutter_training/screens/chat/message_details.dart';
import 'package:flutter_training/screens/listing_screen.dart';
import 'package:flutter_training/screens/weather_location_screen.dart';
import 'package:flutter_training/screens/movie_details.dart';
import 'package:flutter_training/screens/movies_screens.dart';
import 'package:flutter_training/screens/profile_screen.dart';
import 'package:flutter_training/screens/root.dart';
import 'package:flutter_training/screens/splash_screen.dart';
import 'package:flutter_training/screens/weather_screen.dart';
import 'package:flutter_training/screens/weather_setting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkThemeProvider>(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Hind'),
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            initialRoute: '/',
            routes: {
              "/": (context) => const SplashScreen(),
              '/root': (context) => const RootScreen(),
              '/listing': (context) => const ListingScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/movies': (context) => const MoviesScreen(),
              '/movie_detals': (context) => const MovieDetails(),
              '/weather': (context) => const WeatherScreen(),
              '/weather_setting': (context) => const WeatherSettingScreen(),
              '/weather_location': (context) => const WeatherLocationScreen(),
              '/chats': (context) => const ChatScreen(),
              '/chat_welcome': (context) => const ChatWelcomeScreen(),
              '/login_phone': (context) => const LoginPhoneScreen(),
              '/confirm_otp': (context) => const ConfirmOTPScreen(),
              '/create_profile': (context) => const CreateProfileScreen(),
              '/message_detail': (context) => const MessageDetailScreen(),
            },
          );
        },
      ),
    );
  }
}
