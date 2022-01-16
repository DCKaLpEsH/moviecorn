import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/data/core/api_constants.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_screen.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

class SearchMovieCard extends StatelessWidget {
  const SearchMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieEntity movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MovieDetailScreen(
                movieDetailArguments: MovieDetailArguments(
                  movieId: movie.id,
                ),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_16.w.toDouble(),
          vertical: Sizes.dimen_2.h.toDouble(),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(
                Sizes.dimen_8.w.toDouble(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Sizes.dimen_4.w.toDouble(),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${ApiConstants.baseImageUrl}${movie.posterPath}",
                  width: Sizes.dimen_80.w.toDouble(),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    movie.overview ?? "Movie Overview",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.greyCaption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
