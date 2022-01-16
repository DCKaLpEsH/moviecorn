import 'package:moviecorn/domain/entities/movie_videos_entity.dart';

class WatchVideoArguments {
  List<MovieVideosEntity> videos;
  WatchVideoArguments({
    required this.videos,
  });
}
