// To parse this JSON data, do
//
//     final movieTrailerModel = movieTrailerModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/movie_videos_entity.dart';

MovieTrailerModel movieTrailerModelFromJson(String str) =>
    MovieTrailerModel.fromJson(json.decode(str));

String movieTrailerModelToJson(MovieTrailerModel data) =>
    json.encode(data.toJson());

class MovieTrailerModel {
  MovieTrailerModel({
    required this.id,
    required this.results,
  });

  int id;
  List<MovieVideoModel> results;

  factory MovieTrailerModel.fromJson(Map<String, dynamic> json) =>
      MovieTrailerModel(
        id: json["id"],
        results: List<MovieVideoModel>.from(
            json["results"].map((x) => MovieVideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class MovieVideoModel extends MovieVideosEntity {
  MovieVideoModel({
    this.iso6391,
    this.iso31661,
    required this.name,
    required this.key,
    this.publishedAt,
    this.site,
    this.size,
    required this.type,
    this.official,
    this.id,
  }) : super(name: name, key: key, type: type);

  String? iso6391;
  String? iso31661;
  String name;
  String key;
  DateTime? publishedAt;
  String? site;
  int? size;
  String type;
  bool? official;
  String? id;

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) =>
      MovieVideoModel(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        publishedAt: DateTime.parse(json["published_at"]),
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "published_at": publishedAt!.toIso8601String(),
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "id": id,
      };
}
