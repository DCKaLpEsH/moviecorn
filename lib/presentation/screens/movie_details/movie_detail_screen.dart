import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/di/get_it.dart';
import 'package:moviecorn/presentation/bloc/cast/cast_bloc.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/bloc/movie_videos/movie_videos_bloc.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/trailers_widget.dart';

import 'big_poster.dart';
import 'cast_widget.dart';
import 'movie_detail_app_bar.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments,
  })  : assert(movieDetailArguments != null, "arguments should not be null"),
        super(key: key);
  final MovieDetailArguments movieDetailArguments;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc movieDetailBloc;
  late CastBloc castBloc;
  late MovieVideosBloc movieVideosBloc;
  late FavoriteBloc favoriteBloc;
  @override
  void initState() {
    super.initState();
    movieDetailBloc = getItInstance<MovieDetailBloc>();
    movieDetailBloc.add(
      MovieDetailLoadEvent(
        movieId: widget.movieDetailArguments.movieId,
      ),
    );
    castBloc = getItInstance<CastBloc>();
    castBloc.add(
      LoadCastEvent(id: widget.movieDetailArguments.movieId),
    );
    movieVideosBloc = getItInstance<MovieVideosBloc>();
    movieVideosBloc.add(
      MovieVideosLoadingEvent(movieId: widget.movieDetailArguments.movieId),
    );
    favoriteBloc = getItInstance<FavoriteBloc>();
    favoriteBloc
        .add(CheckIfFavoriteMovieEvent(widget.movieDetailArguments.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc.close();
    castBloc.close();
    movieVideosBloc.close();
    favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => movieDetailBloc,
          ),
          BlocProvider(
            create: (context) => castBloc,
          ),
          BlocProvider(
            create: (context) => movieVideosBloc,
          ),
          BlocProvider(
            create: (context) => favoriteBloc,
          ),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movieDetailEntity: state.movieDetailEntity,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w.toDouble(),
                        vertical: Sizes.dimen_8.h.toDouble(),
                      ),
                      child: Text(
                        state.movieDetailEntity.overview!,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w.toDouble(),
                        vertical: Sizes.dimen_8.h.toDouble(),
                      ),
                      child: Text(
                        TranslationsConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const CastWidget(),
                    const TrailersWidget(),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
