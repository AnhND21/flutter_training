import 'package:flutter_training/models/actor.dart';

class Movies {
  String movieName = '';
  String imdb = "";
  String thumbnail = '';
  String description = '';
  String mainActor = '';
  String category = '';
  int? requireAge = 0;
  List<Actor>? actors = [];

  Movies({
    required this.movieName,
    required this.imdb,
    required this.thumbnail,
    required this.description,
    required this.mainActor,
    required this.category,
    this.requireAge = 0,
    this.actors,
  });
}
