import 'package:flutter_training/models/actor.dart';

class UpcomingMovie {
  String movieName = '';
  String imdb = "";
  String thumbnail = '';
  String? description = '';
  String mainActor = '';
  String category = '';
  int? requireAge;
  List<Actor>? actors = [];

  UpcomingMovie({
    required this.movieName,
    required this.imdb,
    required this.thumbnail,
    required this.mainActor,
    required this.category,
    this.description,
    this.requireAge,
    this.actors,
  });
}
