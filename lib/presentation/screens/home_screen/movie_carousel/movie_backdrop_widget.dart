import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';

class MovieBackdropWidget extends StatelessWidget {
  const MovieBackdropWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            Sizes.dimen_40.w.toDouble(),
          ),
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
                builder: (context, state) {
                  if (state is MovieBackdropChanged) {
                    return CachedNetworkImage(
                      imageUrl:
                          "${ApiConstants.baseImageUrl}${state.movie.backdropPath}",
                      fit: BoxFit.fitHeight,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: ScreenUtil.screenWidth,
                  height: 1,
                  color: Colors.transparent,
                )),
          ],
        ),
      ),
    );
  }
}
