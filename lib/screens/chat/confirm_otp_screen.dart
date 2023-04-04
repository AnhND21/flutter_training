import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/screens/chat/login_phone_screen.dart';

class ConfirmOTPScreen extends StatefulWidget {
  const ConfirmOTPScreen({super.key});

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

  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> verifyPhone(String phoneNo) async {
    smsOTPSent(String verId, [int? forceCodeResend]) {
      verificationId = verId;
    }

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber:
              "+84{$phoneNo.substring(1, 10)}", // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            // ignore: avoid_print
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException e) {
            // ignore: avoid_print
            print('${e.message}');
          });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as LoginOTPAgruments;

    return Scaffold(
      appBar: AppBar(
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
          width: double.infinity,
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
                      "We have sent you an SMS with the code to ${params.phone}",
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
                          width: 48,
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
                          width: 48,
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
                          width: 48,
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
                  )
                ],
              )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(color: Color(0xFF002DE3), fontSize: 16),
                  )),
              InkWell(
                onTap: () async {
                  await verifyPhone(params.phone);
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
