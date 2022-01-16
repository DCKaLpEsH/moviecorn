import 'package:moviecorn/domain/entities/movie_entity.dart';

import 'movies_result_model.dart.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    this.video,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    this.adult,
    this.genreIds,
    this.voteCount,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.mediaType,
    this.originalName,
    this.originCountry,
    this.name,
    this.firstAirDate,
  }) : super(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate);

  final bool? video;
  final double voteAverage;
  final String overview;
  final String releaseDate;
  final bool? adult;
  final String backdropPath;
  final List<int>? genreIds;
  final int id;
  final int? voteCount;
  final OriginalLanguage? originalLanguage;
  final String? originalTitle;
  final String posterPath;
  final String title;
  final double? popularity;
  final MediaType? mediaType;
  final String? originalName;
  final List<String>? originCountry;
  final String? name;
  final String? firstAirDate;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        video: json["video"] ?? false,
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"],
        id: json["id"],
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        originalTitle: json["original_title"] ?? "Original Title",
        posterPath: json["poster_path"] ?? "",
        title: json["title"] ?? "Title",
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map![json["media_type"]],
        originalName: json["original_name"] ?? "Original Name",
        originCountry: json["origin_country"] ?? [],
        name: json["name"] ?? "Name",
        firstAirDate: json["first_air_date"],
      );

  Map<String, dynamic> toJson() => {
        "video": video ?? false,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate,
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "vote_count": voteCount,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle ?? "Original Title",
        "poster_path": posterPath,
        "title": title,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "original_name": originalName ?? "Original Name",
        "origin_country":
            originCountry ?? List<dynamic>.from(originCountry!.map((x) => x)),
        "name": name ?? "Name",
        "first_air_date": firstAirDate ?? "First Air Date",
      };
}

enum OriginalLanguage { EN, ES, IT }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "it": OriginalLanguage.IT
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});
