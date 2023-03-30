import 'dart:convert';
import 'dart:developer';
import 'package:flutter_training/models/weather_hour.dart';
import 'package:intl/intl.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherArguments {
  final String city;
  final Function callBack;

  WeatherArguments(this.city, this.callBack);
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isShowForcats = false;
  bool _enabled = false;
  late WeatherModel weatherData;
  late WeatherHourModel hourWeatherData;
  bool _isLoading = true;
  String city = 'Hanoi';
  int _index = 0;
  final client = http.Client();
  @override
  void initState() {
    super.initState();
    getDataWeather();
  }

  void showForcats() {
    setState(() {
      _isShowForcats = !_isShowForcats;
      _enabled = !_enabled;
    });
  }

  Future<dynamic> getDataWeather() async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=4eb1fd9074be5aef0de39ca3df98800e&units=metric',
    );
    http.Response response = await http.get(url);
    final result = WeatherModel.fromJson(jsonDecode(response.body));
    final urlHourWeather = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${result.coord!.lat}&lon=${result.coord!.lon}&cnt=9&appid=4eb1fd9074be5aef0de39ca3df98800e&units=metric");
    http.Response responseHour = await http.get(urlHourWeather);
    final hourData = WeatherHourModel.fromJson(jsonDecode(responseHour.body));
    setState(() {
      weatherData = result;
      hourWeatherData = hourData;
      _isLoading = false;
    });
  }

  void navigateToLocation() {
    Navigator.pushNamed(context, '/weather_location',
        arguments: WeatherArguments(city, callBack));
  }

  void callBack(String cityName, int index) async {
    setState(() {
      city = cityName;
      _isLoading = true;
      _index = index;
    });
    Future.delayed(const Duration(seconds: 1), () => getDataWeather());
  }

  @override
  Widget build(BuildContext context) {
    final dvWidth = MediaQuery.of(context).size.width;
    final dvHeight = MediaQuery.of(context).size.height;
    var date = DateTime.now().day;
    var month = DateFormat('MMM').format(DateTime.now());
    var day = DateFormat("EEEE").format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: dvHeight,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: !_isLoading
                ? [
                    SizeAnimatedWidget(
                      enabled: _enabled,
                      duration: const Duration(milliseconds: 100),
                      values: [
                        Size(dvWidth, dvHeight / 1.42),
                        Size(dvWidth, dvWidth + 40),
                      ],
                      curve: Curves.linear,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(
                            top: kToolbarHeight + 16, left: 16, right: 16),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF60B6F4),
                                  Color(0xFF2C79C1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      navigateToLocation();
                                    },
                                    child: const Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                      size: 36,
                                    )),
                                Column(
                                  children: <Widget>[
                                    Text(city,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600)),
                                    DotsIndicator(
                                      dotsCount: 3,
                                      axis: Axis.horizontal,
                                      decorator: const DotsDecorator(
                                          activeShape: CircleBorder(
                                              side: BorderSide(
                                            width: 1,
                                            color: Colors.white,
                                          )),
                                          color: Colors.white24,
                                          activeColor: Colors.white,
                                          spacing: EdgeInsets.symmetric(
                                              horizontal: 3)),
                                      position: _index.toDouble(),
                                    )
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/weather_setting');
                                    },
                                    child: const Icon(
                                      Icons.more_vert_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                              ],
                            ),
                            Column(
                              children: _enabled
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 32),
                                              child: const Icon(
                                                CupertinoIcons.cloud_sun_rain,
                                                color: Colors.white,
                                                size: 120,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      day,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Container(
                                                      width: 2,
                                                      height: 20,
                                                      color: Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16),
                                                    ),
                                                    Text(
                                                      '$month $date',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      weatherData.main!.temp !=
                                                              null
                                                          ? weatherData
                                                              .main!.temp
                                                              .toInt()
                                                              .toString()
                                                          : '0',
                                                      style: const TextStyle(
                                                        height: 1,
                                                        color: Colors.white,
                                                        fontSize: 80,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 80),
                                                      child: const Text(
                                                        '°',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 26,
                                                            height: 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  weatherData
                                                          .weather!.isNotEmpty
                                                      ? weatherData
                                                          .weather![0].main
                                                          .toString()
                                                      : '',
                                                  style: const TextStyle(
                                                      height: 0.1,
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ]
                                  : [
                                      Container(
                                        margin: const EdgeInsets.only(top: 32),
                                        child: const Icon(
                                          CupertinoIcons.cloud_sun_rain,
                                          color: Colors.white,
                                          size: 180,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                day,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            Container(
                                              width: 2,
                                              height: 20,
                                              color: Colors.white,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "$month $date",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            weatherData.main!.temp != null
                                                ? weatherData.main!.temp
                                                    .toInt()
                                                    .toString()
                                                : '0',
                                            style: const TextStyle(
                                              height: 1,
                                              color: Colors.white,
                                              fontSize: 80,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 80),
                                            child: const Text(
                                              '°',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 26,
                                                  height: 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        weatherData.weather!.isNotEmpty
                                            ? weatherData.weather![0].main
                                                .toString()
                                            : '',
                                        style: const TextStyle(
                                            height: 0.1,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 32, right: 32),
                              margin: const EdgeInsets.only(top: 16),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.white))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: const Icon(
                                                Icons.location_city,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  // ignore: prefer_adjacent_string_concatenation
                                                  weatherData.wind != null
                                                      ? "${weatherData.wind!.speed} km/h"
                                                      : '0 km/h',
                                                  style: const TextStyle(
                                                      height: 1,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const Text('Wind',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: const Icon(
                                                Icons.waves,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  weatherData.main != null
                                                      ? '${weatherData.clouds!.all}%'
                                                      : '0%',
                                                  style: const TextStyle(
                                                      height: 1,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const Text('Chance of rain',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: const Icon(
                                                Icons
                                                    .power_settings_new_outlined,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  weatherData.main != null
                                                      ? '${weatherData.main!.pressure} mbar'
                                                      : '0 mobr',
                                                  style: const TextStyle(
                                                      height: 1,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const Text('Pressure',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: const Icon(
                                                Icons.water_drop_outlined,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  weatherData.main != null
                                                      ? '${weatherData.main!.humidity.toString()}%'
                                                      : '0%',
                                                  style: const TextStyle(
                                                      height: 1,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const Text('Humidity',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: dvWidth,
                      margin: const EdgeInsets.only(top: 16),
                      // padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C79C1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 12),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  day,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 2,
                                  height: 20,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                Text('$month $date',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: dvWidth,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              shrinkWrap: true,
                              itemCount: hourWeatherData.list!.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 24,
                                );
                              },
                              itemBuilder: (context, index) {
                                DateFormat dateFormat =
                                    DateFormat("yyyy-MM-dd HH:mm:ss");
                                DateTime date = dateFormat.parse(hourWeatherData
                                    .list![index].dtTxt
                                    .toString());
                                return Column(
                                  children: <Widget>[
                                    Text(
                                      DateFormat.Hm().format(date).toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          height: 1),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Icon(
                                      CupertinoIcons.cloud_bolt_rain,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${hourWeatherData.list![index].main!.tempMin.toInt()}°/${hourWeatherData.list![index].main!.tempMax.toInt()}°",
                                      style: const TextStyle(
                                          color: Colors.white, height: 1),
                                    ),
                                    Text(
                                      "${hourWeatherData.list![index].clouds!.all.toString()}% rain",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showForcats();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Forcats for 7 Days',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(_isShowForcats
                                ? Icons.keyboard_double_arrow_up
                                : Icons.keyboard_double_arrow_down)
                          ],
                        )),
                    _isShowForcats ? forcatsWidget(context) : Container()
                  ]
                : [
                    SizedBox(
                      height: dvHeight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
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

Widget forcatsWidget(BuildContext context) {
  final dvWidth = MediaQuery.of(context).size.width;
  return Container(
    width: dvWidth,
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Color(0xFF2C79C1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Forcats for 7 Days',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Sunday',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.sun_dust,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('69% rain',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const Text('69°/96°',
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: 5)
      ],
    ),
  );
}
