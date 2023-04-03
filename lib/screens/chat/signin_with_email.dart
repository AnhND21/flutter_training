import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/chat/model/user_chat.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreen();
}

class _SignInWithEmailScreen extends State<SignInWithEmailScreen> {
  bool _isLoading = false;
  String email = 'da@g.com';
  String password = '111111';
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> onSignIn() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        setState(() {
          _isLoading = false;
        });
        getUserInfo(userCredential);
        onNavigateToHome();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> getUserInfo(UserCredential userInfo) async {
    _userCollection
        .doc((userInfo.user!.uid))
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        final credentials =
            UserChat.fromJson(value.data() as Map<String, dynamic>);
        currentUser!.updateDisplayName(
            "${credentials.firstName} ${credentials.lastName}");
        currentUser!.updatePhotoURL(credentials.photoURL);
      }
    });
  }

  void onNavigateToHome() {
    Navigator.pushNamed(context, "/chats");
  }

  void onChangeEmail(String text) {
    setState(() {
      email = text;
    });
  }

  void onChangePassword(String text) {
    setState(() {
      password = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: const Text('Sign in'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF7F7FC),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          initialValue: email,
                          onChanged: (value) {
                            onChangeEmail(value);
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 22,
                            ),
                            hintStyle: TextStyle(height: 1),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF7F7FC),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFormField(
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          initialValue: password,
                          onChanged: (value) {
                            onChangePassword(value);
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            suffixIcon: Icon(Icons.remove_red_eye),
                            filled: false,
                            focusColor: Colors.transparent,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 22,
                            ),
                            hintStyle: TextStyle(height: 1),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(32),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(0))),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sigin_email');
                                },
                                child: const Text('Sign up now'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_phone');
                  },
                  child: const Text(
                    'Sign up with phone number',
                    style: TextStyle(
                      color: Color(0xFF002DE3),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              InkWell(
                onTap: () async {
                  if (email.isNotEmpty &&
                      password.isNotEmpty &&
                      password.length >= 6) {
                    await onSignIn();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  child: _isLoading
                      ? const SizedBox(
                          height: 19,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
