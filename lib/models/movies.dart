// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movies {
  String movieName = '';
  String imdb = "";
  String thumbnail = '';
  Movies({
    required this.movieName,
    required this.imdb,
    required this.thumbnail,
  });

  Movies copyWith({
    String? movieName,
    String? imdb,
    String? thumbnail,
  }) {
    return Movies(
      movieName: movieName ?? this.movieName,
      imdb: imdb ?? this.imdb,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieName': movieName,
      'imdb': imdb,
      'thumbnail': thumbnail,
    };
  }

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      movieName: map['movieName'] as String,
      imdb: map['imdb'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }
}
