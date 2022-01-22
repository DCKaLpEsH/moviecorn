import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/di/get_it.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/usecases/get_fav_movie.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

import 'favourite_movie_card.dart';
import 'favourite_movies_grid.dart';

class FavouriteMoviesScreen extends StatefulWidget {
  const FavouriteMoviesScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteMoviesScreen> createState() => _FavouriteMoviesScreenState();
}

class _FavouriteMoviesScreenState extends State<FavouriteMoviesScreen> {
  late FavoriteBloc favoriteBloc;

  @override
  void initState() {
    super.initState();
    favoriteBloc = getItInstance<FavoriteBloc>();
    favoriteBloc.add(
      LoadFavoriteMovieEvent(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            TranslationsConstants.favouriteMovies.t(context),
            // style: Theme.of(context).textTheme.subtitle1,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_18.w.toDouble(),
          ),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteMovieLoaded) {
                if (state.movieEntity.isEmpty) {
                  return Center(
                    child: Text(
                      TranslationsConstants.noFavoriteMovie.t(context),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
                return FavouriteMoviesGrid(movies: state.movieEntity);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.violet,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
