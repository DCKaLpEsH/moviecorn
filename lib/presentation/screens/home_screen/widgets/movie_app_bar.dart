import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/logo.dart';
import 'package:moviecorn/presentation/screens/movie_search/custom_movie_search.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w.toDouble(),
        right: Sizes.dimen_16.w.toDouble(),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              "assets/svgs/menu.svg",
            ),
          ),
          const Expanded(
            child: Logo(
              height: Sizes.dimen_12,
            ),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  BlocProvider.of<MovieSearchBloc>(context),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              size: Sizes.dimen_12.h.toDouble(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
