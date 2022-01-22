import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({
    Key? key,
    required this.movieDetailEntity,
  }) : super(key: key);
  final MovieDetailEntity movieDetailEntity;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: Sizes.dimen_12.h.toDouble(),
        ),
      ),
      BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
        if (state is IsFavoriteMovie) {
          print(state.isFavorite);
          return GestureDetector(
            onTap: () {
              print("Save pressed");
              BlocProvider.of<FavoriteBloc>(context).add(
                ToggleFavoriteMovieEvent(
                  MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                  state.isFavorite,
                ),
              );
            },
            child: Icon(
              state.isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
              color: Colors.white,
              size: Sizes.dimen_12.h.toDouble(),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    ]);
  }
}
