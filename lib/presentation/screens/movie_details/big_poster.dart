import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/num_extensions.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/data/core/api_constants.dart';

import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

import 'movie_detail_app_bar.dart';

class BigPoster extends StatelessWidget {
  const BigPoster({
    Key? key,
    required this.movieDetailEntity,
  }) : super(key: key);
  final MovieDetailEntity movieDetailEntity;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtil.screenHeight * 0.65,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.3),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "${ApiConstants.baseImageUrl}${movieDetailEntity.posterPath!}",
                width: ScreenUtil.screenWidth,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: ListTile(
                title: Text(
                  movieDetailEntity.title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  movieDetailEntity.releaseDate!,
                  style: Theme.of(context).textTheme.greySubtitle1,
                ),
                trailing: Text(
                  movieDetailEntity.voteAverage!.convertToPercentageString(),
                  style: Theme.of(context).textTheme.violetHeadline6,
                ),
              ),
              left: 0,
              right: 0,
              bottom: 0,
            ),
            Positioned(
              left: Sizes.dimen_16.w.toDouble(),
              right: Sizes.dimen_16.w.toDouble(),
              child: const MovieDetailAppBar(),
            )
          ],
        ),
      ),
    );
  }
}
