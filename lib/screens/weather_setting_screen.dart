import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WeatherSettingScreen extends StatefulWidget {
  const WeatherSettingScreen({super.key});

  @override
  State<WeatherSettingScreen> createState() => _WeatherSettingScreenState();
}

class _WeatherSettingScreenState extends State<WeatherSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              gradient: LinearGradient(colors: [
                Color(0xFF60B6F4),
                Color(0xFF2C79C1),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 32,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(CupertinoIcons.arrow_left,
                          color: Colors.white),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Setting',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
