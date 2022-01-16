import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/data/core/api_client.dart';
import 'package:moviecorn/di/get_it.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/usecases/get_trending.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_carousel/movie_caruosel_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:moviecorn/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_tabbed/movie_list_view.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_tabbed/movie_tabbed_widget.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/movie_app_bar.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_drawer.dart';

import 'movie_carousel/app_error_widget.dart';
import 'movie_carousel/movie_carousel_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackdropBloc movieBackdropBloc;
  late MovieTabbedBloc movieTabbedBloc;
  late MovieSearchBloc movieSearchBloc;
  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
    movieSearchBloc = getItInstance<MovieSearchBloc>();
    movieCarouselBloc.add(CarouselLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCarouselBloc>(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => movieBackdropBloc,
        ),
        BlocProvider(
          create: (context) => movieTabbedBloc,
        ),
        BlocProvider(
          create: (context) => movieSearchBloc,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    child: MovieCarouselWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                  ),
                  const FractionallySizedBox(
                    heightFactor: 0.4,
                    alignment: Alignment.bottomCenter,
                    child: MovieTabbedWidget(),
                  ),
                ],
              );
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                appErrorType: state.appErrorType,
                onPressed: () => movieCarouselBloc.add(
                  CarouselLoadEvent(),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    movieTabbedBloc.close();
    movieSearchBloc.close();
  }
}
