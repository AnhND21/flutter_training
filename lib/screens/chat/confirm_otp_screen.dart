import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmOTPScreen extends StatefulWidget {
  final String phone;
  final String verificationId;
  final VoidCallback resendCode;
  const ConfirmOTPScreen(
      {Key? key,
      required this.phone,
      required this.verificationId,
      required this.resendCode})
      : super(key: key);

  @override
  State<ConfirmOTPScreen> createState() => _ConfirmOTPScreenState();
}

class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otpFirst = TextEditingController(text: '');
  TextEditingController otpSecond = TextEditingController(text: '');
  TextEditingController otpThird = TextEditingController(text: '');
  TextEditingController otpFourth = TextEditingController(text: '');
  TextEditingController otpFifth = TextEditingController(text: '');
  TextEditingController otpSixth = TextEditingController(text: '');

  late String smsOTP;
  String verificationId = '';
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  void navigateToCreateProfile(UserCredential userCredential) {
    Navigator.pushNamed(context, '/create_profile', arguments: userCredential);
  }

  Future<void> onSignUpWithPhoneNumber() async {
    // Create a PhoneAuthCredential with the code
    String otp =
        "${otpFirst.text}${otpSecond.text}${otpThird.text}${otpFourth.text}${otpFifth.text}${otpSixth.text}";
    if (otp.length < 6) return;
    setState(() {
      isLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential
    auth.signInWithCredential(credential).then((UserCredential value) {
      if (value.user != null) {
        navigateToCreateProfile(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(CupertinoIcons.chevron_back),
      //   ),
      // ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Enter Code',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Text(
                      "We have sent you an SMS with the code to ${widget.phone}",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 64),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpFirst,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpSecond,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpThird,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpFourth,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpFifth,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: TextFormField(
                            controller: otpSixth,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                              } else {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.resendCode();
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(color: Color(0xFF002DE3), fontSize: 16),
                  )),
              InkWell(
                onTap: () async {
                  await onSignUpWithPhoneNumber();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  child: isLoading
                      ? const SizedBox(
                          height: 19,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Continue',
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
