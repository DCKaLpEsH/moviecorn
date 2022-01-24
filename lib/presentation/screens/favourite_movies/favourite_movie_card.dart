import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/route_constants.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';

import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_screen.dart';

class FavouriteMovieCard extends StatelessWidget {
  const FavouriteMovieCard({
    Key? key,
    required this.entity,
  }) : super(key: key);
  final MovieEntity entity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteConstants.movieDetail,
          arguments: MovieDetailArguments(movieId: entity.id),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "${ApiConstants.baseImageUrl}${entity.posterPath}",
            ),
          ),
          borderRadius: BorderRadius.circular(
            Sizes.dimen_10.h.toDouble(),
          ),
        ),
        alignment: Alignment.topRight,
        child: IconButton(
          splashRadius: 0.1,
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context).add(
              DeleteFavoriteMovieEvent(
                entity.id,
              ),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
