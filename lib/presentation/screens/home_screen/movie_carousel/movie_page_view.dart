import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_carousel/movie_card_widget.dart';

import 'animated_movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  const MoviePageView({
    Key? key,
    required this.initialPage,
    required this.movies,
  }) : super(key: key);
  final int initialPage;
  final List<MovieEntity> movies;

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Sizes.dimen_10.h.toDouble(),
      ),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies[index];
          return AnimatedMovieCardWidget(
            movieId: movie.id,
            posterPath: movie.posterPath,
            pageController: pageController,
            index: index,
          );
        },
        pageSnapping: true,
        itemCount: widget.movies.length,
        onPageChanged: (index) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(MovieBackdropChangedEvent(movie: widget.movies[index]));
        },
      ),
    );
  }
}
