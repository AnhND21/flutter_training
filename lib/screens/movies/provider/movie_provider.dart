import 'dart:convert';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movies/model/movie_detail.dart';
import 'package:flutter_training/screens/movies/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbols.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movie = [];
  List<Movie> _movieSearch = [];
  MovieDetail _movieDetails = MovieDetail();

  List<Movie> get movies {
    return [..._movie];
  }

  List<Movie> get movieSearch {
    return [..._movieSearch];
  }

  MovieDetail get movieDetails {
    return _movieDetails;
  }

  Future<Movie?> fetchAndSetMovies() async {
    const url =
        'https://api.themoviedb.org/3/trending/movie/day?api_key=4b83f0bd6f5b73e2836569825c92af2c';
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
      _movie = loadedRecipes;
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
    return null;
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
      _movieSearch = loadedRecipes;
      notifyListeners();
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

      _movieDetails = MovieDetail(
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
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
  }
}
