import 'dart:convert';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movies/model/genres_model.dart';
import 'package:http/http.dart' as http;

class GenredProvider with ChangeNotifier {
  List<GenresModel> _genres = [];

  List<GenresModel> get genres {
    return [..._genres];
  }

  Future<GenresModel?> fetchAndSetGenres() async {
    const url =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=4b83f0bd6f5b73e2836569825c92af2c';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return null;
      }
      final List<GenresModel> loadedGenres = [];
      extractedData["genres"].forEach((recipeData) {
        loadedGenres.add(GenresModel(
          id: recipeData['id'],
          name: recipeData['name'],
        ));
      });
      _genres = loadedGenres;
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
    return null;
  }
}
