import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_carousel/movie_data_widget.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/movie_app_bar.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/separator.dart';

import 'movie_backdrop_widget.dart';
import 'movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget({
    Key? key,
    required this.movies,
    required this.defaultIndex,
  })  : assert(defaultIndex >= 0, "default index cannot be less than 0"),
        super(key: key);
  final List<MovieEntity> movies;
  final int defaultIndex;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MovieBackdropWidget(),
        Column(
          children: [
            const MovieAppBar(),
            MoviePageView(
              movies: movies,
              initialPage: defaultIndex,
            ),
            const MovieDataWidget(),
            Separator(
              height: Sizes.dimen_1.h.toDouble(),
            ),
          ],
        ),
      ],
    );
  }
}
