import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/di/get_it.dart';
import 'package:moviecorn/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';

import 'big_poster.dart';
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
  @override
  void initState() {
    super.initState();
    movieDetailBloc = getItInstance<MovieDetailBloc>();
    movieDetailBloc.add(
      MovieDetailLoadEvent(
        movieId: widget.movieDetailArguments.movieId,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return Column(
                children: [
                  BigPoster(
                    movieDetailEntity: state.movieDetailEntity,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_16.w.toDouble(),
                    ),
                    child: Text(
                      state.movieDetailEntity.overview!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
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
