// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Weather {
  Object coord = <String, dynamic>{};
  final Object main;
  final Object wind;
  final Object rain;
  final Object clouds;
  final Object sys;
  final String name;
  final int visibility;
  final int dt;
  final List<Object> weather;
  final String base;
  Weather({
    required this.coord,
    required this.main,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.sys,
    required this.name,
    required this.visibility,
    required this.dt,
    required this.weather,
    required this.base,
  });

  @override
  String toString() {
    return 'Weather(coord: $coord, main: $main, wind: $wind, rain: $rain, clouds: $clouds, sys: $sys, name: $name, visibility: $visibility, dt: $dt, weather: $weather, base: $base)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.coord == coord &&
        other.main == main &&
        other.wind == wind &&
        other.rain == rain &&
        other.clouds == clouds &&
        other.sys == sys &&
        other.name == name &&
        other.visibility == visibility &&
        other.dt == dt &&
        other.weather == weather &&
        other.base == base;
  }

  @override
  int get hashCode {
    return coord.hashCode ^
        main.hashCode ^
        wind.hashCode ^
        rain.hashCode ^
        clouds.hashCode ^
        sys.hashCode ^
        name.hashCode ^
        visibility.hashCode ^
        dt.hashCode ^
        weather.hashCode ^
        base.hashCode;
  }
}
