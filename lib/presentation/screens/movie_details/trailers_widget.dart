import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/presentation/bloc/movie_videos/movie_videos_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/button.dart';
import 'package:moviecorn/presentation/screens/watch_video/movie_video_arguments.dart';
import 'package:moviecorn/presentation/screens/watch_video/watch_video_screen.dart';

class TrailersWidget extends StatelessWidget {
  const TrailersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieVideosBloc, MovieVideosState>(
      builder: (context, state) {
        if (state is MovieVideosLoaded) {
          if (state.videos.isEmpty) {
            return const SizedBox(
              child: Text("No Videos Found"),
            );
          }
          return Button(
            title: TranslationsConstants.favouriteMovies,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return WatchVideoScreen(
                      watchVideoArguments:
                          WatchVideoArguments(videos: state.videos),
                    );
                  },
                ),
              );
            },
          );
        }
        return Text("ERROR");
      },
    );
  }
}
