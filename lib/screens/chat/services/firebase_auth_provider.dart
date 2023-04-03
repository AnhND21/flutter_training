import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  StreamSubscription? userAuthSub;

  AuthProvider() {
    userAuthSub = FirebaseAuth.instance.authStateChanges().listen((newUser) {
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      // ignore: avoid_print
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
    userAuthSub = FirebaseAuth.instance.userChanges().listen((newUser) {
      // ignore: avoid_prin
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      // ignore: avoid_print
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub!.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  bool get isAnonymous {
    assert(user != null);
    bool isAnonymousUser = true;
    for (UserInfo info in user!.providerData) {
      if (info.providerId == "facebook.com" ||
          info.providerId == "google.com" ||
          info.providerId == "password") {
        isAnonymousUser = false;
        break;
      }
    }
    return isAnonymousUser;
  }

  bool get isAuthenticated {
    return user != null;
  }

  void signInAnonymously() {
    FirebaseAuth.instance.signInAnonymously();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
