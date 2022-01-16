import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/usecases/get_searched_movies.dart';

import 'package:moviecorn/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_carousel/app_error_widget.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/separator.dart';
import 'package:moviecorn/presentation/screens/movie_search/search_movie_card.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

class CustomSearchDelegate extends SearchDelegate {
  final MovieSearchBloc movieSearchBloc;
  CustomSearchDelegate(
    this.movieSearchBloc,
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.greySubtitle1,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.violet,
        ),
      ),
    ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColors.royalBlue,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("REACHED HERE");
    movieSearchBloc.add(
      MovieSearchingEvent(searchTerm: query),
    );
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      bloc: movieSearchBloc,
      builder: (context, state) {
        if (state is MovieSearchSuccessState) {
          if (state.movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 64.w.toDouble(),
                ),
                child: Text(
                  TranslationsConstants.noMoviesSearched.t(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: state.movies.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SearchMovieCard(movie: state.movies[index]);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_10.w.toDouble(),
                  ),
                  child: const Separator(
                    height: 0.5,
                  ),
                );
              },
            );
          }
        } else if (state is MovieSearchErrorState) {
          return AppErrorWidget(
            appErrorType: state.appErrorType,
            onPressed: () {
              movieSearchBloc.add(
                MovieSearchingEvent(
                  searchTerm: query,
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.violet,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
