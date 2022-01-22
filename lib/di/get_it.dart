import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:moviecorn/data/core/api_client.dart';
import 'package:moviecorn/data/data_sources/language_local_data_source.dart';
import 'package:moviecorn/data/data_sources/movie_local_data_source.dart';
import 'package:moviecorn/data/data_sources/remote_data_source.dart';
import 'package:moviecorn/data/repositories/movie_repository_impl.dart';
import 'package:moviecorn/domain/repositories/local_app_repository.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';
import 'package:moviecorn/domain/usecases/check_movie_fav.dart';
import 'package:moviecorn/domain/usecases/delete_fav_movie.dart';
import 'package:moviecorn/domain/usecases/get_coming_soon.dart';
import 'package:moviecorn/domain/usecases/get_fav_movie.dart';
import 'package:moviecorn/domain/usecases/get_movie_cast.dart';
import 'package:moviecorn/domain/usecases/get_movie_detail.dart';
import 'package:moviecorn/domain/usecases/get_movie_videos.dart';
import 'package:moviecorn/domain/usecases/get_playing_now.dart';
import 'package:moviecorn/domain/usecases/get_popular.dart';
import 'package:moviecorn/domain/usecases/get_preferred_language.dart';
import 'package:moviecorn/domain/usecases/get_searched_movies.dart';
import 'package:moviecorn/domain/usecases/get_trending.dart';
import 'package:moviecorn/domain/usecases/save_movie.dart';
import 'package:moviecorn/domain/usecases/update_language.dart';
import 'package:moviecorn/presentation/bloc/cast/cast_bloc.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:moviecorn/presentation/bloc/language/language_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_carousel/movie_caruosel_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_videos/movie_videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(),
  );
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(),
  );

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<GetMovieCast>(() => GetMovieCast(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieVideos>(
      () => GetMovieVideos(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedMovies>(
      () => GetSearchedMovies(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfMovieFavourite>(
      () => CheckIfMovieFavourite(getItInstance()));
  getItInstance.registerLazySingleton<GetFavouriteMovies>(
      () => GetFavouriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavouriteMovie>(
      () => DeleteFavouriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredLanguage>(
    () => GetPreferredLanguage(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<UpdateLanguage>(
    () => UpdateLanguage(
      getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getItInstance(),
      getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      languageLocalDataSource: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieBackdropBloc(),
  );
  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<LanguageBloc>(
    LanguageBloc(
      getPreferredLanguage: getItInstance(),
      updateLanguage: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => CastBloc(
      getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      favoriteBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieVideosBloc(
      getMovieVideos: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieSearchBloc(getItInstance()),
  );
  getItInstance.registerFactory(
    () => FavoriteBloc(
      getItInstance(),
      getItInstance(),
      getItInstance(),
      getItInstance(),
    ),
  );
}
