import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_carousel/movie_card_widget.dart';

class AnimatedMovieCardWidget extends StatelessWidget {
  const AnimatedMovieCardWidget({
    Key? key,
    required this.index,
    required this.movieId,
    required this.posterPath,
    required this.pageController,
  }) : super(key: key);
  final int index;
  final int movieId;
  final String posterPath;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Curves.easeIn.transform(value) *
                  ScreenUtil.screenHeight *
                  0.35,
              width: Sizes.dimen_230.w.toDouble(),
              child: child,
            ),
          );
        } else {
          return SizedBox(
            height: Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                ScreenUtil.screenHeight *
                0.35,
            width: Sizes.dimen_230.w.toDouble(),
            child: child,
          );
        }
      },
      child: MovieCardWidget(movieId: movieId, posterPath: posterPath),
    );
  }
}
