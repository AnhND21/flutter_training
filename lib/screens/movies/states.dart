import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_training/models/actor.dart';
import 'package:flutter_training/screens/movies/model/genres_model.dart';
import 'package:flutter_training/screens/movies/model/movie_model.dart';
import 'package:get/get.dart';

class MovieState {
  Rx<CarouselController> buttonCarouselController = CarouselController().obs;
  List<Movie> movieList = <Movie>[].obs;
  List<GenresModel> genres = <GenresModel>[].obs;
  List<Movie> comingUpMovieList = <Movie>[].obs;
  final List<Actor> actorList = <Actor>[].obs;
  final RxBool isLoading = true.obs;
  final RxString name = 'DuyAnh'.obs;
}
