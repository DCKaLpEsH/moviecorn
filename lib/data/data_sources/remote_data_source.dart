import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviecorn/data/core/api_client.dart';
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/data/models/movie_cast_model.dart';
import 'package:moviecorn/data/models/movie_detail_model.dart';
import 'package:moviecorn/data/models/movie_model.dart';
import 'package:moviecorn/data/models/movie_vidoes_model.dart';
import 'package:moviecorn/data/models/movies_result_model.dart.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/domain/usecases/get_movie_cast.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getMovieCast(int id);
  Future<List<MovieVideoModel>> getMovieVideos(int id);
  Future<List<MovieModel>> getSearchedMovie(String searchTerm);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);
  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get("trending/movie/day");
    print("TRENDING ${MoviesResultModel.fromJson(response).movies}");

    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get("movie/popular");
    print("POPULAR ${MoviesResultModel.fromJson(response).movies}");
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get("movie/now_playing");
    print("PLAYING NOW ${MoviesResultModel.fromJson(response).movies}");
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _client.get("movie/upcoming");
    print("COMING SOON ${MoviesResultModel.fromJson(response).movies}");
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get("movie/$id");
    print("MOVIE DETAIL : ${MovieDetailModel.fromJson(response).title}");
    return MovieDetailModel.fromJson(response);
  }

  @override
  Future<List<CastModel>> getMovieCast(int id) async {
    final response = await _client.get("movie/$id/credits");
    print("MOVIE CAST : ${MovieCastModel.fromJson(response).cast[0].name}");
    return MovieCastModel.fromJson(response).cast;
  }

  @override
  Future<List<MovieVideoModel>> getMovieVideos(int id) async {
    final response = await _client.get("movie/$id/videos");
    print(
        "VIDEOS : ${MovieTrailerModel.fromJson(response).results.first.name}");
    return MovieTrailerModel.fromJson(response).results;
  }

  @override
  Future<List<MovieModel>> getSearchedMovie(String searchTerm) async {
    final response = await _client.get(
      "search/movie",
      params: {
        "query": searchTerm,
      },
    );
    print(
        "SEARCHED : ${MoviesResultModel.fromJson(response).movies.first.name}");
    return MoviesResultModel.fromJson(response).movies;
  }
}
