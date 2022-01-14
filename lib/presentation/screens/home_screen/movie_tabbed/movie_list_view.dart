import 'package:flutter/material.dart';

import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_carousel/movie_card_widget.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_tabbed/movie_tabbed_card_widget.dart';

class MoviesListViewBuilder extends StatelessWidget {
  const MoviesListViewBuilder({
    Key? key,
    required this.movies,
  }) : super(key: key);
  final List<MovieEntity> movies;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h.toDouble(),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return MovieTabCardWidget(
            movieId: movies[index].id,
            title: movies[index].title,
            posterPath: movies[index].posterPath,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 14.w.toDouble(),
          );
        },
        itemCount: movies.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
