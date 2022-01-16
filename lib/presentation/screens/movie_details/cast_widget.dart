import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/presentation/bloc/cast/cast_bloc.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          return SizedBox(
            height: Sizes.dimen_105.h.toDouble(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.movieCast.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final castEntity = state.movieCast[index];
                return SizedBox(
                  height: Sizes.dimen_100.h.toDouble(),
                  width: Sizes.dimen_160.w.toDouble(),
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_8.w.toDouble(),
                      vertical: Sizes.dimen_4.h.toDouble(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Sizes.dimen_8.w.toDouble(),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                8.w.toDouble(),
                              ),
                            ),
                            child: CachedNetworkImage(
                              height: Sizes.dimen_100.h.toDouble(),
                              width: Sizes.dimen_160.w.toDouble(),
                              fit: BoxFit.fitWidth,
                              imageUrl:
                                  "${ApiConstants.baseImageUrl}${castEntity.posterPath}",
                            ),
                          ),
                        ),
                        Text(
                          castEntity.name,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.vulcanBodyText2,
                        ),
                        Text(
                          castEntity.character,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text("Cannot fetch cast"),
        );
      },
    );
  }
}
