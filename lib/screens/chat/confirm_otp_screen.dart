import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/chat/login_phone_screen.dart';

class ConfirmOTPScreen extends StatefulWidget {
  const ConfirmOTPScreen({super.key});

  @override
  State<ConfirmOTPScreen> createState() => _ConfirmOTPScreenState();
}

class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {
  String otp1 = '';

  List<String> otpList = <String>['', '', '', ''];

  @override
  void initState() {
    super.initState();
  }

  void onChangeOTP(String text, int index) {}

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
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 32),
                      child: GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: otpList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 2.8,
                          children: List.generate(otpList.length, (index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 27),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                  color: Color(0xFFEDEDED)),
                              child: TextFormField(
                                autofocus: true,
                                cursorWidth: 0,
                                cursorHeight: 0,
                                initialValue: otpList[index],
                                onChanged: (value) => onChangeOTP(value, index),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            );
                          })))
                ],
              )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(color: Color(0xFF002DE3), fontSize: 16),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/create_profile');
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
