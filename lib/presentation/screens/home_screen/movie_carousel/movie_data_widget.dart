import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';

class MovieDataWidget extends StatelessWidget {
  const MovieDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
      builder: (context, state) {
        if (state is MovieBackdropChanged) {
          return Text(
            state.movie.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return SizedBox(
          child: Text(
            "CANNOT FETCH TITLE",
            style: Theme.of(context).textTheme.headline6,
          ),
        );
      },
    );
  }
}
