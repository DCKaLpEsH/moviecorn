import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_screen.dart';

class MovieTabCardWidget extends StatelessWidget {
  const MovieTabCardWidget({
    Key? key,
    required this.movieId,
    required this.title,
    required this.posterPath,
  }) : super(key: key);

  final int movieId;
  final String title;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Sizes.dimen_16.w.toDouble(),
              ),
              child: CachedNetworkImage(
                imageUrl: "${ApiConstants.baseImageUrl}$posterPath",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Sizes.dimen_4.h.toDouble(),
            ),
            child: Text(
              title.intelliTrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
