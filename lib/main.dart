import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moviecorn/data/core/api_client.dart';
import 'package:moviecorn/data/data_sources/remote_data_source.dart';
import 'package:moviecorn/data/repositories/movie_repository_impl.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';
import 'package:moviecorn/domain/usecases/get_coming_soon.dart';
import 'package:moviecorn/domain/usecases/get_playing_now.dart';
import 'package:moviecorn/domain/usecases/get_trending.dart';
import 'package:pedantic/pedantic.dart';

import 'di/get_it.dart';
import 'domain/entities/no_params.dart';
import 'di/get_it.dart' as getIt;

void main() async {
  unawaited(getIt.init());
  // ApiClient client = ApiClient(Client());
  // MovieRemoteDataSource movies = MovieRemoteDataSourceImpl(client);
  // MovieRepository repo = MovieRepositoryImpl(movies);
  GetComingSoon trending = getItInstance<GetComingSoon>();
  final Either<AppError, List<MovieEntity>> either = await trending(NoParams());
  either.fold((l) {
    print("Left");
    print(l);
  }, (r) {
    print("List of Movies");
    print("R $r");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
