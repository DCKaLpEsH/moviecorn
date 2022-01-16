// To parse this JSON data, do
//
//     final movieCastModel = movieCastModelFromJson(jsonString);

import 'dart:convert';

import 'package:moviecorn/domain/entities/movie_cast_entity.dart';

class MovieCastModel {
  MovieCastModel({
    this.id,
    required this.cast,
    this.crew,
  });

  int? id;
  List<CastModel> cast;
  List<CastModel>? crew;

  factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        id: json["id"],
        cast: List<CastModel>.from(
            json["cast"].map((x) => CastModel.fromJson(x))),
        crew: List<CastModel>.from(
            json["crew"].map((x) => CastModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
      };
}

class CastModel extends MovieCastEntity {
  CastModel({
    required this.name,
    required this.posterPath,
    required this.creditId,
    required this.character,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.castId,
    this.order,
    this.department,
    this.job,
  }) : super(
          name: name,
          posterPath: posterPath,
          character: character,
          creditId: creditId,
        );

  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String name;
  final String? originalName;
  final double? popularity;
  final String posterPath;
  final int? castId;
  final String character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["profile_path"] ?? "profilepath",
        castId: json["cast_id"] ?? 00,
        character: json["character"] ?? "Character not found",
        creditId: json["credit_id"],
        order: json["order"] ?? 00,
        department: json["department"] ?? "Department not found",
        job: json["job"] ?? "Job not found",
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": posterPath,
        "cast_id": castId ?? "castId not found",
        "character": character,
        "credit_id": creditId,
        "order": order ?? "order not found",
        "department": department ?? "department not found",
        "job": job ?? "job not found",
      };
  @override
  List<Object?> get props => [name, posterPath, character, creditId];
}
