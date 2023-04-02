import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatWelcomeScreen extends StatelessWidget {
  const ChatWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svgs/chat_splash.svg"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                    child: Text(
                      'Connect easily with your family and friends over countries',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Terms & Privacy Policy',
                    style: TextStyle(color: Colors.black),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login_phone');
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
                    'Start Messaging',
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
      ),
    );
  }
}
