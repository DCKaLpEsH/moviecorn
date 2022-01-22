import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';

import 'favourite_movie_card.dart';

class FavouriteMoviesGrid extends StatelessWidget {
  const FavouriteMoviesGrid({
    required this.movies,
    Key? key,
  }) : super(key: key);
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Sizes.dimen_4.h.toDouble(),
        crossAxisSpacing: Sizes.dimen_20.w.toDouble(),
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return FavouriteMovieCard(entity: movie);
      },
      itemCount: movies.length,
    );
  }
}
