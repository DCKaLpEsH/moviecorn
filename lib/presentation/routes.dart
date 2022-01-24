import 'package:flutter/cupertino.dart';
import 'package:moviecorn/common/constants/route_constants.dart';
import 'package:moviecorn/presentation/screens/favourite_movies/favourite_movies_screen.dart';
import 'package:moviecorn/presentation/screens/home_screen/home_screen.dart';
import 'package:moviecorn/presentation/screens/loading/loading_screen.dart';
import 'package:moviecorn/presentation/screens/login_screen/login_screen.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_arguments.dart';
import 'package:moviecorn/presentation/screens/movie_details/movie_detail_screen.dart';
import 'package:moviecorn/presentation/screens/watch_video/movie_video_arguments.dart';
import 'package:moviecorn/presentation/screens/watch_video/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteConstants.initial: (context) => const LoginScreen(),
        RouteConstants.home: (context) => const HomeScreen(),
        RouteConstants.favourite: (context) => const FavouriteMoviesScreen(),
        RouteConstants.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: settings.arguments as WatchVideoArguments,
            ),
        RouteConstants.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: settings.arguments as MovieDetailArguments,
            ),
      };
}
