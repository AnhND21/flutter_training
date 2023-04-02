import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  State<SignUpWithEmailScreen> createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  bool _isCheck = false;
  bool _isLoading = false;

  String email = '';
  String password = '';

  void onCheckTerm() {
    setState(() {
      _isCheck = !_isCheck;
    });
  }

  void navigateToCreateProfile(UserCredential userCredential) {
    Navigator.pushNamed(context, '/create_profile',
        arguments: userCredential.user);
  }

  Future<UserCredential?> onSignUp() async {
    UserCredential? userCredential;
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        _isLoading = true;
      });
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _isLoading = false;
      });
      userCredential = credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: const Text('Create an Account'),
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
                            setState(() {
                              email = value;
                            });
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
                            setState(() {
                              password = value;
                            });
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
                      Row(
                        children: <Widget>[
                          IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                onCheckTerm();
                              },
                              icon: _isCheck
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.check_box_outline_blank),
                              color: _isCheck ? Colors.blue : Colors.grey),
                          const Text('I agree to the'),
                          const Text(
                            ' Terms & Conditions',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(32),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account? '),
                            TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(0))),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sigin_email');
                                },
                                child: const Text('Sign in now'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      password.length >= 6 &&
                      _isCheck) {
                    final userCredential = await onSignUp();
                    if (userCredential != null) {
                      navigateToCreateProfile(userCredential);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: _isCheck
                          ? const Color(0xFF002DE3)
                          : Colors.grey.shade300,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32))),
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
                          'Sign up',
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
