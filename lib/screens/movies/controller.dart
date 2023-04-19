import 'dart:convert';
import 'dart:developer';

import 'package:flutter_training/screens/movies/model/genres_model.dart';
import 'package:flutter_training/screens/movies/model/movie_detail.dart';
import 'package:flutter_training/screens/movies/model/movie_model.dart';
import 'package:flutter_training/screens/movies/states.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  final state = MovieState();
  MovieController();

  @override
  void onInit() async {
    getDataScreen();
    super.onInit();
  }

  Future getDataScreen() async {
    if (state.isLoading.isFalse) {
      setLoading(true);
    }
    Future.delayed(const Duration(seconds: 1), () {
      MovieProvier provier = MovieProvier();
      final response = Future.wait([
        provier.fetchAndSetMovies(),
        provier.fetchAndSetGenres(),
        provier.fetchAndSetMovies(),
      ]);
      response.then(
        (value) {
          setMovies(value[0].cast<Movie>().toList());
          setGenres(value[1].cast<GenresModel>().toList());
          setUpcoming(value[2].cast<Movie>().toList());
          setLoading(false);
        },
      );
    });
  }

  void setMovies(List<Movie> movies) {
    state.movieList = movies;
  }

  void setGenres(List<GenresModel> genres) {
    state.genres = genres;
  }

  void setUpcoming(List<Movie> movies) {
    state.comingUpMovieList = movies;
  }

  void setLoading(bool loading) {
    state.isLoading.value = loading;
  }
}

class MovieProvier extends GetConnect {
  Future<List<Movie>> fetchAndSetMovies() async {
    String url =
        'https://api.themoviedb.org/3/trending/movie/day?api_key=4b83f0bd6f5b73e2836569825c92af2c';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return <Movie>[];
      }
      final List<Movie> loadedRecipes = [];
      extractedData["results"].forEach((recipeData) {
        loadedRecipes.add(Movie(
          id: recipeData['id'],
          title: recipeData['title'],
          backdropPath: recipeData['backdrop_path'],
          voteAverage: recipeData['vote_average'],
          originalTitle: recipeData['original_title'],
          posterPath: recipeData['poster_path'],
          overview: recipeData['overview'],
          adult: recipeData['adult'],
          releaseDate: recipeData['release_date'],
        ));
      });
      return loadedRecipes;
    } catch (error) {
      log(error.toString());
    }
    return <Movie>[];
  }

  Future<List<GenresModel>> fetchAndSetGenres() async {
    const url =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=4b83f0bd6f5b73e2836569825c92af2c';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return <GenresModel>[];
      }
      final List<GenresModel> loadedGenres = [];
      extractedData["genres"].forEach((recipeData) {
        loadedGenres.add(GenresModel(
          id: recipeData['id'],
          name: recipeData['name'],
        ));
      });
      return loadedGenres;
    } catch (error) {
      log(error.toString());
    }
    return <GenresModel>[];
  }

  Future<List<Movie>?> fetchMoviesByKeyword(String keyword) async {
    String url =
        "https://api.themoviedb.org/3/search/movie?api_key=4b83f0bd6f5b73e2836569825c92af2c&language=en-US&query=$keyword&page=1&include_adult=true";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return null;
      }
      final List<Movie> loadedRecipes = [];
      extractedData["results"].forEach((recipeData) {
        loadedRecipes.add(Movie(
          id: recipeData['id'],
          title: recipeData['title'],
          backdropPath: recipeData['backdrop_path'],
          voteAverage: recipeData['vote_average'],
          originalTitle: recipeData['original_title'],
          posterPath: recipeData['poster_path'],
          overview: recipeData['overview'],
          adult: recipeData['adult'],
          releaseDate: recipeData['release_date'],
        ));
      });
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<void> fetchMoviesDetails(int id) async {
    String url =
        "https://api.themoviedb.org/3/movie/$id?api_key=4b83f0bd6f5b73e2836569825c92af2c&language=en-US";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      MovieDetail(
        id: extractedData['id'],
        title: extractedData['title'],
        backdropPath: extractedData['backdrop_path'],
        voteAverage: extractedData['vote_average'],
        originalTitle: extractedData['original_title'],
        posterPath: extractedData['poster_path'],
        overview: extractedData['overview'],
        adult: extractedData['adult'],
        releaseDate: extractedData['release_date'],
        // genres: List<Genres>.from(jsonDecode(extractedData['genres']))
        //     .map((e) => Genres.fromJson(e as Map<String, dynamic>))
        //     .toList(),
        // belongsToCollection: jsonDecode(extractedData['belongs_to_collection']),
      );
    } catch (error) {
      log(error.toString());
    }
  }
}
