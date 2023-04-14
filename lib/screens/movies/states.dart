import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_training/models/actor.dart';
import 'package:flutter_training/models/movies.dart';
import 'package:flutter_training/models/upcoming_movie.dart';
import 'package:get/get.dart';

class MovieState {
  Rx<CarouselController> buttonCarouselController = CarouselController().obs;
  final List<Movies> movieList = <Movies>[].obs;
  final List<UpcomingMovie> comingUpMovieList = <UpcomingMovie>[].obs;
  final List<Actor> actorList = <Actor>[].obs;
  final RxBool c = false.obs;
}
