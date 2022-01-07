// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

import 'movie_model.dart';

MoviesResultModel movieModelFromJson(String str) =>
    MoviesResultModel.fromJson(json.decode(str));

String movieModelToJson(MoviesResultModel data) => json.encode(data.toJson());

class MoviesResultModel {
  MoviesResultModel({
    this.page,
    required this.movies,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  late final List<MovieModel> movies;
  int? totalPages;
  int? totalResults;

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        page: json["page"],
        movies: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
