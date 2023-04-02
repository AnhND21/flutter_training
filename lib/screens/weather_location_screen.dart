import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/models/location.dart';
import 'package:flutter_training/screens/weather_screen.dart';

class WeatherLocationScreen extends StatefulWidget {
  const WeatherLocationScreen({super.key});

  @override
  State<WeatherLocationScreen> createState() => _WeatherLocationScreenState();
}

class _WeatherLocationScreenState extends State<WeatherLocationScreen> {
  List lstLocation = [];

  @override
  void initState() {
    super.initState();
    lstLocation.addAll([
      Location(
          cityName: "Hanoi",
          tempMax: 18.0,
          tempMin: 11.0,
          desciption: 'Mưa to'),
      Location(
          cityName: "Jakarta",
          tempMax: 22.0,
          tempMin: 11.0,
          desciption: 'Mưa bé tí'),
      Location(
          cityName: "London",
          tempMax: 38.0,
          tempMin: 31.0,
          desciption: 'Nắng vỡ đầu'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as WeatherArguments;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              gradient: LinearGradient(colors: [
                Color(0xFF60B6F4),
                Color(0xFF2C79C1),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
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
                      'Manage location',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: TextFormField(
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    hintText: 'Search your city',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.separated(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      params.callBack(lstLocation[index].cityName, index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      lstLocation[index].cityName,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    params.city == lstLocation[index].cityName
                                        ? const Icon(
                                            Icons.pin_drop_outlined,
                                            size: 16,
                                          )
                                        : Container()
                                  ],
                                ),
                                const Text(
                                  '20°/22°',
                                  style: TextStyle(
                                      height: 1.2,
                                      fontSize: 15,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            alignment: Alignment.centerRight,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    CupertinoIcons.sun_dust,
                                    size: 30,
                                  ),
                                  Text(
                                    lstLocation[index].desciption,
                                    style: const TextStyle(
                                        height: 1.5,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 16,
                  );
                },
                itemCount: lstLocation.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
