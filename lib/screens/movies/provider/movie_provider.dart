import 'dart:convert';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movies/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List<Movie> _movie = [];

  List<Movie> get movies {
    return [..._movie];
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
      extractedData["recipes"].forEach((recipeData) {
        loadedRecipes.add(Movie(
            id: recipeData['id'],
            title: recipeData['title'],
            backdropPath: recipeData['backdropPath']));
      });
      _movie = loadedRecipes;
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
    return null;
  }
}
