import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key? key,
    required this.movieId,
    required this.posterPath,
  }) : super(key: key);
  final int movieId;
  final String posterPath;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        Sizes.dimen_16.w.toDouble(),
      ),
      elevation: 32,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      movieDetailArguments: MovieDetailArguments(
                        movieId: movieId,
                      ),
                    )),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            Sizes.dimen_16.w.toDouble(),
          ),
          child: CachedNetworkImage(
            imageUrl: "${ApiConstants.baseImageUrl}$posterPath",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
