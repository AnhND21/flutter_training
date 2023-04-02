// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginOTPAgruments {
  final String phone;
  LoginOTPAgruments({
    required this.phone,
  });
}

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  String phone = '';

  void onPhoneNumerChange(String text) {
    setState(() {
      phone = text;
    });
  }

  void navigateSignUpEmail() {
    Navigator.pushNamed(context, '/signup_email');
  }

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
          // color: Colors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Enter Your Phone Number',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    child: Text(
                      'Please confirm your country code and enter your phone number',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 48),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: const BoxDecoration(
                              color: Color(0xFFF7F7FC),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/flag_vn.png",
                                fit: BoxFit.contain,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  '+84',
                                  style: TextStyle(
                                      color: Color(0xFFADB5BD),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                            flex: 1,
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF7F7FC),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: TextFormField(
                                autocorrect: false,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                initialValue: phone,
                                onChanged: (text) => onPhoneNumerChange(text),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      height: 1, color: Color(0xFFADB5BD)),
                                  filled: true,
                                  fillColor: Color(0xFFF7F7FC),
                                  hintText: 'Phone Number',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              )),
              TextButton(
                  onPressed: () {
                    navigateSignUpEmail();
                  },
                  child: const Text(
                    'Sign up with email',
                    style: TextStyle(
                      color: Color(0xFF002DE3),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/confirm_otp',
                      arguments: LoginOTPAgruments(phone: phone));
                  // phone.isNotEmpty
                  //     ? Navigator.pushNamed(context, '/confirm_otp',
                  //         arguments: phone.isNotEmpty
                  //             ? LoginOTPAgruments(phone: phone)
                  //             : {})
                  //     : {};
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  child: const Text(
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
